import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String title, String description,
    void Function()? retryFunction) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        if (retryFunction != null)
          TextButton(
            child: const Text('Retry'),
            onPressed: () {
              retryFunction();
              Navigator.of(context).pop();
            },
          )
      ],
    ),
  );
}
