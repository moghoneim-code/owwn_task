import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

const int _duration = 3;
const double _titleSize = 18.0;
const double _messageSize = 16.0;
const Duration _animationDuration = Duration(milliseconds: 500);

showCustomNetworkErrorFlushBar(
    BuildContext context, String? title, String message) {
  Flushbar(
    title: title,
    titleSize: _titleSize,
    message: message,
    messageSize: _messageSize,
    duration: const Duration(seconds: _duration),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.GROUNDED,
    leftBarIndicatorColor: Colors.red,
    icon: const Icon(
      Icons.warning,
      size: 28.0,
      color: Colors.white,
    ),
    textDirection: Directionality.of(context),
    animationDuration: _animationDuration,
  ).show(context);
}

showErrorFlushBar(BuildContext context, String? title, String message) {
  Flushbar(
    title: title,
    titleSize: _titleSize,
    message: message,
    messageSize: _messageSize,
    duration: const Duration(seconds: _duration),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.GROUNDED,
    backgroundColor: Colors.red,
    icon: const Icon(
      Icons.warning,
      size: 28.0,
      color: Colors.white,
    ),
    textDirection: Directionality.of(context),
    animationDuration: _animationDuration,
  ).show(context);
}
