import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:owwn_coding_challenge/Authentication/Providers/login_provider.dart';
import 'package:owwn_coding_challenge/Network/interceptors/connectivity_interceptor.dart';
import 'package:provider/provider.dart';

Dio baseDioClient(String baseUrl) {
  Dio dio = Dio();
  dio.options = BaseOptions(
    baseUrl: baseUrl,
    headers: {
      'content-type': 'application/json',
      'Accept': 'application/json',
      'X-API-KEY': 'owwn-challenge-22bbdk',
    },
    followRedirects: false,
    validateStatus: (status) => status! >= 200 && status < 300,
  );
  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }
  dio.interceptors.add(ConnectivityInterceptor());
  return dio;
}

Dio dioClientWithRefreshToken(String baseUrl, BuildContext context) {
  Dio dio = Dio();
  dio.options = BaseOptions(
    baseUrl: baseUrl,
    headers: {
      'content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer ${Provider.of<LoginProvider>(context, listen: false).accessToken}',
    },
  );
  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }
  dio.interceptors.add(ConnectivityInterceptor());
  Dio tokenDio = Dio(); //Create a new instance to request the token.
  tokenDio.options = BaseOptions(
    baseUrl: dio.options.baseUrl,
    headers: {
      'content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer ${Provider.of<LoginProvider>(context, listen: false).accessToken}',
    },
  );
  dio.interceptors.add(InterceptorsWrapper(onError: (options, handler) {
    if (options.response?.statusCode == 401) {
    } else {
      handler.next(options);
    }
  }));

  return dio;
}
