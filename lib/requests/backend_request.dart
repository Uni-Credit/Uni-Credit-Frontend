


import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'backend_response.dart';

class BackendRequest {

 static Future<BackendResponse> Function(T) call<T>({required Dio dio, required String onPath,
   String withMethod='GET',
   Function(T)? extractArgData, Function(Response response)? andThenDo
 }){
    return (T args) async {

      debugPrint('[$withMethod] -> ' + onPath);

      debugPrint('- Extract data from ARGS');
      dynamic data = extractArgData == null? null :  extractArgData(args);

      debugPrint('data from args: ' + data.toString());

      debugPrint('Calling fetch');
      Response response = await dio.
      fetch(RequestOptions(
          path: onPath,
          method: withMethod,
          data: data
      ));


      debugPrint('- Fetch responded');

      debugPrint('response status:' + response.statusCode.toString());
      debugPrint('response data:' + response.data.toString());
      if(andThenDo != null) {
        try {
          andThenDo(response);
        } catch(err) {
          debugPrint('Error happened while processing andThenDo call');
          return BackendResponse(response);
        }
      }

      debugPrint('Finished andThenDo');
      debugPrint('Returning backend response');

      return BackendResponse(response);
    };
   }
}