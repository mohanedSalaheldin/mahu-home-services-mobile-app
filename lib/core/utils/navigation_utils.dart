import 'package:flutter/material.dart';

void navigateTo(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

void navigateToAndKill(BuildContext context, Widget screen) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => screen),
    (route) => false,
  );
}
