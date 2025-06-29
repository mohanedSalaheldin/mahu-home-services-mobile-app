import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:pinput/pinput.dart';

class OTPFormFiled extends StatelessWidget {
  OTPFormFiled({
    super.key,
    required this.otpController,
  });

  final TextEditingController otpController;

  final focusedBorderColor = const Color.fromRGBO(23, 171, 144, 1);
  final fillColor = const Color.fromRGBO(243, 246, 249, 0);
  final borderColor = const Color.fromRGBO(23, 171, 144, 0.4);

  // final defaultPinTheme = PinTheme(
  //   width: 56,
  //   height: 56,
  //   textStyle: const TextStyle(
  //     fontSize: 22,
  //     color: Color.fromRGBO(30, 60, 87, 1),
  //   ),
  //   decoration: BoxDecoration(
  //     borderRadius: BorderRadius.circular(19),
  //     border: Border.all(color: const Color.fromRGBO(23, 171, 144, 0.4)),
  //   ),
  // );

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      controller: otpController,
      defaultPinTheme: PinTheme(
        width: 70.h,
        height: 50.w,
        textStyle: const TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
        decoration: BoxDecoration(
          color: AppColors.greyBack,
          border: Border.all(width: 0, color: AppColors.greyBack),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      separatorBuilder: (index) => SizedBox(width: 8.w),
      validator: (value) {
        return null;

        // return value == '2222' ? null : 'Pin is incorrect';
      },
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      onCompleted: (pin) {
        debugPrint('onCompleted: $pin');
      },
      onChanged: (value) {
        // debugPrint('onChanged: $value');
      },
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 9),
            width: 22.w,
            height: 1,
            color: AppColors.black,
          ),
        ],
      ),
      // focusedPinTheme: defaultPinTheme.copyWith(
      //   decoration: defaultPinTheme.decoration!.copyWith(
      //     borderRadius: BorderRadius.circular(8),
      //     border: Border.all(color: focusedBorderColor),
      //   ),
      // ),
      // submittedPinTheme: defaultPinTheme.copyWith(
      //   decoration: defaultPinTheme.decoration!.copyWith(
      //     color: fillColor,
      //     borderRadius: BorderRadius.circular(19),
      //     border: Border.all(color: focusedBorderColor),
      //   ),
      // ),
      // errorPinTheme: defaultPinTheme.copyBorderWith(
      //   border: Border.all(color: Colors.redAccent),
      // ),
      // ),
    );
  }
}
