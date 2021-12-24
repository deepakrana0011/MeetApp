import 'package:dio/dio.dart';

class AuthInterceptor implements InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options,RequestInterceptorHandler handler) async {

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
