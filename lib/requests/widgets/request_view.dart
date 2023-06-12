import 'package:flutter/cupertino.dart';

import '../request_process.dart';

abstract class RequestView<T> extends StatefulWidget {
  RequestProcess<T>? processRequest;

  RequestView({required this.processRequest, super.key});

  bool isCompatibleWithRequest(RequestProcess<T> requestProcess);
}
