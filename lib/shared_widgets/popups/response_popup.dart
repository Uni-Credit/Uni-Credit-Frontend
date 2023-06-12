import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/atech/requests/backend_response.dart';
import 'package:framework/requests/request_process.dart';
import 'package:framework/shared_widgets/popups/informative_popup.dart';
import 'package:framework/shared_widgets/popups/loading_popup.dart';

import '../../requests/widgets/request_centered_view.dart';

class ResponsePopup extends StatelessWidget {
  final RequestProcess<BackendResponse> requestProcess;
  final Function()? onClickAfterClose;

  final String? onSuccess;
  final String? onSuccessSubtitle;
  final bool leftDesign;
  final Function(BuildContext, dynamic body)? successBuilder;

  const ResponsePopup({
    required this.requestProcess,
    this.onSuccess = "Confirmado!",
    this.leftDesign = false,
    this.successBuilder,
    this.onSuccessSubtitle,
    this.onClickAfterClose,
    Key? key,
  }) : super(key: key);

  informResult({title, subtitle, success, RequestMessage? requestMessage}) {
    return InformativePopup(
      title: title,
      subtitle: subtitle,
      success: success,
      leftDesign: leftDesign,
      requestMessage: requestMessage,
      onClickAfterClosed: onClickAfterClose,
    );
  }

  static String getResponseMessage(body, {defaultMessage}) {
    defaultMessage ??= "Erro de conexão com o servidor!";
    if (body == null || body is String) {
      return defaultMessage;
    }

    return body['message'] ?? body['error'] ?? defaultMessage;
  }

  getServerErorMessage() {
    return "Houve algum erro de servidor!";
  }

  informByMessageOrUnknown() {
    BackendResponse? response = requestProcess.data;
    var body = response != null ? (response.data) : null;

    String defaultMessage =
        "Reporte para um administrador e tente novamente mais tarde!";
    String defaultTitle = "Um erro ocorreu!";

    if (requestProcess.requestStatus == RequestStatus.success) {
      defaultTitle = onSuccess ?? defaultTitle;
    }
    if (requestProcess.requestStatus == RequestStatus.success &&
        (body == null || body is String)) {
      defaultMessage = onSuccessSubtitle ?? "Ação sucedida!";
    }

    return informResult(
        success: requestProcess.requestStatus == RequestStatus.success,
        title: defaultTitle,
        subtitle: getResponseMessage(body, defaultMessage: defaultMessage));
  }

  @override
  Widget build(BuildContext context) {
    return RequestCenteredView({
      RequestStatus.timeout: (context) =>
          informResult(requestMessage: RequestMessage.timeOutMessage()),
      RequestStatus.error: (context) => informByMessageOrUnknown(),
      RequestStatus.invalid: (context) => informByMessageOrUnknown(),
      RequestStatus.loading: (context) => const LoadingPopup(),
    }, requestProcess, (context) => const LoadingPopup(),
        defaultBuilder: (context) {
      var body = (requestProcess.data!.data);

      if (successBuilder != null) {
        return successBuilder!(context, body);
      }

      //  debugPrint(body.toString());
      if (body != null && body is Map && body.containsKey("title")) {
        return informResult(
            title: body['title'],
            subtitle: body['subtitle'],
            success: body['success']);
      }

      return informByMessageOrUnknown();
    });
    ;
  }
}

class RequestMessage {
  String title;
  String subtitle;
  bool success;

  RequestMessage(
      {required this.title, required this.subtitle, this.success = true});

  static RequestMessage timeOutMessage() {
    return RequestMessage(
        title: "Não foi possível completar a ação!",
        subtitle: "Sua solicitação não foi recebida pelo servidor");
  }
}
