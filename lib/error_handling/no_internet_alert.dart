import 'package:flutter/material.dart';
import 'package:owwn_coding_challenge/Constants/k_colors.dart';
import 'package:owwn_coding_challenge/constants/k_images.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

showNoInternetAlert(BuildContext context, void Function() retryFunction) {
  Alert(
    context: context,
    style: const AlertStyle(
      animationType: AnimationType.grow,
      descStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
    ),
    title: "No Internet",
    desc:
        "Connection to internet failed. Please connect to the internet and try again.",
    image: Image.asset(
      KImages.loginImage,
      height: 120,
    ),
    buttons: [
      DialogButton(
        color: KColors.primaryColor,
        onPressed: () {
          retryFunction();
          Navigator.of(context).pop();
        },
        width: 120,
        child: const Text(
          "Retry",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      )
    ],
  ).show();
}
