import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_cubit.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_state.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/client_register_screen.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/login_screen.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_snack_bar.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/o_t_p_form_filed.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/have_or_not_an_account_row.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

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
        title: Text(S.of(context).verifyAccountScreenTitle),
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
              message: S.of(context).verifyAccountScreenOtpResendSuccess,
              type: SnackBarType.success,
            );
          } else if (state is OTPResendFailedState) {
            showCustomSnackBar(
              context: context,
              message: state.failure.msg,
              type: SnackBarType.failure,
            );
          }
          if (state is VerifyEmailFailedState) {
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
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          var authCubit = AuthCubit.get(context);
          String idThanSendOTPTo = widget.otpChannel == OtpChannel.phone
              ? authCubit.registerResponceUser.phone
              : authCubit.registerResponceUser.email;
          onVerifyPressed() {
            if (_formKey.currentState!.validate()) {
              AuthCubit.get(context).verify(
                channal: widget.otpChannel,
                otp: otpController.text.toString(),
              );
              print("Form is valid");
            } else {
              print("Form is invalid");
            }
          }

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppConst.appPadding.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      S.of(context).verifyAccountScreenVerificationMessage(
                          idThanSendOTPTo),
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                        color: Colors.black.withOpacity(.5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(10.h),
                    OTPFormFiled(
                        otpController: otpController,
                        onCompleted: (p0) {
                          onVerifyPressed();
                        }),
                    Gap(5.h),
                    Row(
                      children: [
                        HaveOrNotAnAccountRow(
                          questionTxt:
                              S.of(context).verifyAccountScreenNoOtpQuestion,
                          buttonTxt:
                              S.of(context).verifyAccountScreenResendButton,
                          onPresseButton: () {
                            // AuthCubit.get(context).resendOTP(
                            //   channal: widget.otpChannel,
                            // );
                          },
                        ),
                      ],
                    ),
                    Gap(5.h),
                    AppFilledButton(
                      onPressed: onVerifyPressed,
                      text: S.of(context).verifyAccountScreenVerifyButton,
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
