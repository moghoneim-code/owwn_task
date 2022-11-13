import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:owwn_coding_challenge/Network/errors/no_internet_error.dart';

class ConnectivityInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      handler
          .reject(DioError(requestOptions: options, error: NoInternetError()));
    }

    super.onRequest(options, handler);
  }
}
