import 'package:flutter/material.dart';

enum SnackBarType { success, failure, warning, help }

void showCustomSnackBar({
  required BuildContext context,
  required String message,
  required SnackBarType type,
  Duration duration = const Duration(seconds: 2),
}) {
  IconData icon;
  Color backgroundColor;

  switch (type) {
    case SnackBarType.success:
      icon = Icons.check_circle;
      backgroundColor = Colors.green;
      break;
    case SnackBarType.failure:
      icon = Icons.error;
      backgroundColor = Colors.red;
      break;
    case SnackBarType.warning:
      icon = Icons.warning;
      backgroundColor = Colors.orange;
      break;
    case SnackBarType.help:
      icon = Icons.info;
      backgroundColor = Colors.blue;
      break;
  }

  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    duration: duration,
    elevation: 6,
  );

  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
