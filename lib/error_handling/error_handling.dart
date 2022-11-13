import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:owwn_coding_challenge/Authentication/Screens/login_screen.dart';
import 'package:owwn_coding_challenge/Network/errors/decoding_error.dart';
import 'package:owwn_coding_challenge/Network/errors/dio_exception.dart';
import 'package:owwn_coding_challenge/Network/errors/no_internet_error.dart';
import 'package:owwn_coding_challenge/Network/errors/unauthorized_user.dart';
import 'package:owwn_coding_challenge/error_handling/error_alert.dart';
import 'package:owwn_coding_challenge/error_handling/error_flushbars.dart';
import 'package:owwn_coding_challenge/error_handling/no_internet_alert.dart';

handleError(BuildContext context, Object error, void Function() retryFunction) {
  final String errorMessage = _errorMessage(context, error);

  if (error is UnAuthorizedUser ||
      (error is DioError &&
          error.type == DioErrorType.other &&
          error.error is UnAuthorizedUser)) {
    // UnAuthorized Error - logout
    // UserSessionManager.instance.clearUser();
    showModalBottomSheet(
      context: context,
      builder: (context) => const LoginScreen(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
    return;
  } else if (error is DioError) {
    // log(error.toString());
    if (error.type == DioErrorType.other && error.error is NoInternetError) {
      // No Internet connection
      showNoInternetAlert(context, retryFunction);
      return;
    } else if (error.type == DioErrorType.connectTimeout ||
        error.type == DioErrorType.receiveTimeout ||
        error.type == DioErrorType.sendTimeout) {
      showRetryErrorAlert(
          context: context,
          title: 'Error in connection',
          message: errorMessage,
          retryFunction: retryFunction);
      return;
    }
  }

  displayError(context, error);
}

displayError(BuildContext context, Object error) {
  if (error is DioError &&
      error.response?.statusCode != null &&
      error.response!.statusCode == 400) {
    // Bad Request Error - Message from server

    showCustomNetworkErrorFlushBar(
      context,
      'Error',
      _errorMessage(context, error),
    );
    return;
  } else if (error is DioError && error.response!.statusCode == 403) {
    log("403 error");
    showErrorFlushBar(
      context,
      'Error',
      error.response!.data['message'].toString(),
    );
    return;
  }
}

String _errorMessage(BuildContext context, Object error) {
  if (error is DioError) {
    String errorMessage = DioExceptions.fromDioError(error).toString();

    if (error.response?.statusCode != null) {
      errorMessage = '$errorMessage (${error.response?.statusCode})';

      if (error.response!.statusCode == 400) {
        String message = '';

        if (error.response?.data is List<dynamic>) {
          final arrayMessages = error.response?.data as List<dynamic>;
          for (final element in arrayMessages) {
            message += '$element ';
          }
        } else if (error.response?.data is Map<String, dynamic>) {
          message = error.response!.data['message'].toString();
        } else {
          message = error.response?.data.toString() ?? '';
        }

        return message;
      }
    }

    if (error.type == DioErrorType.other) {
      if (error.error is NoInternetError) {
        return "Connection to internet failed. Please connect to the internet and try again.";
      } else if (error.error is SocketException) {
        return 'This URL doesn\'t exist';
      } else {
        return error.message;
      }
    }

    return errorMessage;
  } else if (error is DecodingError) {
    return 'Error occurred in received data';
  } else {
    return error.toString();
  }
}

String errorData(Response response) {
  String message = response.data['errors'][0].toString();
  return message;
}
