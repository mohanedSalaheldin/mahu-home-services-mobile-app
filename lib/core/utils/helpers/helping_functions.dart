import 'package:flutter/material.dart';
import 'package:mahu_home_services_app/features/landing/views/screens/choose_rule_screen.dart';

void navigateTo(
  BuildContext context,
  Widget screen,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}
