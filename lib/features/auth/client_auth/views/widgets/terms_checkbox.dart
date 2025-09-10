import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_text_button.dart';

class TermsCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;
  final VoidCallback onTapTerms;

  const TermsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.onTapTerms,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: AppColors.blue,
          side: const BorderSide(width: 1, color: AppColors.blue),
          value: value,
          onChanged: onChanged,
        ),
        Text(
          'I agree the ',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black,
            
          ),
        ),
        AppTextButton(
          txt: 'Terms and Conditions',
          onPressed: onTapTerms,
        ),
      ],
    );
  }
}
