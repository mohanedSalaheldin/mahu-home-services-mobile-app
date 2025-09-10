import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_text_button.dart';

class HaveOrNotAnAccountRow extends StatelessWidget {
  const HaveOrNotAnAccountRow({
    super.key,
    required this.questionTxt,
    required this.buttonTxt,
    required this.onPresseButton,
  });
  final String questionTxt;
  final String buttonTxt;
  final void Function() onPresseButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          questionTxt,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16,
            color: Colors.black.withOpacity(.8),
          ),
          textAlign: TextAlign.center,
        ),
        AppTextButton(
          txt: buttonTxt,
          onPressed: onPresseButton,
        ),
      ],
    );
  }
}
