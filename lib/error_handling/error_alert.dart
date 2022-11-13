import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

showErrorAlert(BuildContext context, String? title, String message) {
  Alert(
    context: context,
    type: AlertType.error,
    title: title,
    desc: message,
    buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context),
        width: 120,
        child: const Text(
          "ok",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      )
    ],
  ).show();
}

showRetryErrorAlert(
    {required BuildContext context,
    String? title,
    required String message,
    void Function()? retryFunction}) {
  Alert(
    context: context,
    style: const AlertStyle(
      animationType: AnimationType.grow,
      isCloseButton: false,
      // isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
    ),
    type: AlertType.error,
    title: title,
    desc: message,
    buttons: [
      DialogButton(
        color: Colors.transparent,
        border: const Border.fromBorderSide(BorderSide(color: Colors.red)),
        onPressed: () => Navigator.pop(context),
        width: 80,
        child: const Text(
          "ok",
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
      ),
      if (retryFunction != null)
        DialogButton(
          color: Colors.transparent,
          border: const Border.fromBorderSide(BorderSide(color: Colors.red)),
          onPressed: () {
            Navigator.pop(context);
            retryFunction();
          },
          width: 80,
          child: const Text(
            "Retry",
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
    ],
  ).show();
}
