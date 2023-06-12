import 'package:framework/requests/widgets/request_view.dart';
import 'package:flutter/material.dart';

import '../../shared_widgets/popups/response_popup.dart';
import '../../shared_widgets/responsive/media_queries.dart';
import '../request_process.dart';

class RequestStatusDisplay extends RequestView {
  final bool useDefaultOnNull;
  final dynamic forceSuccessWidget;
  final Map<RequestStatus, Map<String, dynamic>>? responseInfo;
  final Widget successWidget;

  //final RequestStatus? overridedRequestStatus;

  final EdgeInsets padding;
  final EdgeInsets? responsePadding;
  RequestStatusDisplay(
      {super.key,
      this.responseInfo,
      this.padding = const EdgeInsets.all(0),
      required RequestProcess? processRequest,
      required this.successWidget,
      //this.overridedRequestStatus,
      this.useDefaultOnNull = true,
      this.forceSuccessWidget = false,
      this.responsePadding})
      : super(processRequest: processRequest) {
    debugPrint(forceSuccessWidget.toString());
  }

  @override
  State<RequestStatusDisplay> createState() => _RequestStatusDisplayState();

  @override
  bool isCompatibleWithRequest(RequestProcess requestProcess) {
    return [
      RequestStatus.error,
      RequestStatus.empty,
      RequestStatus.loading,
    ].contains(requestProcess.requestStatus);
  }
}

class _RequestStatusDisplayState extends State<RequestStatusDisplay> {
  final Map<RequestStatus, Map<String, dynamic>> displayInfo = {};

  bool forceSuccess() {
    return (widget.forceSuccessWidget is Function
        ? widget.forceSuccessWidget()
        : widget.forceSuccessWidget);
  }

  @override
  void initState() {
    super.initState();
    if (widget.useDefaultOnNull) {
      Map<RequestStatus, Map<String, dynamic>> defaultInfo =
          getDefaultStatusInfo();
      displayInfo.addAll(defaultInfo);
    }

    debugPrint("init state");

    if (widget.responseInfo != null) {
      displayInfo.addAll(widget.responseInfo!);
    }

    if (widget.processRequest != null) {
      debugPrint("process request");
      widget.processRequest!.onTryProcess(() {
        if (!mounted) return;

        if (forceSuccess()) {
          return;
        }
        setState(() {});
      });

      widget.processRequest!.listenForResponse(() {
        if (!mounted) return;
        debugPrint(widget.processRequest?.requestStatus.toString());
        /*if (forceSuccess()) {
          return;
        }*/
        setState(() {});
      });
    }
  }

  Map<RequestStatus, Map<String, dynamic>> getDefaultStatusInfo() {
    Map<String, dynamic> badResponse = {
      "icon": Icons.error,
      "label": "Ocorreu um erro inesperado.",
    };
    return {
      RequestStatus.empty: {
        "icon": Icons.search,
        "label": "Não encontramos resultado para sua busca.",
      },
      RequestStatus.error: badResponse,
      RequestStatus.invalid: badResponse,
      RequestStatus.loading: {
        "icon": const CircularProgressIndicator(
            value: null, color: Color(0xff93467E)),
        "label": "Aguarde",
      },
      RequestStatus.timeout: {
        "icon": Icons.warning,
        "label": RequestMessage.timeOutMessage().title
      }
    };
  }

  static const double labelPadding = 24;
  @override
  Widget build(BuildContext context) {
    if (widget.processRequest == null ||
        widget.processRequest?.requestStatus == RequestStatus.success ||
        forceSuccess()) {
      return widget.successWidget;
    }

    debugPrint("value for process : " +
        (widget.processRequest?.requestStatus.toString() ?? ""));
    Map<String, dynamic> statusDisplayInfo =
        displayInfo[widget.processRequest?.requestStatus]
            as Map<String, dynamic>;

    Widget displayIcon = getStatusDisplayIcon(statusDisplayInfo);

    return Padding(
      padding: (widget.processRequest?.requestStatus == RequestStatus.success
              ? null
              : widget.responsePadding) ??
          widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          displayIcon,
          Padding(
            padding: EdgeInsets.only(top: labelPadding),
            child: Text(
              statusDisplayInfo["label"] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: isMobile() ? 18 : 24),
            ),
          )
        ],
      ),
    );
  }

  Widget getStatusDisplayIcon(Map<String, dynamic> statusDisplayInfo) {
    late Widget displayIcon;
    if ((statusDisplayInfo['icon'] as Object) is Widget) {
      displayIcon = statusDisplayInfo['icon'];
    } else {
      displayIcon = Icon(
        statusDisplayInfo["icon"] as IconData,
        color: const Color(0xff93467E),
        size: 40,
      );
    }
    return displayIcon;
  }
}
