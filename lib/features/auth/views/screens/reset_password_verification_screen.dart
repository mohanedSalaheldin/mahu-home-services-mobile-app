// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:mahu_home_services_app/core/constants/app_const.dart';
// import 'package:mahu_home_services_app/core/constants/colors.dart';
// import 'package:mahu_home_services_app/core/utils/helpers/helping_functions.dart';
// import 'package:mahu_home_services_app/viewmodels/cubit/auth_cubit.dart';
// import 'package:mahu_home_services_app/viewmodels/cubit/auth_state.dart';
// import 'package:mahu_home_services_app/views/auth/widgets/app_back_button.dart';
// import 'package:mahu_home_services_app/views/landing/screens/choose_rule_screen.dart';
// import 'package:mahu_home_services_app/views/landing/screens/landing_scren2.dart';
// import 'package:mahu_home_services_app/views/landing/widgets/app_filled_button.dart';
// import 'package:mahu_home_services_app/views/landing/widgets/have_or_not_an_account_row.dart';
// import 'package:pinput/pinput.dart';

// class ResetPasswordVerificationScreen extends StatefulWidget {
//   const ResetPasswordVerificationScreen({super.key, required this.userEmail});
//   final String userEmail;

//   @override
//   State<ResetPasswordVerificationScreen> createState() =>
//       _ResetPasswordVerificationScreenState();
// }

// class _ResetPasswordVerificationScreenState
//     extends State<ResetPasswordVerificationScreen> {
//   final TextEditingController otpController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool passwordRemember = false;
//   @override
//   void dispose() {
//     otpController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocConsumer<AuthCubit, AuthState>(
//         listener: (context, state) {
//           if (state is VerifyEmailSucessededState) {
//             navigateTo(context, const ChooseRuleScreen());
//           }
//         },
//         builder: (context, state) {
//           if (state is VerifyEmailLoadingState) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           return SafeArea(
//             child: Padding(
//               padding: EdgeInsets.all(AppConst.appPadding.w),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     const Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [AppBackButton()],
//                     ),
//                     Text(
//                       'Reset Verification',
//                       style: TextStyle(
//                         height: 0.7,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 30.sp,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Gap(10.h),
//                     Text(
//                       'We have sent verification \n code to ${widget.userEmail}',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w300,
//                         fontSize: 13.sp,
//                         color: Colors.black.withOpacity(.5),
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     Gap(10.h),
//                     Pinput(
//                       length: 6,
//                       controller: otpController,
//                       defaultPinTheme: PinTheme(
//                         width: 70.h,
//                         height: 50.w,
//                         textStyle: const TextStyle(
//                             fontSize: 20,
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600),
//                         decoration: BoxDecoration(
//                           color: AppColors.greyBack,
//                           border:
//                               Border.all(width: 0, color: AppColors.greyBack),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       separatorBuilder: (index) => SizedBox(width: 8.w),
//                       validator: (value) {
//                         return null;

//                         // return value == '2222' ? null : 'Pin is incorrect';
//                       },
//                       hapticFeedbackType: HapticFeedbackType.lightImpact,
//                       onCompleted: (pin) {
//                         debugPrint('onCompleted: $pin');
//                       },
//                       onChanged: (value) {
//                         // debugPrint('onChanged: $value');
//                       },
//                       cursor: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Container(
//                             margin: const EdgeInsets.only(bottom: 9),
//                             width: 22.w,
//                             height: 1,
//                             color: AppColors.black,
//                           ),
//                         ],
//                       ),
//                       // focusedPinTheme: defaultPinTheme.copyWith(
//                       //   decoration: defaultPinTheme.decoration!.copyWith(
//                       //     borderRadius: BorderRadius.circular(8),
//                       //     border: Border.all(color: focusedBorderColor),
//                       //   ),
//                       // ),
//                       // submittedPinTheme: defaultPinTheme.copyWith(
//                       //   decoration: defaultPinTheme.decoration!.copyWith(
//                       //     color: fillColor,
//                       //     borderRadius: BorderRadius.circular(19),
//                       //     border: Border.all(color: focusedBorderColor),
//                       //   ),
//                       // ),
//                       // errorPinTheme: defaultPinTheme.copyBorderWith(
//                       //   border: Border.all(color: Colors.redAccent),
//                       // ),
//                       // ),
//                     ),
//                     Gap(15.h),
//                     // Row(
//                     //   children: [
//                     //     HaveOrNotAnAccountRow(
//                     //       questionTxt: 'Don\'t receive OTP?',
//                     //       buttonTxt: 'Re-send Code',
//                     //       onPresseButton: () {},
//                     //     ),
//                     //   ],
//                     // ),
//                     // Gap(5.h),
//                     AppFilledButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           AuthCubit.get(context)
//                               .verify(otp: otpController.text);
//                           print("Form is valid");
//                         } else {
//                           // Invalid, show errors
//                           print("Form is invalid");
//                         }
//                       },
//                       text: 'Verify',
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
