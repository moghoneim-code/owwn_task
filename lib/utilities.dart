import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utilities {
  Utilities._();

  static String getInitials(String name) => name.isNotEmpty
      ? name.trim().split(' ').map((l) => l[0]).take(2).join()
      : '';

  static IconData buildSexIcon(String gender) {
    switch (gender) {
      case "male":
        return Icons.male;

      case "female":
        return Icons.female;

      default:
        return Icons.transgender;
    }
  }
}
