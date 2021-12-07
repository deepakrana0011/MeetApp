import 'package:dio/dio.dart';

class AuthInterceptor implements InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options,RequestInterceptorHandler handler) async {
   /* bool result = await DataConnectionChecker().hasConnection;
    if (!result) {
      DioError error=DioError();
      error.response=Response(data: {"error": "Please check your internet connection"},
      );
      throw Exception(error);
    }*/
    return options;
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    return err;
    // TODO: implement onError
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    return response;
    // TODO: implement onResponse
  }




}
