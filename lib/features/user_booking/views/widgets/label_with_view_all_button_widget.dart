import 'package:flutter/material.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_text_button.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/home_section_label_text.dart';

class LabelWithViewAllButtonWidget extends StatelessWidget {
  const LabelWithViewAllButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
  });
  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HomeSectionLabelText(
          txt: label,
        ),
        AppTextButton(
          txt: 'View All',
          fontSize: 13,
          onPressed: onPressed,
        )
      ],
    );
  }
}
