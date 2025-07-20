import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/helpers/form_validation_method.dart';
import 'package:mahu_home_services_app/core/utils/helpers/helping_functions.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_cubit.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_state.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/login_screen.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/verify_account_screen.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/app_back_button.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_snack_bar.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_text_field.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/phone_text_field.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/terms_checkbox.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_text_button.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/have_or_not_an_account_row.dart';

class ClientRegisterScreen extends StatefulWidget {
  const ClientRegisterScreen({super.key});

  @override
  State<ClientRegisterScreen> createState() => _ClientRegisterScreenState();
}

class _ClientRegisterScreenState extends State<ClientRegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool agreedToTerms = false;
  bool showTermsError = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fNameController.dispose();
    lNameController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  String countryCode = '+20';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Registeration'),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSucessededState) {
            navigateTo(context, const VerifyAccountScreen());
          } else if (state is RegisterFailedState) {
            showCustomSnackBar(
                context: context,
                message: state.failure.msg,
                type: SnackBarType.failure);
          }
        },
        builder: (context, state) {
          if (state is RegisterLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppConst.appPadding.w),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // Gap(20.h),
                    CustomTextField(
                      label: 'Email',
                      hint: 'Enter Email Address',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: FormValidationMethod.validateEmail,
                    ),
                    Gap(10.h),
                    PhoneTextField(
                      label: 'Phone Number',
                      controller: phoneController,
                      onCountryCodeChanged: (code) {
                        countryCode = code;
                        // print("Selected code: ${}");
                      },
                    ),

                    Gap(10.h),
                    CustomTextField(
                      label: 'First Name',
                      hint: 'Enter First Name',
                      keyboardType: TextInputType.name,
                      controller: fNameController,
                      validator: (value) =>
                          FormValidationMethod.validateNameField(
                              value, 'First Name'),
                    ),
                    Gap(10.h),
                    CustomTextField(
                      label: 'Last Name',
                      hint: 'Enter Last Name',
                      keyboardType: TextInputType.name,
                      controller: lNameController,
                      validator: (value) =>
                          FormValidationMethod.validateNameField(
                              value, 'Last Name'),
                    ),
                    Gap(10.h),
                    CustomTextField(
                      label: 'Password',
                      hint: 'Enter Password',
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      isPassword: true,
                      validator: FormValidationMethod.validatePassword,
                      lines: 1,
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
                      lines: 1,
                    ),
                    Gap(5.h),
                    TermsCheckbox(
                      value: agreedToTerms,
                      onChanged: (value) {
                        setState(() {
                          agreedToTerms = value ?? false;
                          if (agreedToTerms) showTermsError = false;
                        });
                      },
                      onTapTerms: () {
                        // Show terms or navigate to terms screen
                      },
                    ),
                    Gap(5.h),
                    AppFilledButton(
                      onPressed: () {
                        // First: validate form
                        if (_formKey.currentState!.validate()) {
                          // Then: check if terms are agreed
                          if (!agreedToTerms) {
                            showCustomSnackBar(
                                context: context,
                                message:
                                    'You must agree to the terms before registering.',
                                type: SnackBarType.failure);

                            return;
                          }
                          AuthCubit.get(context).registerAsClient(
                            email: emailController.text,
                            firstName: fNameController.text,
                            lastName: lNameController.text,
                            password: passwordController.text,
                            phone: countryCode + phoneController.text,
                          );
                          print("Form is valid");
                        }
                      },
                      text: 'Sign Up',
                    ),
                    // Gap(3.h),
                    // Text(
                    //   "Or",
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.w300,
                    //     fontSize: 16.sp,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    // Gap(3.h),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const OtherWayToSigninItem(img: 'assets/icons/google.png'),
                    //     Gap(22.w),
                    //     const OtherWayToSigninItem(
                    //         img: 'assets/icons/facebook.png'),
                    //   ],
                    // ),
                    // const Spacer(),
                    HaveOrNotAnAccountRow(
                      questionTxt: 'Already have an account ?',
                      buttonTxt: 'Login',
                      onPresseButton: () {
                        navigateTo(context, const LoginScreen());
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
