import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 39.w,
      height: 39.w,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          elevation: 0,
          padding: const EdgeInsets.all(0),
          backgroundColor: AppColors.greyBack,
          foregroundColor: Colors.black,
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          size: 17,
        ),
      ),
    );
  }
}
