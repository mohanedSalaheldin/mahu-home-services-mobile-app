import 'package:flutter/material.dart';

class HomeSectionLabelText extends StatelessWidget {
  const HomeSectionLabelText({
    super.key,
    required this.txt,
    this.fontSize,
  });
  final String txt;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: fontSize ?? 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
