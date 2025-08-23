import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/helpers/form_validation_method.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_cubit.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_state.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/login_screen.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/verify_account_screen.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_snack_bar.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_text_field.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/phone_text_field.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/terms_checkbox.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/have_or_not_an_account_row.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/bool_radio_group.dart';

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
  final TextEditingController refrenceIdController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool agreedToTerms = false;
  bool showTermsError = false;
  OtpChannel _otpChannel = OtpChannel.phone;
  String phoneNumber = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fNameController.dispose();
    lNameController.dispose();
    refrenceIdController.dispose();
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
            navigateTo(
                context,
                VerifyAccountScreen(
                  otpChannel: _otpChannel,
                ));
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
              child: CircularProgressIndicator(color: Colors.blue),
            );
          }
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppConst.appPadding.w),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Gap(20.h),
                    // Gap(10.h),
                    IntlPhoneField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: AppColors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              const BorderSide(color: AppColors.blue, width: 2),
                        ),
                      ),
                      initialCountryCode: 'EG', // default to Egypt
                      countries: const [
                        Country(
                          code: 'EG',
                          name: 'Egypt',
                          dialCode: '20',
                          flag: '🇪🇬',
                          nameTranslations: const {'en': 'Egypt', 'ar': 'مصر'},
                          minLength: 10,
                          maxLength: 10,
                        ),
                        Country(
                          code: 'AE',
                          name: 'United Arab Emirates',
                          dialCode: '971',
                          flag: '🇦🇪',
                          nameTranslations: const {
                            'en': 'United Arab Emirates',
                            'ar': 'الإمارات العربية المتحدة'
                          },
                          minLength: 9,
                          maxLength: 9,
                        ),
                      ], // Only Egypt and UAE
                      controller: phoneController,
                      onChanged: (phone) {
                        phoneNumber = phone.completeNumber;
                        countryCode = '${phone.countryCode}';
                      },
                      onCountryChanged: (country) {
                        countryCode = '${country.dialCode}';
                        AppUserConfig.selectedCountryCode = countryCode;
                      },
                      validator: (value) {
                        if (value == null || value.number.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        return null;
                      },
                    ),
                    Gap(10.h),
                    CustomTextField(
                      label: 'Email',
                      hint: 'Enter Email Address',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: FormValidationMethod.validateEmail,
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
                    Gap(10.h),
                    CustomTextField(
                      label: 'Business Reference ID',
                      hint: 'Please add reference id',
                      keyboardType: TextInputType.name,
                      controller: refrenceIdController,
                      isPassword: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) return null;

                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return "Reference ID must be numbers only";
                        }

                        return null;
                      },
                      lines: 1,
                    ),
                    Gap(10.h),
                    // NEW: OTP channel section
                    Text(
                      'Receive OTP via',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(6.h),

// WhatsApp option
                    RadioListTile<OtpChannel>(
                      contentPadding: EdgeInsets.zero,
                      value: OtpChannel.phone,
                      fillColor: const WidgetStatePropertyAll(AppColors.blue),
                      groupValue: _otpChannel,
                      onChanged: (v) => setState(() => _otpChannel = v!),
                      title: const Text('Phone (WhatsApp)'),
                      subtitle: const Text('Send OTP to your WhatsApp number'),
                      secondary: const Icon(Icons.message),
                      dense: true,
                    ),

// Email option
                    RadioListTile<OtpChannel>(
                      contentPadding: EdgeInsets.zero,
                      value: OtpChannel.email,
                      fillColor: const WidgetStatePropertyAll(AppColors.blue),
                      groupValue: _otpChannel,
                      onChanged: (v) => setState(() => _otpChannel = v!),
                      title: const Text('Email'),
                      subtitle: const Text('Send OTP to your email address'),
                      secondary: const Icon(Icons.email),
                      dense: true,
                    ),

                    Gap(10.h),
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
                              phone: countryCode +
                                  phoneController.text
                                      .replaceAll(RegExp(r'^\\+'), ''),
                              refrenceId: refrenceIdController.text,
                              otpMethod: _otpChannel.name);
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
                    //     fontSize: 16,
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

enum OtpChannel { phone, email }

class AppUserConfig {
  static String selectedCountryCode = '+20'; // default Egypt
}