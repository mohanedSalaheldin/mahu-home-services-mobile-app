import 'package:flutter/material.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/widgets/app_filed_label_text.dart';

class BoolRadioGroup extends StatelessWidget {
  final String label;
  final bool value;
  final void Function(bool) onChanged;

  const BoolRadioGroup({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppFieledLabelText(label: label),
        Radio<bool>(
          value: true,
          groupValue: value,
          onChanged: (val) => onChanged(val!),
          fillColor: const WidgetStatePropertyAll(AppColors.blue),
        ),
        const Text("Yes"),
        Radio<bool>(
          value: false,
          groupValue: value,
          onChanged: (val) => onChanged(val!),
          fillColor: const WidgetStatePropertyAll(AppColors.blue),
        ),
        const Text("No"),
      ],
    );
  }
}
