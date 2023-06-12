import 'package:dio/dio.dart';

import 'arguments/argument_caller.dart';

class RequestCaller<G extends ArgumentCaller, T> {
  Future<T> Function(G) request;
  List<Function(T, G)> onCalledRequest = [];
  G? defaultArgument;

  T? responseInCaseOfException; // Response if request ends with an exception

  RequestCaller(this.request,
      {this.defaultArgument, this.responseInCaseOfException});

  Future<T> call({G? argument}) async {
    argument ??= defaultArgument;

    if (argument == null) {
      throw Exception('Argument passed to Request Caller is null');
    }
    /* if(nextEmptyCachedResponse != null) {
      T cachedResponse = nextEmptyCachedResponse!( );
      nextEmptyCachedResponse = null;
      return cachedResponse;
    }*/

    try {
      return await runRequest(argument);
    } catch (err) {
      if (responseInCaseOfException == null) {
        rethrow;
      }

      return responseInCaseOfException!;
    }
  }

  runRequest(argument) async {
    T result = await request(argument);

    for (Function(T, G) listener in onCalledRequest) {
      listener(result, argument);
    }

    return result;
  }
}
