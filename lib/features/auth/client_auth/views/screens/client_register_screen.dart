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
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/terms_checkbox.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/have_or_not_an_account_row.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

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
  String countryCode = '+20'; // default

  @override
  void initState() {
    super.initState();
    _loadSavedCountry();
  }

  Future<void> _loadSavedCountry() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString('selected_country_code') ?? '+20';
    setState(() {
      countryCode = savedCode;
      AppUserConfig.selectedCountryCode = savedCode;
    });
  }

  Future<void> _saveCountry(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_country_code', code);
    AppUserConfig.selectedCountryCode = code;
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).clientRegisterationTitle),
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
                    IntlPhoneField(
                      decoration: InputDecoration(
                        labelText: S.of(context).clientRegisterationPhoneNumber,
                        labelStyle: const TextStyle(color: Colors.blue),
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
                      initialCountryCode: countryCode.isNotEmpty
                          ? CountryCodeHelper.getCountryCodeFromDial(
                              countryCode)
                          : 'EG',
                      countries: countries,
                      controller: phoneController,
                      onChanged: (phone) {
                        phoneNumber = phone.completeNumber;
                        countryCode = phone.countryCode;
                        _saveCountry(countryCode);
                      },
                      onCountryChanged: (country) {
                        countryCode = '+${country.dialCode}';
                        _saveCountry(countryCode);
                      },
                      validator: (value) {
                        if (value == null || value.number.isEmpty) {
                          return S
                              .of(context)
                              .clientRegisterationPleaseEnterPhoneNumber;
                        }
                        return null;
                      },
                      dropdownIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.blue,
                      ),
                      style: const TextStyle(color: AppColors.blue),
                      dropdownTextStyle: const TextStyle(color: AppColors.blue),
                    ),
                    Gap(10.h),
                    CustomTextField(
                      label: S.of(context).clientRegisterationEmail,
                      hint: S.of(context).clientRegisterationEnterEmailAddress,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: FormValidationMethod.validateEmail,
                    ),
                    Gap(10.h),
                    CustomTextField(
                      label: S.of(context).clientRegisterationFirstName,
                      hint: S.of(context).clientRegisterationEnterFirstName,
                      keyboardType: TextInputType.name,
                      controller: fNameController,
                      validator: (value) =>
                          FormValidationMethod.validateNameField(value,
                              S.of(context).clientRegisterationFirstName),
                    ),
                    Gap(10.h),
                    CustomTextField(
                      label: S.of(context).clientRegisterationLastName,
                      hint: S.of(context).clientRegisterationEnterLastName,
                      keyboardType: TextInputType.name,
                      controller: lNameController,
                      validator: (value) =>
                          FormValidationMethod.validateNameField(
                              value, S.of(context).clientRegisterationLastName),
                    ),
                    Gap(10.h),
                    CustomTextField(
                      label: S.of(context).clientRegisterationPassword,
                      hint: S.of(context).clientRegisterationEnterPassword,
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      isPassword: true,
                      validator: FormValidationMethod.validatePassword,
                      lines: 1,
                    ),
                    Gap(10.h),
                    CustomTextField(
                      label: S.of(context).clientRegisterationConfirmPassword,
                      hint: S.of(context).clientRegisterationEnterPassword,
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
                      label:
                          S.of(context).clientRegisterationBusinessReferenceId,
                      hint:
                          S.of(context).clientRegisterationPleaseAddReferenceId,
                      keyboardType: TextInputType.name,
                      controller: refrenceIdController,
                      isPassword: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) return null;

                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return S
                              .of(context)
                              .clientRegisterationReferenceIdMustBeNumbersOnly;
                        }

                        return null;
                      },
                      lines: 1,
                    ),
                    Gap(10.h),
                    Text(
                      S.of(context).clientRegisterationReceiveOtpVia,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(6.h),
                    RadioListTile<OtpChannel>(
                      contentPadding: EdgeInsets.zero,
                      value: OtpChannel.phone,
                      fillColor: const WidgetStatePropertyAll(AppColors.blue),
                      groupValue: _otpChannel,
                      onChanged: (v) => setState(() => _otpChannel = v!),
                      title: Text(
                          S.of(context).clientRegisterationOtpPhoneOptionTitle),
                      subtitle: Text(S
                          .of(context)
                          .clientRegisterationOtpPhoneOptionSubtitle),
                      secondary: const Icon(Icons.message),
                      dense: true,
                    ),
                    RadioListTile<OtpChannel>(
                      contentPadding: EdgeInsets.zero,
                      value: OtpChannel.email,
                      fillColor: const WidgetStatePropertyAll(AppColors.blue),
                      groupValue: _otpChannel,
                      onChanged: (v) => setState(() => _otpChannel = v!),
                      title: Text(
                          S.of(context).clientRegisterationOtpEmailOptionTitle),
                      subtitle: Text(S
                          .of(context)
                          .clientRegisterationOtpEmailOptionSubtitle),
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
                      onTapTerms: () {},
                    ),
                    Gap(5.h),
                    AppFilledButton(
                      fontSize: 20.sp,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (!agreedToTerms) {
                            showCustomSnackBar(
                                context: context,
                                message: S
                                    .of(context)
                                    .clientRegisterationMustAgreeToTerms,
                                type: SnackBarType.failure);
                            return;
                          }
                          String formattedPhone = phoneNumber;
                          if (!formattedPhone.startsWith('+')) {
                            formattedPhone = '+$formattedPhone';
                          }
                          AuthCubit.get(context).registerAsClient(
                              email: emailController.text,
                              firstName: fNameController.text,
                              lastName: lNameController.text,
                              password: passwordController.text,
                              phone: formattedPhone,
                              refrenceId: refrenceIdController.text,
                              otpMethod: _otpChannel.name);
                        }
                      },
                      text: S.of(context).clientRegisterationSignUp,
                    ),
                    HaveOrNotAnAccountRow(
                      questionTxt:
                          S.of(context).clientRegisterationAlreadyHaveAccount,
                      buttonTxt: S.of(context).clientRegisterationLogin,
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

class CountryCodeHelper {
  static String getCountryCodeFromDial(String dialCode) {
    for (var c in countries) {
      if ('+${c.dialCode}' == dialCode) {
        return c.code;
      }
    }
    return 'EG';
  }
}
