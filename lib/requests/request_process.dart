import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class RequestProcess<T> {
  T? data;
  RequestStatus requestStatus;

  Future<T?>? process;

  bool finished = false;

  RequestStatus Function(RequestProcess<T> processRequest, Object? err)
      resolveStatus;

  final List<Function()> _onProcess = [];

  final List<Function()> _onTryProcess = [];

  final bool lockCall;

  RequestProcess(this.process, this.resolveStatus,
      {this.lockCall = false,
      this.requestStatus = RequestStatus.loading,
      callDirectly = true}) {
    if (callDirectly) {
      tryProcess();
    }
  }

  tryProcess({notify = true}) {
    requestStatus = RequestStatus.loading;
    data = null;
    if (notify) {
      _onTryProcess.forEach((element) {
        element();
      });
    }
    _doProcess();
  }

  bool doingProcess = false;

  _doProcess() async {
    if (doingProcess && lockCall) {
      return;
    }

    doingProcess = true;
    try {
      data = await process;
      requestStatus = getResolveStatus();
      finished = true;
    } catch (err) {
      debugPrint(err.toString());
      data = null;
      requestStatus = resolveStatus(this, err);
      finished = true;
    }
    receivedResponse();
    doingProcess = false;
  }

  getResolveStatus() {
    return resolveStatus(this, null);
  }

  void listenForResponse(Function() function) {
    if (finished) {
      function();
      return;
    }
    _onProcess.add(function);
  }

  void mapResponse(Map<RequestStatus, Function()> map) {
    _onProcess.add(() {
      if (!map.containsKey(requestStatus)) {
        return;
      }
      map[requestStatus]!();
    });
  }

  void receivedResponse() {
    for (var element in _onProcess) {
      element();
    }
  }

  void stopProcess() {
    process!.ignore();
  }

  void onTryProcess(Function() listener) {
    _onTryProcess.add(listener);
  }

  static from(Future call) {
    return RequestProcess(call, StatusResolver.trueResolver);
  }
}

enum RequestStatus {
  empty,
  error,
  invalid,
  success,
  loading,
  timeout,
  frontEndError
}

class RequestStatusActionMapper<T> {
  final Map<RequestStatus, Function(T)> mapper;
  final Function(T)? otherwiseDo;
  final Function(T)? andAlsoDo;

  RequestStatusActionMapper(
      {this.otherwiseDo, this.andAlsoDo, required this.mapper});

  hasActionOf({required RequestStatus status}) {
    return mapper.containsKey(status);
  }

  mapAction({required RequestStatus status, required T data}) {
    if (!mapper.containsKey(status)) {
      if (otherwiseDo != null) {
        otherwiseDo!(data);
      }
    } else {
      mapper[status]!(data);
    }

    if (andAlsoDo != null) {
      andAlsoDo!(data);
    }
  }
}

class StatusResolver {
  static RequestStatus simpleListResolver<T>(
      RequestProcess<T> processRequest, err) {
    if (err != null || processRequest.data == null) {
      return RequestStatus.error;
    }

    if ((processRequest.data as List).isEmpty) {
      return RequestStatus.empty;
    }

    return RequestStatus.success;
  }

  static RequestStatus trueResolver<T>(RequestProcess<T> processRequest, err) {
    return RequestStatus.success;
  }

  static RequestStatus boolResolver(RequestProcess processRequest, err) {
    if (err != null ||
        processRequest.data == null ||
        processRequest.data == false) {
      return RequestStatus.error;
    }

    return RequestStatus.success;
  }

  static RequestStatus requestStatusResolver(
      RequestProcess processRequest, err) {
    debugPrint("erro: " + err.toString());

    if (err == null) {
      int statusCode = processRequest.data?.statusCode ?? 500;
      debugPrint("status code: " + statusCode.toString());
      return mapResponseStatusCode(statusCode);
    }

    if (err is! DioError) {
      return RequestStatus.error;
    }

    if ([
      DioErrorType.connectionTimeout,
      DioErrorType.receiveTimeout,
      DioErrorType.sendTimeout
    ].contains(err.error)) {
      return RequestStatus.timeout;
    }

    processRequest.data.data = (jsonDecode(processRequest.data.data));

    return RequestStatus.invalid;
  }

  static RequestStatus requestListStatusResolver(
      RequestProcess processRequest, err) {
    RequestStatus requestStatus = requestStatusResolver(processRequest, err);

    if (requestStatus == RequestStatus.success) {
      return (processRequest.data.data["documents"] as List).isEmpty
          ? RequestStatus.empty
          : requestStatus;
    }

    return requestStatus;
  }

  static RequestStatus documentsRequestStatusResolver(
      RequestProcess processRequest, err) {
    RequestStatus baseStatus = requestStatusResolver(processRequest, err);

    if (baseStatus == RequestStatus.success) {
      debugPrint(processRequest.data.data.toString());
      if (!processRequest.data.data.containsKey("documents")) {
        return RequestStatus.error;
      }

      bool returnEmpty = processRequest.data.data['documents'] is! List ||
          processRequest.data.data['documents'].isEmpty;

      if (returnEmpty) {
        return RequestStatus.empty;
      }
    }

    return baseStatus;
  }

  static RequestStatus Function(RequestProcess processRequest, Object? err)
      anyResolver(RequestStatus success) {
    return (p, err) => success;
  }
}

mapResponseStatusCode(int statusCode) {
  if (statusCode >= 500) {
    return RequestStatus.error;
  }

  if (statusCode >= 400) {
    return RequestStatus.invalid;
  }

  if (statusCode >= 200) {
    return RequestStatus.success;
  }

  return RequestStatus.error;
}
