import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

final int _duration = 5;
final double _titleSize = 18.0;
final double _messageSize = 18.0;
final Duration _animationDuration = Duration(milliseconds: 500);

showSuccessFlushBar(BuildContext context, String? title, String message) {
  Flushbar(
    title: title,
    titleSize: _titleSize,
    message: message,
    messageSize: _messageSize,
    duration: Duration(seconds: _duration),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.GROUNDED,
    backgroundColor: Colors.green,
    icon: Icon(
      Icons.check,
      size: 28.0,
      color: Colors.black,
    ),
    textDirection: Directionality.of(context),
    animationDuration: _animationDuration,
  ).show(context);
}
