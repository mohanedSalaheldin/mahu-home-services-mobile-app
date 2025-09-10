import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/utils/helpers/form_validation_method.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_cubit.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_state.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/login_screen.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_snack_bar.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_text_field.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/o_t_p_form_filed.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key, required this.userEmail});

  final String userEmail;

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool termsAgreed = false;
  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Password'),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordSucessededState) {
            navigateTo(context, const LoginScreen());
          } else if (state is ResetPasswordFailedState) {
            showCustomSnackBar(
                context: context,
                message: state.failure.msg,
                type: SnackBarType.failure);
          }
        },
        builder: (context, state) {
          if (state is ResetPasswordLoadingState) {
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
                    Text(
                      'We have sent verification \n code to ${widget.userEmail}',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                        color: Colors.black.withOpacity(.5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(10.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "OTP",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Gap(7.h),
                    OTPFormFiled(otpController: otpController),
                    Gap(10.h),
                    CustomTextField(
                      label: 'Password',
                      hint: 'Enter Password',
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      isPassword: true,
                      validator: FormValidationMethod.validatePassword,
                    ),
                    Gap(10.h),
                    CustomTextField(
                      label: 'Confirm Password',
                      hint: 'Enter Password',
                      keyboardType: TextInputType.visiblePassword,
                      controller: confirmPasswordController,
                      isPassword: true,
                      validator: (value) =>
                          FormValidationMethod.validateRepassword(
                              value, passwordController),
                    ),
                    Gap(30.h),
                    AppFilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AuthCubit.get(context).resetPassword(
                            email: widget.userEmail,
                            newPassword: passwordController.text,
                            otp: otpController.text,
                          );
                        }
                      },
                      text: 'Save Changes',
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
