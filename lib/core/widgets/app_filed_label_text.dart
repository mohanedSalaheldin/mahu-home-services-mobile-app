// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:mahu_home_services_app/core/constants/colors.dart';
// import 'package:mahu_home_services_app/core/utils/helpers/form_validation_method.dart';
// import 'package:mahu_home_services_app/features/auth/views/widgets/custom_text_field.dart';
// import 'package:mahu_home_services_app/features/services/models/service_type.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFieledLabelText extends StatelessWidget {
  const AppFieledLabelText({
    super.key,
    required this.label,
    this.fontSize,
  });
  final int? fontSize;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: (fontSize ?? 16).toDouble(),
        color: Colors.black,
      ),
    );
  }
}
