import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/widgets/app_filed_label_text.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final String? description;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final void Function(T?)? onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    this.description,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFieledLabelText(label: label),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<T>(
            value: value,
            items: items,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            onChanged: onChanged,
            dropdownColor: AppColors.blue,
            decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
              hintText: '',
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
