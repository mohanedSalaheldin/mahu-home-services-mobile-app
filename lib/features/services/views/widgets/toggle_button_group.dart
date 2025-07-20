import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class ToggleButtonGroup extends StatelessWidget {
  final String leftLabel;
  final String rightLabel;
  final bool isLeftSelected;
  final void Function(bool) onChanged;

  const ToggleButtonGroup({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    required this.isLeftSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left Button
        Expanded(
          child: SizedBox(
            height: 46.h,
            child: ElevatedButton(
              onPressed: () => onChanged(true),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                    isLeftSelected ? AppColors.blue : AppColors.greyBack),
                foregroundColor: WidgetStatePropertyAll(
                    isLeftSelected ? Colors.white : Colors.black),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: Text(leftLabel),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Right Button
        Expanded(
          child: SizedBox(
            height: 46.h,
            child: ElevatedButton(
              onPressed: () => onChanged(false),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                    !isLeftSelected ? AppColors.blue : AppColors.greyBack),
                foregroundColor: WidgetStatePropertyAll(
                    !isLeftSelected ? Colors.white : Colors.black),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: Text(rightLabel),
            ),
          ),
        ),
      ],
    );
  }
}
