import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class ShortFormField extends StatelessWidget {
  const ShortFormField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 25.h,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.blue, width: 1),
        ),
      ),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        style: const TextStyle(height: 1.9),
        decoration: const InputDecoration(
          // prefixText: '\$',
          prefixStyle: TextStyle(
            color: AppColors.blue,
            fontWeight: FontWeight.bold,
          ),
          isCollapsed: true,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        keyboardType: TextInputType.number,
        onChanged: (val) {},
      ),
    );
  }
}
