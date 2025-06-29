import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/helpers/form_validation_method.dart';

class PhoneTextField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final void Function(String)? onCountryCodeChanged;

  const PhoneTextField({
    super.key,
    required this.label,
    this.controller,
    this.onCountryCodeChanged,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {

  String _selectedCode = '+20';
  final List<String> _countryCodes = ['+20', '+971'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.greyBack,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: _selectedCode,
                  underline: const SizedBox(),
                  items: _countryCodes
                      .map((code) => DropdownMenuItem(
                            value: code,
                            child: Text(
                              code,
                              style: const TextStyle(
                                color: AppColors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCode = value!;
                    });
                    if (widget.onCountryCodeChanged != null) {
                      widget.onCountryCodeChanged!(_selectedCode);
                    }
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  keyboardType: TextInputType.phone,
                  validator: FormValidationMethod.validatePhone,
                  decoration: InputDecoration(
                    hintText: 'Enter Phone Number',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 13.sp,
                      height: 4,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String countryCodeToFlag(String countryCode) {
    return countryCode
        .toUpperCase()
        .codeUnits
        .map((char) => String.fromCharCode(char + 127397))
        .join();
  }
}
