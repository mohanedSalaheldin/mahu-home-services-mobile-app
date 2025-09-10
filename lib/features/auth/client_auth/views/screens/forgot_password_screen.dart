import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/utils/helpers/form_validation_method.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_cubit.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_state.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/new_password_screen.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/app_back_button.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_snack_bar.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_text_field.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailOrPhoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordRemember = false;
  @override
  void dispose() {
    emailOrPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ForgotPasswordSucessededState) {
            showCustomSnackBar(
              context: context,
              message: 'Password reset OTP sent',
              type: SnackBarType.success,
            );
            navigateTo(context,
                NewPasswordScreen(userEmail: emailOrPhoneController.text));
          } else if (state is ForgotPasswordFailedState) {
            showCustomSnackBar(
                context: context,
                message: state.failure.msg,
                type: SnackBarType.failure);
          }
        },
        builder: (context, state) {
          if (state is ForgotPasswordLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue
              ),
            );
          }
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppConst.appPadding.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [AppBackButton()],
                    ),
                    Text(
                      'Forgot Password',
                      style: TextStyle(
                        height: 0.7,
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                    Gap(25.h),
                    CustomTextField(
                      label: 'Email or Phone Number',
                      hint: 'Enter Email or Phone Number',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailOrPhoneController,
                      validator: FormValidationMethod.validateEmailAndPhoneNum,
                    ),
                    Gap(10.h),
                    AppFilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AuthCubit.get(context).forgotPassword(
                            email: emailOrPhoneController.text,
                          );
                        }
                      },
                      text: 'Send Code',
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
