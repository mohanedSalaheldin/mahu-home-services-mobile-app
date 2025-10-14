import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/helpers/form_validation_method.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/core/widgets/app_filed_label_text.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_cubit.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_state.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/client_register_screen.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/login_screen.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/verify_account_screen.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/app_back_button.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_snack_bar.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_text_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_text_button.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/have_or_not_an_account_row.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/image_picker_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class ProviderRegisterScreen extends StatefulWidget {
  const ProviderRegisterScreen({super.key});

  @override
  State<ProviderRegisterScreen> createState() => _ProviderRegisterScreenState();
}

class _ProviderRegisterScreenState extends State<ProviderRegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool agreedToTerms = false;
  bool showTermsError = false;
  OtpChannel _otpChannel = OtpChannel.phone;
  String phoneNumber = '';
  String countryCode = '+20'; // default

  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final List<String> categories = [
    'cleaning',
    'repair',
    'painting',
    'electrical'
  ];
  String? selectedCategory;

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = picked);
    }
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
    confirmPasswordController.dispose();
    businessNameController.dispose();
    categoryController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).providerRegisterTitle),
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
                        labelText:
                            S.of(context).providerRegisterPhoneNumberLabel,
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
                      // Use saved country code or fallback to Egypt if none
                      initialCountryCode: countryCode.isNotEmpty
                          ? CountryCodeHelper.getCountryCodeFromDial(
                              countryCode)
                          : 'EG',
                      countries: countries, // full country list
                      controller: phoneController,
                      onChanged: (phone) {
                        phoneNumber = phone.completeNumber;
                        countryCode = phone.countryCode;
                        _saveCountry(countryCode); // persist selection
                      },
                      onCountryChanged: (country) {
                        countryCode = '+${country.dialCode}';
                        _saveCountry(countryCode); // persist selection
                      },
                      validator: (value) {
                        if (value == null || value.number.isEmpty) {
                          return S.of(context).providerRegisterPhoneNumberHint;
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
                      label: S.of(context).providerRegisterEmailLabel,
                      hint: S.of(context).providerRegisterEmailHint,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: FormValidationMethod.validateEmail,
                    ),

                    Gap(10.h),
                    CustomTextField(
                      label: S.of(context).providerRegisterFirstNameLabel,
                      hint: S.of(context).providerRegisterFirstNameHint,
                      keyboardType: TextInputType.name,
                      controller: fNameController,
                      validator: (value) =>
                          FormValidationMethod.validateNameField(
                              value, 'First Name'),
                    ),
                    Gap(10.h),
                    CustomTextField(
                      label: S.of(context).providerRegisterLastNameLabel,
                      hint: S.of(context).providerRegisterLastNameHint,
                      keyboardType: TextInputType.name,
                      controller: lNameController,
                      validator: (value) =>
                          FormValidationMethod.validateNameField(
                              value, 'Last Name'),
                    ),
                    Gap(10.h),
                    CustomTextField(
                      label: S.of(context).providerRegisterBusinessNameLabel,
                      hint: S.of(context).providerRegisterBusinessNameHint,
                      keyboardType: TextInputType.name,
                      controller: businessNameController,
                      validator: (value) =>
                          FormValidationMethod.validateNameField(
                        value,
                        'Business Name',
                      ),
                    ),
                    Gap(10.h),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText:
                            S.of(context).providerRegisterBusinessCategoryLabel,
                        labelStyle: const TextStyle(color: Colors.blue),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      value: selectedCategory,
                      items: categories
                          .map((cat) => DropdownMenuItem(
                                value: cat,
                                child: Text(
                                  cat[0].toUpperCase() + cat.substring(1),
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                          categoryController.text =
                              value ?? ''; // keep it in controller
                        });
                      },
                      validator: (value) => value == null || value.isEmpty
                          ? S.of(context).providerRegisterBusinessCategoryHint
                          : null,
                    ),

                    Gap(10.h),
                    CustomTextField(
                      label: S.of(context).providerRegisterPasswordLabel,
                      hint: S.of(context).providerRegisterPasswordHint,
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      isPassword: true,
                      lines: 1,
                      validator: FormValidationMethod.validatePassword,
                    ),
                    Gap(10.h),
                    CustomTextField(
                      label: S.of(context).providerRegisterConfirmPasswordLabel,
                      hint: S.of(context).providerRegisterConfirmPasswordHint,
                      keyboardType: TextInputType.visiblePassword,
                      controller: confirmPasswordController,
                      isPassword: true,
                      lines: 1,
                      validator: (value) =>
                          FormValidationMethod.validateRepassword(
                              value, passwordController),
                    ),
                    Gap(10.h),
                    AppFieledLabelText(
                      label: S.of(context).providerRegisterUploadLogoLabel,
                    ),
                    Gap(10.h),
                    ImagePickerContainer(
                      onTap: _pickImage,
                      selectedImage: _selectedImage,
                    ),
                    Gap(5.h),
                    Gap(10.h),
                    // NEW: OTP channel section
                    Text(
                      S.of(context).providerRegisterReceiveOtpVia,
                      style: const TextStyle(
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
                      title: Text(
                          S.of(context).providerRegisterOtpPhoneOptionTitle),
                      subtitle: Text(
                          S.of(context).providerRegisterOtpPhoneOptionSubtitle),
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
                      title: Text(
                          S.of(context).providerRegisterOtpEmailOptionTitle),
                      subtitle: Text(
                          S.of(context).providerRegisterOtpEmailOptionSubtitle),
                      secondary: const Icon(Icons.email),
                      dense: true,
                    ),

                    Gap(10.h),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: AppColors.blue,
                          side:
                              const BorderSide(width: 1, color: AppColors.blue),
                          value: agreedToTerms,
                          onChanged: (value) {
                            setState(() {
                              agreedToTerms = value ?? false;
                              if (agreedToTerms) showTermsError = false;
                            });
                          },
                        ),
                        Text(
                          S.of(context).providerRegisterAgreeTerms,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        AppTextButton(
                            txt: S
                                .of(context)
                                .providerRegisterTermsAndConditions,
                            onPressed: () {}),
                      ],
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
                          AuthCubit.get(context).registerAsProvider(
                            email: emailController.text,
                            firstName: fNameController.text,
                            lastName: lNameController.text,
                            password: passwordController.text,
                            phone: countryCode +
                                phoneController.text
                                    .replaceAll(RegExp(r'^\\+'), ''),
                            avatarPath: _selectedImage?.path ?? '',
                            businessName: businessNameController.text,
                            businessCategory: selectedCategory ?? '',
                            otpMethod: _otpChannel.name,
                          );
                          print("Form is valid");
                        }
                      },
                      text: S.of(context).providerRegisterSignUp,
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
                      questionTxt:
                          S.of(context).providerRegisterAlreadyHaveAccount,
                      buttonTxt: S.of(context).providerRegisterLogin,
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

class AppUserConfig {
  static String selectedCountryCode = '+20'; // default Egypt
}

class CountryCodeHelper {
  // Convert '+20' -> 'EG', '+971' -> 'AE', etc.
  static String getCountryCodeFromDial(String dialCode) {
    for (var c in countries) {
      if ('+${c.dialCode}' == dialCode) {
        return c.code;
      }
    }
    return 'EG'; // fallback if not found
  }
}
