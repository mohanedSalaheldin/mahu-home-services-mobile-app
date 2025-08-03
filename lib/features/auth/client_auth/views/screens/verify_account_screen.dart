import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/utils/helpers/helping_functions.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_cubit.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_state.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/client_register_screen.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/login_screen.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_snack_bar.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/o_t_p_form_filed.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/have_or_not_an_account_row.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({super.key, required this.otpChannel});
  final OtpChannel otpChannel;

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  final TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordRemember = false;
  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Account'),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is VerifyEmailSucessededState) {
            navigateTo(
              context,
              const LoginScreen(),
            );
          } else if (state is OTPResendSucessededState) {
            showCustomSnackBar(
              context: context,
              message: 'OTP sent, check your email',
              type: SnackBarType.success,
            );
          } else if (state is OTPResendFailedState) {
            showCustomSnackBar(
              context: context,
              message: state.failure.msg,
              type: SnackBarType.failure,
            );
          }
        },
        builder: (context, state) {
          if (state is VerifyEmailLoadingState ||
              state is OTPResendLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var authCubit = AuthCubit.get(context);
          String idThanSendOTPTo = widget.otpChannel == OtpChannel.phone
              ? authCubit.registerResponceUser.phone
              : authCubit.registerResponceUser.email;
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppConst.appPadding.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'We have sent verification \n code to $idThanSendOTPTo',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13.sp,
                        color: Colors.black.withOpacity(.5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(10.h),
                    OTPFormFiled(otpController: otpController),
                    Gap(5.h),
                    Row(
                      children: [
                        HaveOrNotAnAccountRow(
                          questionTxt: 'Don\'t receive OTP?',
                          buttonTxt: 'Re-send Code',
                          onPresseButton: () {},
                        ),
                      ],
                    ),
                    Gap(5.h),
                    AppFilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AuthCubit.get(context).verify(
                            channal: widget.otpChannel,
                            otp: otpController.text,
                          );
                          print("Form is valid");
                        } else {
                          // Invalid, show errors
                          print("Form is invalid");
                        }
                      },
                      text: 'Verify',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
