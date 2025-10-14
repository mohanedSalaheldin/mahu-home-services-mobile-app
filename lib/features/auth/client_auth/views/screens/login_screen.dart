import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/models/user_type_enum.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/core/utils/helpers/form_validation_method.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_cubit.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_state.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/forgot_password_screen.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/client_register_screen.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_snack_bar.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_text_field.dart';
import 'package:mahu_home_services_app/features/auth/provider_auth/views/screens/provider_register_screen.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_text_button.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/have_or_not_an_account_row.dart';
import 'package:mahu_home_services_app/features/layouts/client_layout_screen.dart';
import 'package:mahu_home_services_app/features/layouts/provider_layout_screen.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordRemember = false;

  @override
  void dispose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).loginScreenTitle),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSucessededState) {
            final role = state.userModel.role;
            CacheHelper.saveString('user_role', role);
            if (role == 'provider') {
              navigateToAndKill(context, ProviderLayoutScreen());
            } else {
              navigateToAndKill(context, ClientLayoutScreen());
            }
          } else if (state is LoginFailedState) {
            showCustomSnackBar(
              context: context,
              message: state.failure.msg,
              type: SnackBarType.failure,
            );
          }
        },
        builder: (context, state) {
          if (state is LoginLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          }
          onLoginPressed() {
            if (_formKey.currentState!.validate()) {
              AuthCubit.get(context).login(
                emailOrPhone: emailOrPhoneController.text,
                password: passwordController.text,
              );
            }
          }

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppConst.appPadding.w),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Gap(25.h),
                    CustomTextField(
                      label: S.of(context).loginScreenEmailOrPhoneLabel,
                      hint: S.of(context).loginScreenEmailOrPhoneHint,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailOrPhoneController,
                      validator: FormValidationMethod.validateEmailAndPhoneNum,
                    ),
                    Gap(10.h),
                    CustomTextField(
                      label: S.of(context).loginScreenPasswordLabel,
                      hint: S.of(context).loginScreenPasswordHint,
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      isPassword: true,
                      lines: 1,
                      validator: FormValidationMethod.validatePassword,
                      onFieldSubmitted: (value) {
                        onLoginPressed();
                      },
                    ),
                    Gap(5.h),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: AppColors.blue,
                          side:
                              const BorderSide(width: 1, color: AppColors.blue),
                          value: passwordRemember,
                          onChanged: (value) {
                            setState(
                              () {
                                passwordRemember = value ?? false;
                              },
                            );
                          },
                        ),
                        Text(
                          S.of(context).loginScreenRememberMe,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        AppTextButton(
                          txt: S.of(context).loginScreenForgotPassword,
                          fontSize: 14,
                          onPressed: () {
                            navigateTo(context, const ForgetPasswordScreen());
                          },
                        )
                      ],
                    ),
                    Gap(5.h),
                    AppFilledButton(
                      onPressed: onLoginPressed,
                      text: S.of(context).loginScreenLoginBtn,
                    ),
                    Gap(3.h),
                    HaveOrNotAnAccountRow(
                      questionTxt: S.of(context).loginScreenDontHaveAccount,
                      buttonTxt: S.of(context).loginScreenSignUp,
                      onPresseButton: () {
                        navigateToAndKill(
                            context,
                            UserRoleCubit.get(context).state == UserRole.client
                                ? const ClientRegisterScreen()
                                : const ProviderRegisterScreen());
                      },
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
