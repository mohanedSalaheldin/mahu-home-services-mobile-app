// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Change Language`
  String get landingChangeLanguage {
    return Intl.message(
      'Change Language',
      name: 'landingChangeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get landingSkip {
    return Intl.message(
      'Skip',
      name: 'landingSkip',
      desc: '',
      args: [],
    );
  }

  /// `Professional Home Services\nAt Your Doorstep`
  String get landingTitle1 {
    return Intl.message(
      'Professional Home Services\nAt Your Doorstep',
      name: 'landingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Book trusted professionals for cleaning, repairs, and maintenance with just a few taps`
  String get landingBody1 {
    return Intl.message(
      'Book trusted professionals for cleaning, repairs, and maintenance with just a few taps',
      name: 'landingBody1',
      desc: '',
      args: [],
    );
  }

  /// `Quality Service\nGuaranteed Satisfaction`
  String get landingTitle2 {
    return Intl.message(
      'Quality Service\nGuaranteed Satisfaction',
      name: 'landingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Every service comes with our quality promise and customer satisfaction guarantee`
  String get landingBody2 {
    return Intl.message(
      'Every service comes with our quality promise and customer satisfaction guarantee',
      name: 'landingBody2',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get landingGetStarted {
    return Intl.message(
      'Get Started',
      name: 'landingGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get landingNext {
    return Intl.message(
      'Next',
      name: 'landingNext',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to\nMahu Home Services`
  String get landing2Title {
    return Intl.message(
      'Welcome to\nMahu Home Services',
      name: 'landing2Title',
      desc: '',
      args: [],
    );
  }

  /// `Experience professional home services with guaranteed satisfaction and competitive pricing`
  String get landing2Subtitle {
    return Intl.message(
      'Experience professional home services with guaranteed satisfaction and competitive pricing',
      name: 'landing2Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get landing2GetStarted {
    return Intl.message(
      'Get Started',
      name: 'landing2GetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Sign In`
  String get landing2Login {
    return Intl.message(
      'Already have an account? Sign In',
      name: 'landing2Login',
      desc: '',
      args: [],
    );
  }

  /// `Join as a...`
  String get roleJoinTitle {
    return Intl.message(
      'Join as a...',
      name: 'roleJoinTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select your role to get started`
  String get roleJoinSubtitle {
    return Intl.message(
      'Select your role to get started',
      name: 'roleJoinSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `I'm a Customer`
  String get roleCustomerTitle {
    return Intl.message(
      'I\'m a Customer',
      name: 'roleCustomerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Book home services near you`
  String get roleCustomerDesc {
    return Intl.message(
      'Book home services near you',
      name: 'roleCustomerDesc',
      desc: '',
      args: [],
    );
  }

  /// `I'm a Service Provider`
  String get roleProviderTitle {
    return Intl.message(
      'I\'m a Service Provider',
      name: 'roleProviderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Offer your services to customers`
  String get roleProviderDesc {
    return Intl.message(
      'Offer your services to customers',
      name: 'roleProviderDesc',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueBtn {
    return Intl.message(
      'Continue',
      name: 'continueBtn',
      desc: '',
      args: [],
    );
  }

  /// `Client Registration`
  String get clientRegisterationTitle {
    return Intl.message(
      'Client Registration',
      name: 'clientRegisterationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get clientRegisterationPhoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'clientRegisterationPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a phone number`
  String get clientRegisterationPleaseEnterPhoneNumber {
    return Intl.message(
      'Please enter a phone number',
      name: 'clientRegisterationPleaseEnterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get clientRegisterationEmail {
    return Intl.message(
      'Email',
      name: 'clientRegisterationEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email Address`
  String get clientRegisterationEnterEmailAddress {
    return Intl.message(
      'Enter Email Address',
      name: 'clientRegisterationEnterEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get clientRegisterationFirstName {
    return Intl.message(
      'First Name',
      name: 'clientRegisterationFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Enter First Name`
  String get clientRegisterationEnterFirstName {
    return Intl.message(
      'Enter First Name',
      name: 'clientRegisterationEnterFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get clientRegisterationLastName {
    return Intl.message(
      'Last Name',
      name: 'clientRegisterationLastName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Last Name`
  String get clientRegisterationEnterLastName {
    return Intl.message(
      'Enter Last Name',
      name: 'clientRegisterationEnterLastName',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get clientRegisterationPassword {
    return Intl.message(
      'Password',
      name: 'clientRegisterationPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get clientRegisterationEnterPassword {
    return Intl.message(
      'Enter Password',
      name: 'clientRegisterationEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get clientRegisterationConfirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'clientRegisterationConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Business Reference ID`
  String get clientRegisterationBusinessReferenceId {
    return Intl.message(
      'Business Reference ID',
      name: 'clientRegisterationBusinessReferenceId',
      desc: '',
      args: [],
    );
  }

  /// `Please add reference id`
  String get clientRegisterationPleaseAddReferenceId {
    return Intl.message(
      'Please add reference id',
      name: 'clientRegisterationPleaseAddReferenceId',
      desc: '',
      args: [],
    );
  }

  /// `Reference ID must be numbers only`
  String get clientRegisterationReferenceIdMustBeNumbersOnly {
    return Intl.message(
      'Reference ID must be numbers only',
      name: 'clientRegisterationReferenceIdMustBeNumbersOnly',
      desc: '',
      args: [],
    );
  }

  /// `Receive OTP via`
  String get clientRegisterationReceiveOtpVia {
    return Intl.message(
      'Receive OTP via',
      name: 'clientRegisterationReceiveOtpVia',
      desc: '',
      args: [],
    );
  }

  /// `Phone (WhatsApp)`
  String get clientRegisterationOtpPhoneOptionTitle {
    return Intl.message(
      'Phone (WhatsApp)',
      name: 'clientRegisterationOtpPhoneOptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP to your WhatsApp number`
  String get clientRegisterationOtpPhoneOptionSubtitle {
    return Intl.message(
      'Send OTP to your WhatsApp number',
      name: 'clientRegisterationOtpPhoneOptionSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get clientRegisterationOtpEmailOptionTitle {
    return Intl.message(
      'Email',
      name: 'clientRegisterationOtpEmailOptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP to your email address`
  String get clientRegisterationOtpEmailOptionSubtitle {
    return Intl.message(
      'Send OTP to your email address',
      name: 'clientRegisterationOtpEmailOptionSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `You must agree to the terms before registering.`
  String get clientRegisterationMustAgreeToTerms {
    return Intl.message(
      'You must agree to the terms before registering.',
      name: 'clientRegisterationMustAgreeToTerms',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get clientRegisterationSignUp {
    return Intl.message(
      'Sign Up',
      name: 'clientRegisterationSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account ?`
  String get clientRegisterationAlreadyHaveAccount {
    return Intl.message(
      'Already have an account ?',
      name: 'clientRegisterationAlreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get clientRegisterationLogin {
    return Intl.message(
      'Login',
      name: 'clientRegisterationLogin',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginScreenTitle {
    return Intl.message(
      'Login',
      name: 'loginScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Email or Phone Number`
  String get loginScreenEmailOrPhoneLabel {
    return Intl.message(
      'Email or Phone Number',
      name: 'loginScreenEmailOrPhoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email or Phone Number`
  String get loginScreenEmailOrPhoneHint {
    return Intl.message(
      'Enter Email or Phone Number',
      name: 'loginScreenEmailOrPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginScreenPasswordLabel {
    return Intl.message(
      'Password',
      name: 'loginScreenPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get loginScreenPasswordHint {
    return Intl.message(
      'Enter Password',
      name: 'loginScreenPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get loginScreenRememberMe {
    return Intl.message(
      'Remember Me',
      name: 'loginScreenRememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get loginScreenForgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'loginScreenForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginScreenLoginBtn {
    return Intl.message(
      'Login',
      name: 'loginScreenLoginBtn',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get loginScreenDontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'loginScreenDontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get loginScreenSignUp {
    return Intl.message(
      'Sign Up',
      name: 'loginScreenSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Provider Registration`
  String get providerRegisterTitle {
    return Intl.message(
      'Provider Registration',
      name: 'providerRegisterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get providerRegisterPhoneNumberLabel {
    return Intl.message(
      'Phone Number',
      name: 'providerRegisterPhoneNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a phone number`
  String get providerRegisterPhoneNumberHint {
    return Intl.message(
      'Please enter a phone number',
      name: 'providerRegisterPhoneNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get providerRegisterEmailLabel {
    return Intl.message(
      'Email',
      name: 'providerRegisterEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email Address`
  String get providerRegisterEmailHint {
    return Intl.message(
      'Enter Email Address',
      name: 'providerRegisterEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get providerRegisterFirstNameLabel {
    return Intl.message(
      'First Name',
      name: 'providerRegisterFirstNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter First Name`
  String get providerRegisterFirstNameHint {
    return Intl.message(
      'Enter First Name',
      name: 'providerRegisterFirstNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get providerRegisterLastNameLabel {
    return Intl.message(
      'Last Name',
      name: 'providerRegisterLastNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter Last Name`
  String get providerRegisterLastNameHint {
    return Intl.message(
      'Enter Last Name',
      name: 'providerRegisterLastNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Business Name`
  String get providerRegisterBusinessNameLabel {
    return Intl.message(
      'Business Name',
      name: 'providerRegisterBusinessNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter Business Name`
  String get providerRegisterBusinessNameHint {
    return Intl.message(
      'Enter Business Name',
      name: 'providerRegisterBusinessNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Business Category`
  String get providerRegisterBusinessCategoryLabel {
    return Intl.message(
      'Business Category',
      name: 'providerRegisterBusinessCategoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please select a category`
  String get providerRegisterBusinessCategoryHint {
    return Intl.message(
      'Please select a category',
      name: 'providerRegisterBusinessCategoryHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get providerRegisterPasswordLabel {
    return Intl.message(
      'Password',
      name: 'providerRegisterPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get providerRegisterPasswordHint {
    return Intl.message(
      'Enter Password',
      name: 'providerRegisterPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get providerRegisterConfirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'providerRegisterConfirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get providerRegisterConfirmPasswordHint {
    return Intl.message(
      'Enter Password',
      name: 'providerRegisterConfirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Upload Your Logo`
  String get providerRegisterUploadLogoLabel {
    return Intl.message(
      'Upload Your Logo',
      name: 'providerRegisterUploadLogoLabel',
      desc: '',
      args: [],
    );
  }

  /// `Receive OTP via`
  String get providerRegisterReceiveOtpVia {
    return Intl.message(
      'Receive OTP via',
      name: 'providerRegisterReceiveOtpVia',
      desc: '',
      args: [],
    );
  }

  /// `Phone (WhatsApp)`
  String get providerRegisterOtpPhoneOptionTitle {
    return Intl.message(
      'Phone (WhatsApp)',
      name: 'providerRegisterOtpPhoneOptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP to your WhatsApp number`
  String get providerRegisterOtpPhoneOptionSubtitle {
    return Intl.message(
      'Send OTP to your WhatsApp number',
      name: 'providerRegisterOtpPhoneOptionSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get providerRegisterOtpEmailOptionTitle {
    return Intl.message(
      'Email',
      name: 'providerRegisterOtpEmailOptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP to your email address`
  String get providerRegisterOtpEmailOptionSubtitle {
    return Intl.message(
      'Send OTP to your email address',
      name: 'providerRegisterOtpEmailOptionSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `I agree the `
  String get providerRegisterAgreeTerms {
    return Intl.message(
      'I agree the ',
      name: 'providerRegisterAgreeTerms',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get providerRegisterTermsAndConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'providerRegisterTermsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get providerRegisterSignUp {
    return Intl.message(
      'Sign Up',
      name: 'providerRegisterSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get providerRegisterAlreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'providerRegisterAlreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get providerRegisterLogin {
    return Intl.message(
      'Login',
      name: 'providerRegisterLogin',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgetPasswordScreenTitle {
    return Intl.message(
      'Forgot Password',
      name: 'forgetPasswordScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Email or Phone Number`
  String get forgetPasswordScreenEmailOrPhoneLabel {
    return Intl.message(
      'Email or Phone Number',
      name: 'forgetPasswordScreenEmailOrPhoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email or Phone Number`
  String get forgetPasswordScreenEmailOrPhoneHint {
    return Intl.message(
      'Enter Email or Phone Number',
      name: 'forgetPasswordScreenEmailOrPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get forgetPasswordScreenSendCodeButton {
    return Intl.message(
      'Send Code',
      name: 'forgetPasswordScreenSendCodeButton',
      desc: '',
      args: [],
    );
  }

  /// `Password reset OTP sent`
  String get forgetPasswordScreenSuccessMessage {
    return Intl.message(
      'Password reset OTP sent',
      name: 'forgetPasswordScreenSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPasswordScreenTitle {
    return Intl.message(
      'New Password',
      name: 'newPasswordScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `We have sent verification code to {userEmail}`
  String newPasswordScreenVerificationMessage(Object userEmail) {
    return Intl.message(
      'We have sent verification code to $userEmail',
      name: 'newPasswordScreenVerificationMessage',
      desc: '',
      args: [userEmail],
    );
  }

  /// `OTP`
  String get newPasswordScreenOtpLabel {
    return Intl.message(
      'OTP',
      name: 'newPasswordScreenOtpLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get newPasswordScreenPasswordLabel {
    return Intl.message(
      'Password',
      name: 'newPasswordScreenPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get newPasswordScreenPasswordHint {
    return Intl.message(
      'Enter Password',
      name: 'newPasswordScreenPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get newPasswordScreenConfirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'newPasswordScreenConfirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get newPasswordScreenConfirmPasswordHint {
    return Intl.message(
      'Enter Password',
      name: 'newPasswordScreenConfirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get newPasswordScreenSaveChangesButton {
    return Intl.message(
      'Save Changes',
      name: 'newPasswordScreenSaveChangesButton',
      desc: '',
      args: [],
    );
  }

  /// `Verify Account`
  String get verifyAccountScreenTitle {
    return Intl.message(
      'Verify Account',
      name: 'verifyAccountScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `We have sent verification code to {idThanSendOTPTo}`
  String verifyAccountScreenVerificationMessage(Object idThanSendOTPTo) {
    return Intl.message(
      'We have sent verification code to $idThanSendOTPTo',
      name: 'verifyAccountScreenVerificationMessage',
      desc: '',
      args: [idThanSendOTPTo],
    );
  }

  /// `Don't receive OTP?`
  String get verifyAccountScreenNoOtpQuestion {
    return Intl.message(
      'Don\'t receive OTP?',
      name: 'verifyAccountScreenNoOtpQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Re-send Code`
  String get verifyAccountScreenResendButton {
    return Intl.message(
      'Re-send Code',
      name: 'verifyAccountScreenResendButton',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verifyAccountScreenVerifyButton {
    return Intl.message(
      'Verify',
      name: 'verifyAccountScreenVerifyButton',
      desc: '',
      args: [],
    );
  }

  /// `OTP sent, check your email`
  String get verifyAccountScreenOtpResendSuccess {
    return Intl.message(
      'OTP sent, check your email',
      name: 'verifyAccountScreenOtpResendSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get clientLayoutScreenHomeLabel {
    return Intl.message(
      'Home',
      name: 'clientLayoutScreenHomeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Bookings`
  String get clientLayoutScreenBookingsLabel {
    return Intl.message(
      'Bookings',
      name: 'clientLayoutScreenBookingsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get clientLayoutScreenFavoritesLabel {
    return Intl.message(
      'Favorites',
      name: 'clientLayoutScreenFavoritesLabel',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get clientLayoutScreenProfileLabel {
    return Intl.message(
      'Profile',
      name: 'clientLayoutScreenProfileLabel',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get providerLayoutScreenHomeLabel {
    return Intl.message(
      'Home',
      name: 'providerLayoutScreenHomeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Jobs`
  String get providerLayoutScreenJobsLabel {
    return Intl.message(
      'Jobs',
      name: 'providerLayoutScreenJobsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get providerLayoutScreenCalendarLabel {
    return Intl.message(
      'Calendar',
      name: 'providerLayoutScreenCalendarLabel',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get providerLayoutScreenProfileLabel {
    return Intl.message(
      'Profile',
      name: 'providerLayoutScreenProfileLabel',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get serviceProviderDashboardScreenTitle {
    return Intl.message(
      'Dashboard',
      name: 'serviceProviderDashboardScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Service deleted successfully`
  String get serviceProviderDashboardScreenDeletionSuccess {
    return Intl.message(
      'Service deleted successfully',
      name: 'serviceProviderDashboardScreenDeletionSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get serviceProviderDashboardScreenErrorTitle {
    return Intl.message(
      'Something went wrong',
      name: 'serviceProviderDashboardScreenErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please try again later`
  String get serviceProviderDashboardScreenErrorSubtitle {
    return Intl.message(
      'Please try again later',
      name: 'serviceProviderDashboardScreenErrorSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get serviceProviderDashboardScreenRetryButton {
    return Intl.message(
      'Retry',
      name: 'serviceProviderDashboardScreenRetryButton',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back,`
  String get serviceProviderDashboardScreenWelcome {
    return Intl.message(
      'Welcome back,',
      name: 'serviceProviderDashboardScreenWelcome',
      desc: '',
      args: [],
    );
  }

  /// `Service Provider`
  String get serviceProviderDashboardScreenDefaultProviderName {
    return Intl.message(
      'Service Provider',
      name: 'serviceProviderDashboardScreenDefaultProviderName',
      desc: '',
      args: [],
    );
  }

  /// `Here's your performance overview`
  String get serviceProviderDashboardScreenPerformanceOverview {
    return Intl.message(
      'Here\'s your performance overview',
      name: 'serviceProviderDashboardScreenPerformanceOverview',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get serviceProviderDashboardScreenRatingTitle {
    return Intl.message(
      'Rating',
      name: 'serviceProviderDashboardScreenRatingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Completion Rate`
  String get serviceProviderDashboardScreenCompletionRateTitle {
    return Intl.message(
      'Completion Rate',
      name: 'serviceProviderDashboardScreenCompletionRateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Completed Jobs`
  String get serviceProviderDashboardScreenCompletedJobsTitle {
    return Intl.message(
      'Completed Jobs',
      name: 'serviceProviderDashboardScreenCompletedJobsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Total Earnings`
  String get serviceProviderDashboardScreenTotalEarningsTitle {
    return Intl.message(
      'Total Earnings',
      name: 'serviceProviderDashboardScreenTotalEarningsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your Services`
  String get serviceProviderDashboardScreenServicesTitle {
    return Intl.message(
      'Your Services',
      name: 'serviceProviderDashboardScreenServicesTitle',
      desc: '',
      args: [],
    );
  }

  /// `No services yet`
  String get serviceProviderDashboardScreenNoServicesTitle {
    return Intl.message(
      'No services yet',
      name: 'serviceProviderDashboardScreenNoServicesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add your first service to get started`
  String get serviceProviderDashboardScreenNoServicesSubtitle {
    return Intl.message(
      'Add your first service to get started',
      name: 'serviceProviderDashboardScreenNoServicesSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Add Service`
  String get serviceProviderDashboardScreenAddServiceButton {
    return Intl.message(
      'Add Service',
      name: 'serviceProviderDashboardScreenAddServiceButton',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get serviceProviderDashboardScreenCalendarButton {
    return Intl.message(
      'Calendar',
      name: 'serviceProviderDashboardScreenCalendarButton',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get serviceProviderDashboardScreenServiceActive {
    return Intl.message(
      'Active',
      name: 'serviceProviderDashboardScreenServiceActive',
      desc: '',
      args: [],
    );
  }

  /// `Inactive`
  String get serviceProviderDashboardScreenServiceInactive {
    return Intl.message(
      'Inactive',
      name: 'serviceProviderDashboardScreenServiceInactive',
      desc: '',
      args: [],
    );
  }

  /// `/hr`
  String get serviceProviderDashboardScreenPricingHourly {
    return Intl.message(
      '/hr',
      name: 'serviceProviderDashboardScreenPricingHourly',
      desc: '',
      args: [],
    );
  }

  /// `fixed`
  String get serviceProviderDashboardScreenPricingFixed {
    return Intl.message(
      'fixed',
      name: 'serviceProviderDashboardScreenPricingFixed',
      desc: '',
      args: [],
    );
  }

  /// `/sqft`
  String get serviceProviderDashboardScreenPricingSquareFoot {
    return Intl.message(
      '/sqft',
      name: 'serviceProviderDashboardScreenPricingSquareFoot',
      desc: '',
      args: [],
    );
  }

  /// `My Bookings`
  String get serviceProviderJobsScreenTitle {
    return Intl.message(
      'My Bookings',
      name: 'serviceProviderJobsScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `All Bookings`
  String get serviceProviderJobsScreenFilterAll {
    return Intl.message(
      'All Bookings',
      name: 'serviceProviderJobsScreenFilterAll',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get serviceProviderJobsScreenFilterUpcoming {
    return Intl.message(
      'Upcoming',
      name: 'serviceProviderJobsScreenFilterUpcoming',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get serviceProviderJobsScreenFilterInProgress {
    return Intl.message(
      'In Progress',
      name: 'serviceProviderJobsScreenFilterInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get serviceProviderJobsScreenFilterCompleted {
    return Intl.message(
      'Completed',
      name: 'serviceProviderJobsScreenFilterCompleted',
      desc: '',
      args: [],
    );
  }

  /// `{key}`
  String serviceProviderJobsScreenStatsLabel(Object key) {
    return Intl.message(
      '$key',
      name: 'serviceProviderJobsScreenStatsLabel',
      desc: '',
      args: [key],
    );
  }

  /// `No bookings found`
  String get serviceProviderJobsScreenNoBookingsTitle {
    return Intl.message(
      'No bookings found',
      name: 'serviceProviderJobsScreenNoBookingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `No bookings on {date}`
  String serviceProviderJobsScreenNoBookingsSubtitle(Object date) {
    return Intl.message(
      'No bookings on $date',
      name: 'serviceProviderJobsScreenNoBookingsSubtitle',
      desc: '',
      args: [date],
    );
  }

  /// `Upcoming`
  String get serviceProviderJobsScreenStatusUpcoming {
    return Intl.message(
      'Upcoming',
      name: 'serviceProviderJobsScreenStatusUpcoming',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get serviceProviderJobsScreenStatusInProgress {
    return Intl.message(
      'In Progress',
      name: 'serviceProviderJobsScreenStatusInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get serviceProviderJobsScreenStatusCompleted {
    return Intl.message(
      'Completed',
      name: 'serviceProviderJobsScreenStatusCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get serviceProviderJobsScreenStatusCancelled {
    return Intl.message(
      'Cancelled',
      name: 'serviceProviderJobsScreenStatusCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get serviceProviderJobsScreenPaymentStatusPending {
    return Intl.message(
      'Pending',
      name: 'serviceProviderJobsScreenPaymentStatusPending',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get serviceProviderJobsScreenPaymentStatusPaid {
    return Intl.message(
      'Paid',
      name: 'serviceProviderJobsScreenPaymentStatusPaid',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get serviceProviderJobsScreenPaymentStatusFailed {
    return Intl.message(
      'Failed',
      name: 'serviceProviderJobsScreenPaymentStatusFailed',
      desc: '',
      args: [],
    );
  }

  /// `SUN`
  String get serviceProviderJobsScreenDaySunday {
    return Intl.message(
      'SUN',
      name: 'serviceProviderJobsScreenDaySunday',
      desc: '',
      args: [],
    );
  }

  /// `MON`
  String get serviceProviderJobsScreenDayMonday {
    return Intl.message(
      'MON',
      name: 'serviceProviderJobsScreenDayMonday',
      desc: '',
      args: [],
    );
  }

  /// `TUE`
  String get serviceProviderJobsScreenDayTuesday {
    return Intl.message(
      'TUE',
      name: 'serviceProviderJobsScreenDayTuesday',
      desc: '',
      args: [],
    );
  }

  /// `WED`
  String get serviceProviderJobsScreenDayWednesday {
    return Intl.message(
      'WED',
      name: 'serviceProviderJobsScreenDayWednesday',
      desc: '',
      args: [],
    );
  }

  /// `THU`
  String get serviceProviderJobsScreenDayThursday {
    return Intl.message(
      'THU',
      name: 'serviceProviderJobsScreenDayThursday',
      desc: '',
      args: [],
    );
  }

  /// `FRI`
  String get serviceProviderJobsScreenDayFriday {
    return Intl.message(
      'FRI',
      name: 'serviceProviderJobsScreenDayFriday',
      desc: '',
      args: [],
    );
  }

  /// `SAT`
  String get serviceProviderJobsScreenDaySaturday {
    return Intl.message(
      'SAT',
      name: 'serviceProviderJobsScreenDaySaturday',
      desc: '',
      args: [],
    );
  }

  /// `JAN`
  String get serviceProviderJobsScreenMonthJanuary {
    return Intl.message(
      'JAN',
      name: 'serviceProviderJobsScreenMonthJanuary',
      desc: '',
      args: [],
    );
  }

  /// `FEB`
  String get serviceProviderJobsScreenMonthFebruary {
    return Intl.message(
      'FEB',
      name: 'serviceProviderJobsScreenMonthFebruary',
      desc: '',
      args: [],
    );
  }

  /// `MAR`
  String get serviceProviderJobsScreenMonthMarch {
    return Intl.message(
      'MAR',
      name: 'serviceProviderJobsScreenMonthMarch',
      desc: '',
      args: [],
    );
  }

  /// `APR`
  String get serviceProviderJobsScreenMonthApril {
    return Intl.message(
      'APR',
      name: 'serviceProviderJobsScreenMonthApril',
      desc: '',
      args: [],
    );
  }

  /// `MAY`
  String get serviceProviderJobsScreenMonthMay {
    return Intl.message(
      'MAY',
      name: 'serviceProviderJobsScreenMonthMay',
      desc: '',
      args: [],
    );
  }

  /// `JUN`
  String get serviceProviderJobsScreenMonthJune {
    return Intl.message(
      'JUN',
      name: 'serviceProviderJobsScreenMonthJune',
      desc: '',
      args: [],
    );
  }

  /// `JUL`
  String get serviceProviderJobsScreenMonthJuly {
    return Intl.message(
      'JUL',
      name: 'serviceProviderJobsScreenMonthJuly',
      desc: '',
      args: [],
    );
  }

  /// `AUG`
  String get serviceProviderJobsScreenMonthAugust {
    return Intl.message(
      'AUG',
      name: 'serviceProviderJobsScreenMonthAugust',
      desc: '',
      args: [],
    );
  }

  /// `SEP`
  String get serviceProviderJobsScreenMonthSeptember {
    return Intl.message(
      'SEP',
      name: 'serviceProviderJobsScreenMonthSeptember',
      desc: '',
      args: [],
    );
  }

  /// `OCT`
  String get serviceProviderJobsScreenMonthOctober {
    return Intl.message(
      'OCT',
      name: 'serviceProviderJobsScreenMonthOctober',
      desc: '',
      args: [],
    );
  }

  /// `NOV`
  String get serviceProviderJobsScreenMonthNovember {
    return Intl.message(
      'NOV',
      name: 'serviceProviderJobsScreenMonthNovember',
      desc: '',
      args: [],
    );
  }

  /// `DEC`
  String get serviceProviderJobsScreenMonthDecember {
    return Intl.message(
      'DEC',
      name: 'serviceProviderJobsScreenMonthDecember',
      desc: '',
      args: [],
    );
  }

  /// `Bookings`
  String get serviceProviderBookingsScreenTitle {
    return Intl.message(
      'Bookings',
      name: 'serviceProviderBookingsScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `All Bookings`
  String get serviceProviderBookingsScreenFilterAll {
    return Intl.message(
      'All Bookings',
      name: 'serviceProviderBookingsScreenFilterAll',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get serviceProviderBookingsScreenFilterPending {
    return Intl.message(
      'Pending',
      name: 'serviceProviderBookingsScreenFilterPending',
      desc: '',
      args: [],
    );
  }

  /// `Confirmed`
  String get serviceProviderBookingsScreenFilterConfirmed {
    return Intl.message(
      'Confirmed',
      name: 'serviceProviderBookingsScreenFilterConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get serviceProviderBookingsScreenFilterInProgress {
    return Intl.message(
      'In Progress',
      name: 'serviceProviderBookingsScreenFilterInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get serviceProviderBookingsScreenFilterCompleted {
    return Intl.message(
      'Completed',
      name: 'serviceProviderBookingsScreenFilterCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get serviceProviderBookingsScreenFilterCancelled {
    return Intl.message(
      'Cancelled',
      name: 'serviceProviderBookingsScreenFilterCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Error: {message}`
  String serviceProviderBookingsScreenError(Object message) {
    return Intl.message(
      'Error: $message',
      name: 'serviceProviderBookingsScreenError',
      desc: '',
      args: [message],
    );
  }

  /// `Completed`
  String get serviceProviderBookingsScreenStatsCompleted {
    return Intl.message(
      'Completed',
      name: 'serviceProviderBookingsScreenStatsCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Confirmed`
  String get serviceProviderBookingsScreenStatsConfirmed {
    return Intl.message(
      'Confirmed',
      name: 'serviceProviderBookingsScreenStatsConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get serviceProviderBookingsScreenStatsTotal {
    return Intl.message(
      'Total',
      name: 'serviceProviderBookingsScreenStatsTotal',
      desc: '',
      args: [],
    );
  }

  /// `Could not launch {phoneNumber}`
  String serviceProviderBookingsScreenCallError(Object phoneNumber) {
    return Intl.message(
      'Could not launch $phoneNumber',
      name: 'serviceProviderBookingsScreenCallError',
      desc: '',
      args: [phoneNumber],
    );
  }

  /// `No bookings for this day`
  String get serviceProviderBookingsScreenNoBookingsDay {
    return Intl.message(
      'No bookings for this day',
      name: 'serviceProviderBookingsScreenNoBookingsDay',
      desc: '',
      args: [],
    );
  }

  /// `No {filter} bookings`
  String serviceProviderBookingsScreenNoBookingsFilter(Object filter) {
    return Intl.message(
      'No $filter bookings',
      name: 'serviceProviderBookingsScreenNoBookingsFilter',
      desc: '',
      args: [filter],
    );
  }

  /// `You have no scheduled services for {date}`
  String serviceProviderBookingsScreenNoBookingsSubtitle(Object date) {
    return Intl.message(
      'You have no scheduled services for $date',
      name: 'serviceProviderBookingsScreenNoBookingsSubtitle',
      desc: '',
      args: [date],
    );
  }

  /// `with {clientName}`
  String serviceProviderBookingsScreenWithClient(Object clientName) {
    return Intl.message(
      'with $clientName',
      name: 'serviceProviderBookingsScreenWithClient',
      desc: '',
      args: [clientName],
    );
  }

  /// `Payment: {status}`
  String serviceProviderBookingsScreenPaymentStatus(Object status) {
    return Intl.message(
      'Payment: $status',
      name: 'serviceProviderBookingsScreenPaymentStatus',
      desc: '',
      args: [status],
    );
  }

  /// `Contact`
  String get serviceProviderBookingsScreenContactButton {
    return Intl.message(
      'Contact',
      name: 'serviceProviderBookingsScreenContactButton',
      desc: '',
      args: [],
    );
  }

  /// `Call {firstName}`
  String serviceProviderBookingsScreenCallClient(Object firstName) {
    return Intl.message(
      'Call $firstName',
      name: 'serviceProviderBookingsScreenCallClient',
      desc: '',
      args: [firstName],
    );
  }

  /// `Confirm Action`
  String get serviceProviderBookingsScreenConfirmActionTitle {
    return Intl.message(
      'Confirm Action',
      name: 'serviceProviderBookingsScreenConfirmActionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Confirm this booking?`
  String get serviceProviderBookingsScreenConfirmDialog {
    return Intl.message(
      'Confirm this booking?',
      name: 'serviceProviderBookingsScreenConfirmDialog',
      desc: '',
      args: [],
    );
  }

  /// `Start this job?`
  String get serviceProviderBookingsScreenStartJobDialog {
    return Intl.message(
      'Start this job?',
      name: 'serviceProviderBookingsScreenStartJobDialog',
      desc: '',
      args: [],
    );
  }

  /// `Mark as completed?`
  String get serviceProviderBookingsScreenCompleteDialog {
    return Intl.message(
      'Mark as completed?',
      name: 'serviceProviderBookingsScreenCompleteDialog',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get serviceProviderBookingsScreenCancelButton {
    return Intl.message(
      'Cancel',
      name: 'serviceProviderBookingsScreenCancelButton',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get serviceProviderBookingsScreenConfirmButton {
    return Intl.message(
      'Confirm',
      name: 'serviceProviderBookingsScreenConfirmButton',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get serviceProviderBookingsScreenTodayButton {
    return Intl.message(
      'Today',
      name: 'serviceProviderBookingsScreenTodayButton',
      desc: '',
      args: [],
    );
  }

  /// `S`
  String get serviceProviderBookingsScreenWeekdaySunday {
    return Intl.message(
      'S',
      name: 'serviceProviderBookingsScreenWeekdaySunday',
      desc: '',
      args: [],
    );
  }

  /// `M`
  String get serviceProviderBookingsScreenWeekdayMonday {
    return Intl.message(
      'M',
      name: 'serviceProviderBookingsScreenWeekdayMonday',
      desc: '',
      args: [],
    );
  }

  /// `T`
  String get serviceProviderBookingsScreenWeekdayTuesday {
    return Intl.message(
      'T',
      name: 'serviceProviderBookingsScreenWeekdayTuesday',
      desc: '',
      args: [],
    );
  }

  /// `W`
  String get serviceProviderBookingsScreenWeekdayWednesday {
    return Intl.message(
      'W',
      name: 'serviceProviderBookingsScreenWeekdayWednesday',
      desc: '',
      args: [],
    );
  }

  /// `T`
  String get serviceProviderBookingsScreenWeekdayThursday {
    return Intl.message(
      'T',
      name: 'serviceProviderBookingsScreenWeekdayThursday',
      desc: '',
      args: [],
    );
  }

  /// `F`
  String get serviceProviderBookingsScreenWeekdayFriday {
    return Intl.message(
      'F',
      name: 'serviceProviderBookingsScreenWeekdayFriday',
      desc: '',
      args: [],
    );
  }

  /// `S`
  String get serviceProviderBookingsScreenWeekdaySaturday {
    return Intl.message(
      'S',
      name: 'serviceProviderBookingsScreenWeekdaySaturday',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get serviceProviderBookingsScreenStatusPending {
    return Intl.message(
      'Pending',
      name: 'serviceProviderBookingsScreenStatusPending',
      desc: '',
      args: [],
    );
  }

  /// `Confirmed`
  String get serviceProviderBookingsScreenStatusConfirmed {
    return Intl.message(
      'Confirmed',
      name: 'serviceProviderBookingsScreenStatusConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get serviceProviderBookingsScreenStatusInProgress {
    return Intl.message(
      'In Progress',
      name: 'serviceProviderBookingsScreenStatusInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get serviceProviderBookingsScreenStatusCompleted {
    return Intl.message(
      'Completed',
      name: 'serviceProviderBookingsScreenStatusCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get serviceProviderBookingsScreenStatusCancelled {
    return Intl.message(
      'Cancelled',
      name: 'serviceProviderBookingsScreenStatusCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get serviceProviderBookingsScreenPaymentStatusPaid {
    return Intl.message(
      'Paid',
      name: 'serviceProviderBookingsScreenPaymentStatusPaid',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get serviceProviderBookingsScreenPaymentStatusPending {
    return Intl.message(
      'Pending',
      name: 'serviceProviderBookingsScreenPaymentStatusPending',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get serviceProviderBookingsScreenPaymentStatusFailed {
    return Intl.message(
      'Failed',
      name: 'serviceProviderBookingsScreenPaymentStatusFailed',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get serviceProviderBookingsScreenActionConfirm {
    return Intl.message(
      'Confirm',
      name: 'serviceProviderBookingsScreenActionConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Start Job`
  String get serviceProviderBookingsScreenActionStartJob {
    return Intl.message(
      'Start Job',
      name: 'serviceProviderBookingsScreenActionStartJob',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get serviceProviderBookingsScreenActionComplete {
    return Intl.message(
      'Complete',
      name: 'serviceProviderBookingsScreenActionComplete',
      desc: '',
      args: [],
    );
  }

  /// `View Details`
  String get serviceProviderBookingsScreenActionViewDetails {
    return Intl.message(
      'View Details',
      name: 'serviceProviderBookingsScreenActionViewDetails',
      desc: '',
      args: [],
    );
  }

  /// `Reschedule`
  String get serviceProviderBookingsScreenActionReschedule {
    return Intl.message(
      'Reschedule',
      name: 'serviceProviderBookingsScreenActionReschedule',
      desc: '',
      args: [],
    );
  }

  /// `Action`
  String get serviceProviderBookingsScreenActionDefault {
    return Intl.message(
      'Action',
      name: 'serviceProviderBookingsScreenActionDefault',
      desc: '',
      args: [],
    );
  }

  /// `Error: {message}`
  String profileScreenError(Object message) {
    return Intl.message(
      'Error: $message',
      name: 'profileScreenError',
      desc: '',
      args: [message],
    );
  }

  /// `No profile loaded`
  String get profileScreenNoProfile {
    return Intl.message(
      'No profile loaded',
      name: 'profileScreenNoProfile',
      desc: '',
      args: [],
    );
  }

  /// `The Reference Id: {id}`
  String profileScreenReferenceId(Object id) {
    return Intl.message(
      'The Reference Id: $id',
      name: 'profileScreenReferenceId',
      desc: '',
      args: [id],
    );
  }

  /// `reviews`
  String get profileScreenReviews {
    return Intl.message(
      'reviews',
      name: 'profileScreenReviews',
      desc: '',
      args: [],
    );
  }

  /// `Stats`
  String get profileScreenStatsTitle {
    return Intl.message(
      'Stats',
      name: 'profileScreenStatsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get profileScreenStatsCompleted {
    return Intl.message(
      'Completed',
      name: 'profileScreenStatsCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Total Earnings`
  String get profileScreenStatsTotalEarnings {
    return Intl.message(
      'Total Earnings',
      name: 'profileScreenStatsTotalEarnings',
      desc: '',
      args: [],
    );
  }

  /// `All Jobs`
  String get profileScreenStatsAllJobs {
    return Intl.message(
      'All Jobs',
      name: 'profileScreenStatsAllJobs',
      desc: '',
      args: [],
    );
  }

  /// `Avg. Response Time`
  String get profileScreenResponseTimeTitle {
    return Intl.message(
      'Avg. Response Time',
      name: 'profileScreenResponseTimeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Within 1 hour`
  String get profileScreenResponseTimeValue {
    return Intl.message(
      'Within 1 hour',
      name: 'profileScreenResponseTimeValue',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Plan`
  String get profileScreenSubscriptionPlanTitle {
    return Intl.message(
      'Subscription Plan',
      name: 'profileScreenSubscriptionPlanTitle',
      desc: '',
      args: [],
    );
  }

  /// `You are not subscribed to any plan yet.`
  String get profileScreenNoSubscription {
    return Intl.message(
      'You are not subscribed to any plan yet.',
      name: 'profileScreenNoSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe Now`
  String get profileScreenSubscribeButton {
    return Intl.message(
      'Subscribe Now',
      name: 'profileScreenSubscribeButton',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade Plan`
  String get profileScreenUpgradePlanButton {
    return Intl.message(
      'Upgrade Plan',
      name: 'profileScreenUpgradePlanButton',
      desc: '',
      args: [],
    );
  }

  /// `${price}/{duration} month(s)`
  String profileScreenSubscriptionPrice(Object price, Object duration) {
    return Intl.message(
      '\$$price/$duration month(s)',
      name: 'profileScreenSubscriptionPrice',
      desc: '',
      args: [price, duration],
    );
  }

  /// `Start Date`
  String get profileScreenSubscriptionStartDate {
    return Intl.message(
      'Start Date',
      name: 'profileScreenSubscriptionStartDate',
      desc: '',
      args: [],
    );
  }

  /// `End Date`
  String get profileScreenSubscriptionEndDate {
    return Intl.message(
      'End Date',
      name: 'profileScreenSubscriptionEndDate',
      desc: '',
      args: [],
    );
  }

  /// `Status: {status}`
  String profileScreenSubscriptionStatus(Object status) {
    return Intl.message(
      'Status: $status',
      name: 'profileScreenSubscriptionStatus',
      desc: '',
      args: [status],
    );
  }

  /// `Settings`
  String get profileScreenSettingsTitle {
    return Intl.message(
      'Settings',
      name: 'profileScreenSettingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get profileScreenEditProfile {
    return Intl.message(
      'Edit Profile',
      name: 'profileScreenEditProfile',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get profileScreenLogOut {
    return Intl.message(
      'Log Out',
      name: 'profileScreenLogOut',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get profileScreenLogOutTitle {
    return Intl.message(
      'Log Out',
      name: 'profileScreenLogOutTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get profileScreenLogOutConfirmation {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'profileScreenLogOutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get profileScreenCancelButton {
    return Intl.message(
      'Cancel',
      name: 'profileScreenCancelButton',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get profileScreenLogOutButton {
    return Intl.message(
      'Log Out',
      name: 'profileScreenLogOutButton',
      desc: '',
      args: [],
    );
  }

  /// `Service Details`
  String get serviceDetailsScreenTitle {
    return Intl.message(
      'Service Details',
      name: 'serviceDetailsScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Service activated successfully`
  String get serviceDetailsScreenActivateSuccess {
    return Intl.message(
      'Service activated successfully',
      name: 'serviceDetailsScreenActivateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Service deactivated successfully`
  String get serviceDetailsScreenDeactivateSuccess {
    return Intl.message(
      'Service deactivated successfully',
      name: 'serviceDetailsScreenDeactivateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update service status`
  String get serviceDetailsScreenStatusUpdateFailed {
    return Intl.message(
      'Failed to update service status',
      name: 'serviceDetailsScreenStatusUpdateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get serviceDetailsScreenStatusActive {
    return Intl.message(
      'Active',
      name: 'serviceDetailsScreenStatusActive',
      desc: '',
      args: [],
    );
  }

  /// `Inactive`
  String get serviceDetailsScreenStatusInactive {
    return Intl.message(
      'Inactive',
      name: 'serviceDetailsScreenStatusInactive',
      desc: '',
      args: [],
    );
  }

  /// `Activate Service`
  String get serviceDetailsScreenActivateTitle {
    return Intl.message(
      'Activate Service',
      name: 'serviceDetailsScreenActivateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Deactivate Service`
  String get serviceDetailsScreenDeactivateTitle {
    return Intl.message(
      'Deactivate Service',
      name: 'serviceDetailsScreenDeactivateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to activate this service? It will become visible to customers.`
  String get serviceDetailsScreenActivateConfirmation {
    return Intl.message(
      'Are you sure you want to activate this service? It will become visible to customers.',
      name: 'serviceDetailsScreenActivateConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to deactivate this service? It will no longer be visible to customers.`
  String get serviceDetailsScreenDeactivateConfirmation {
    return Intl.message(
      'Are you sure you want to deactivate this service? It will no longer be visible to customers.',
      name: 'serviceDetailsScreenDeactivateConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get serviceDetailsScreenCancelButton {
    return Intl.message(
      'Cancel',
      name: 'serviceDetailsScreenCancelButton',
      desc: '',
      args: [],
    );
  }

  /// `Activate`
  String get serviceDetailsScreenActivateButton {
    return Intl.message(
      'Activate',
      name: 'serviceDetailsScreenActivateButton',
      desc: '',
      args: [],
    );
  }

  /// `Deactivate`
  String get serviceDetailsScreenDeactivateButton {
    return Intl.message(
      'Deactivate',
      name: 'serviceDetailsScreenDeactivateButton',
      desc: '',
      args: [],
    );
  }

  /// `Add a Service`
  String get addServiceScreenTitle {
    return Intl.message(
      'Add a Service',
      name: 'addServiceScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Added Successfully`
  String get addServiceScreenSuccessMessage {
    return Intl.message(
      'Added Successfully',
      name: 'addServiceScreenSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Service Name`
  String get addServiceScreenServiceNameLabel {
    return Intl.message(
      'Service Name',
      name: 'addServiceScreenServiceNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g., Deep Service, Weekly Maintenance`
  String get addServiceScreenServiceNameHint {
    return Intl.message(
      'e.g., Deep Service, Weekly Maintenance',
      name: 'addServiceScreenServiceNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a service name`
  String get addServiceScreenServiceNameError {
    return Intl.message(
      'Please enter a service name',
      name: 'addServiceScreenServiceNameError',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get addServiceScreenDescriptionLabel {
    return Intl.message(
      'Description',
      name: 'addServiceScreenDescriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Describe your service in detail...`
  String get addServiceScreenDescriptionHint {
    return Intl.message(
      'Describe your service in detail...',
      name: 'addServiceScreenDescriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a description`
  String get addServiceScreenDescriptionEmptyError {
    return Intl.message(
      'Please enter a description',
      name: 'addServiceScreenDescriptionEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Description should be at least 30 characters`
  String get addServiceScreenDescriptionLengthError {
    return Intl.message(
      'Description should be at least 30 characters',
      name: 'addServiceScreenDescriptionLengthError',
      desc: '',
      args: [],
    );
  }

  /// `Service Type`
  String get addServiceScreenServiceTypeSection {
    return Intl.message(
      'Service Type',
      name: 'addServiceScreenServiceTypeSection',
      desc: '',
      args: [],
    );
  }

  /// `Recurring`
  String get addServiceScreenServiceTypeRecurring {
    return Intl.message(
      'Recurring',
      name: 'addServiceScreenServiceTypeRecurring',
      desc: '',
      args: [],
    );
  }

  /// `One Time`
  String get addServiceScreenServiceTypeOneTime {
    return Intl.message(
      'One Time',
      name: 'addServiceScreenServiceTypeOneTime',
      desc: '',
      args: [],
    );
  }

  /// `One-time service is performed once and completed. Ideal for specific Service needs like move-in/move-out Service.`
  String get addServiceScreenServiceTypeOneTimeExplanation {
    return Intl.message(
      'One-time service is performed once and completed. Ideal for specific Service needs like move-in/move-out Service.',
      name: 'addServiceScreenServiceTypeOneTimeExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Recurring service repeats at regular intervals. Perfect for regular maintenance like weekly or monthly Service.`
  String get addServiceScreenServiceTypeRecurringExplanation {
    return Intl.message(
      'Recurring service repeats at regular intervals. Perfect for regular maintenance like weekly or monthly Service.',
      name: 'addServiceScreenServiceTypeRecurringExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Service Type`
  String get addServiceScreenServiceTypeLabel {
    return Intl.message(
      'Service Type',
      name: 'addServiceScreenServiceTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Standard Service`
  String get addServiceScreenSubTypeNormal {
    return Intl.message(
      'Standard Service',
      name: 'addServiceScreenSubTypeNormal',
      desc: '',
      args: [],
    );
  }

  /// `Deep Service`
  String get addServiceScreenSubTypeDeep {
    return Intl.message(
      'Deep Service',
      name: 'addServiceScreenSubTypeDeep',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Service`
  String get addServiceScreenSubTypeWeekly {
    return Intl.message(
      'Weekly Service',
      name: 'addServiceScreenSubTypeWeekly',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Service`
  String get addServiceScreenSubTypeMonthly {
    return Intl.message(
      'Monthly Service',
      name: 'addServiceScreenSubTypeMonthly',
      desc: '',
      args: [],
    );
  }

  /// `Standard Service covering basic tasks like dusting, vacuuming, and surface wiping.`
  String get addServiceScreenSubTypeNormalExplanation {
    return Intl.message(
      'Standard Service covering basic tasks like dusting, vacuuming, and surface wiping.',
      name: 'addServiceScreenSubTypeNormalExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Thorough Service including hard-to-reach areas, grout Service, and detailed attention to all surfaces.`
  String get addServiceScreenSubTypeDeepExplanation {
    return Intl.message(
      'Thorough Service including hard-to-reach areas, grout Service, and detailed attention to all surfaces.',
      name: 'addServiceScreenSubTypeDeepExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Regular weekly maintenance Service to keep your space consistently clean.`
  String get addServiceScreenSubTypeWeeklyExplanation {
    return Intl.message(
      'Regular weekly maintenance Service to keep your space consistently clean.',
      name: 'addServiceScreenSubTypeWeeklyExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Comprehensive monthly Service with deeper attention to detail than weekly service.`
  String get addServiceScreenSubTypeMonthlyExplanation {
    return Intl.message(
      'Comprehensive monthly Service with deeper attention to detail than weekly service.',
      name: 'addServiceScreenSubTypeMonthlyExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Pricing`
  String get addServiceScreenPricingSection {
    return Intl.message(
      'Pricing',
      name: 'addServiceScreenPricingSection',
      desc: '',
      args: [],
    );
  }

  /// `Example: $150 for a complete deep Service service`
  String get addServiceScreenPricingFixedExample {
    return Intl.message(
      'Example: \$150 for a complete deep Service service',
      name: 'addServiceScreenPricingFixedExample',
      desc: '',
      args: [],
    );
  }

  /// `Example: $40/hour (typically 2-4 hours depending on home size)`
  String get addServiceScreenPricingHourlyExample {
    return Intl.message(
      'Example: \$40/hour (typically 2-4 hours depending on home size)',
      name: 'addServiceScreenPricingHourlyExample',
      desc: '',
      args: [],
    );
  }

  /// `Example: $120 per week for regular maintenance`
  String get addServiceScreenPricingWeeklyExample {
    return Intl.message(
      'Example: \$120 per week for regular maintenance',
      name: 'addServiceScreenPricingWeeklyExample',
      desc: '',
      args: [],
    );
  }

  /// `Example: $400 per month for comprehensive service`
  String get addServiceScreenPricingMonthlyExample {
    return Intl.message(
      'Example: \$400 per month for comprehensive service',
      name: 'addServiceScreenPricingMonthlyExample',
      desc: '',
      args: [],
    );
  }

  /// `Fixed Price ($)`
  String get addServiceScreenFixedPriceLabel {
    return Intl.message(
      'Fixed Price (\$)',
      name: 'addServiceScreenFixedPriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Price ($)`
  String get addServiceScreenWeeklyPriceLabel {
    return Intl.message(
      'Weekly Price (\$)',
      name: 'addServiceScreenWeeklyPriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Price ($)`
  String get addServiceScreenMonthlyPriceLabel {
    return Intl.message(
      'Monthly Price (\$)',
      name: 'addServiceScreenMonthlyPriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a price`
  String get addServiceScreenPriceEmptyError {
    return Intl.message(
      'Please enter a price',
      name: 'addServiceScreenPriceEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number`
  String get addServiceScreenPriceInvalidError {
    return Intl.message(
      'Please enter a valid number',
      name: 'addServiceScreenPriceInvalidError',
      desc: '',
      args: [],
    );
  }

  /// `Service Duration`
  String get addServiceScreenDurationSection {
    return Intl.message(
      'Service Duration',
      name: 'addServiceScreenDurationSection',
      desc: '',
      args: [],
    );
  }

  /// `Estimated Service Duration`
  String get addServiceScreenEstimatedDurationLabel {
    return Intl.message(
      'Estimated Service Duration',
      name: 'addServiceScreenEstimatedDurationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get addServiceScreenHoursLabel {
    return Intl.message(
      'Hours',
      name: 'addServiceScreenHoursLabel',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get addServiceScreenMinutesLabel {
    return Intl.message(
      'Minutes',
      name: 'addServiceScreenMinutesLabel',
      desc: '',
      args: [],
    );
  }

  /// `Total Duration: {hours}h {minutes}`
  String addServiceScreenTotalDuration(Object hours, Object minutes) {
    return Intl.message(
      'Total Duration: ${hours}h $minutes',
      name: 'addServiceScreenTotalDuration',
      desc: '',
      args: [hours, minutes],
    );
  }

  /// `Availability`
  String get addServiceScreenAvailabilitySection {
    return Intl.message(
      'Availability',
      name: 'addServiceScreenAvailabilitySection',
      desc: '',
      args: [],
    );
  }

  /// `Available Days`
  String get addServiceScreenAvailableDaysLabel {
    return Intl.message(
      'Available Days',
      name: 'addServiceScreenAvailableDaysLabel',
      desc: '',
      args: [],
    );
  }

  /// `Recurring services are available all days of the week`
  String get addServiceScreenRecurringDaysInfo {
    return Intl.message(
      'Recurring services are available all days of the week',
      name: 'addServiceScreenRecurringDaysInfo',
      desc: '',
      args: [],
    );
  }

  /// `Please select at least one available day`
  String get addServiceScreenAvailableDaysError {
    return Intl.message(
      'Please select at least one available day',
      name: 'addServiceScreenAvailableDaysError',
      desc: '',
      args: [],
    );
  }

  /// `Available Time Slots`
  String get addServiceScreenTimeSlotsLabel {
    return Intl.message(
      'Available Time Slots',
      name: 'addServiceScreenTimeSlotsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please add at least one time slot`
  String get addServiceScreenTimeSlotsError {
    return Intl.message(
      'Please add at least one time slot',
      name: 'addServiceScreenTimeSlotsError',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get addServiceScreenStartTimeLabel {
    return Intl.message(
      'Start Time',
      name: 'addServiceScreenStartTimeLabel',
      desc: '',
      args: [],
    );
  }

  /// `End Time`
  String get addServiceScreenEndTimeLabel {
    return Intl.message(
      'End Time',
      name: 'addServiceScreenEndTimeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add Time Slot`
  String get addServiceScreenAddTimeSlotButton {
    return Intl.message(
      'Add Time Slot',
      name: 'addServiceScreenAddTimeSlotButton',
      desc: '',
      args: [],
    );
  }

  /// `Added Time Slots:`
  String get addServiceScreenAddedTimeSlotsLabel {
    return Intl.message(
      'Added Time Slots:',
      name: 'addServiceScreenAddedTimeSlotsLabel',
      desc: '',
      args: [],
    );
  }

  /// `AM`
  String get addServiceScreenAmLabel {
    return Intl.message(
      'AM',
      name: 'addServiceScreenAmLabel',
      desc: '',
      args: [],
    );
  }

  /// `PM`
  String get addServiceScreenPmLabel {
    return Intl.message(
      'PM',
      name: 'addServiceScreenPmLabel',
      desc: '',
      args: [],
    );
  }

  /// `Hour`
  String get addServiceScreenHourLabel {
    return Intl.message(
      'Hour',
      name: 'addServiceScreenHourLabel',
      desc: '',
      args: [],
    );
  }

  /// `Minute`
  String get addServiceScreenMinuteLabel {
    return Intl.message(
      'Minute',
      name: 'addServiceScreenMinuteLabel',
      desc: '',
      args: [],
    );
  }

  /// `Selected: {time}`
  String addServiceScreenSelectedTime(Object time) {
    return Intl.message(
      'Selected: $time',
      name: 'addServiceScreenSelectedTime',
      desc: '',
      args: [time],
    );
  }

  /// `Publish Service`
  String get addServiceScreenPublishButton {
    return Intl.message(
      'Publish Service',
      name: 'addServiceScreenPublishButton',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get addServiceScreenDayMonday {
    return Intl.message(
      'Monday',
      name: 'addServiceScreenDayMonday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get addServiceScreenDayTuesday {
    return Intl.message(
      'Tuesday',
      name: 'addServiceScreenDayTuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get addServiceScreenDayWednesday {
    return Intl.message(
      'Wednesday',
      name: 'addServiceScreenDayWednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get addServiceScreenDayThursday {
    return Intl.message(
      'Thursday',
      name: 'addServiceScreenDayThursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get addServiceScreenDayFriday {
    return Intl.message(
      'Friday',
      name: 'addServiceScreenDayFriday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get addServiceScreenDaySaturday {
    return Intl.message(
      'Saturday',
      name: 'addServiceScreenDaySaturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get addServiceScreenDaySunday {
    return Intl.message(
      'Sunday',
      name: 'addServiceScreenDaySunday',
      desc: '',
      args: [],
    );
  }

  /// `Edit Service`
  String get updateServiceScreenTitle {
    return Intl.message(
      'Edit Service',
      name: 'updateServiceScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Updated Successfully`
  String get updateServiceScreenSuccessMessage {
    return Intl.message(
      'Updated Successfully',
      name: 'updateServiceScreenSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Service Name`
  String get updateServiceScreenServiceNameLabel {
    return Intl.message(
      'Service Name',
      name: 'updateServiceScreenServiceNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g., Deep Cleaning, Weekly Maintenance`
  String get updateServiceScreenServiceNameHint {
    return Intl.message(
      'e.g., Deep Cleaning, Weekly Maintenance',
      name: 'updateServiceScreenServiceNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a service name`
  String get updateServiceScreenServiceNameError {
    return Intl.message(
      'Please enter a service name',
      name: 'updateServiceScreenServiceNameError',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get updateServiceScreenDescriptionLabel {
    return Intl.message(
      'Description',
      name: 'updateServiceScreenDescriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Describe your cleaning service in detail...`
  String get updateServiceScreenDescriptionHint {
    return Intl.message(
      'Describe your cleaning service in detail...',
      name: 'updateServiceScreenDescriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a description`
  String get updateServiceScreenDescriptionEmptyError {
    return Intl.message(
      'Please enter a description',
      name: 'updateServiceScreenDescriptionEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Description should be at least 30 characters`
  String get updateServiceScreenDescriptionLengthError {
    return Intl.message(
      'Description should be at least 30 characters',
      name: 'updateServiceScreenDescriptionLengthError',
      desc: '',
      args: [],
    );
  }

  /// `Pricing Rate`
  String get updateServiceScreenPricingLabel {
    return Intl.message(
      'Pricing Rate',
      name: 'updateServiceScreenPricingLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pricing Rate`
  String get updateServiceScreenPricingHint {
    return Intl.message(
      'Pricing Rate',
      name: 'updateServiceScreenPricingHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a price`
  String get updateServiceScreenPriceEmptyError {
    return Intl.message(
      'Please enter a price',
      name: 'updateServiceScreenPriceEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number`
  String get updateServiceScreenPriceInvalidError {
    return Intl.message(
      'Please enter a valid number',
      name: 'updateServiceScreenPriceInvalidError',
      desc: '',
      args: [],
    );
  }

  /// `Minimum Duration`
  String get updateServiceScreenDurationLabel {
    return Intl.message(
      'Minimum Duration',
      name: 'updateServiceScreenDurationLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g., 2 hours`
  String get updateServiceScreenDurationHint {
    return Intl.message(
      'e.g., 2 hours',
      name: 'updateServiceScreenDurationHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter duration`
  String get updateServiceScreenDurationEmptyError {
    return Intl.message(
      'Please enter duration',
      name: 'updateServiceScreenDurationEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number`
  String get updateServiceScreenDurationInvalidError {
    return Intl.message(
      'Please enter a valid number',
      name: 'updateServiceScreenDurationInvalidError',
      desc: '',
      args: [],
    );
  }

  /// `Available Days`
  String get updateServiceScreenAvailableDaysLabel {
    return Intl.message(
      'Available Days',
      name: 'updateServiceScreenAvailableDaysLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please select at least one day`
  String get updateServiceScreenAvailableDaysError {
    return Intl.message(
      'Please select at least one day',
      name: 'updateServiceScreenAvailableDaysError',
      desc: '',
      args: [],
    );
  }

  /// `Available Time Slots`
  String get updateServiceScreenTimeSlotsLabel {
    return Intl.message(
      'Available Time Slots',
      name: 'updateServiceScreenTimeSlotsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please add at least one time slot`
  String get updateServiceScreenTimeSlotsError {
    return Intl.message(
      'Please add at least one time slot',
      name: 'updateServiceScreenTimeSlotsError',
      desc: '',
      args: [],
    );
  }

  /// `Publish Service`
  String get updateServiceScreenPublishButton {
    return Intl.message(
      'Publish Service',
      name: 'updateServiceScreenPublishButton',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get updateServiceScreenDayMonday {
    return Intl.message(
      'Monday',
      name: 'updateServiceScreenDayMonday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get updateServiceScreenDayTuesday {
    return Intl.message(
      'Tuesday',
      name: 'updateServiceScreenDayTuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get updateServiceScreenDayWednesday {
    return Intl.message(
      'Wednesday',
      name: 'updateServiceScreenDayWednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get updateServiceScreenDayThursday {
    return Intl.message(
      'Thursday',
      name: 'updateServiceScreenDayThursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get updateServiceScreenDayFriday {
    return Intl.message(
      'Friday',
      name: 'updateServiceScreenDayFriday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get updateServiceScreenDaySaturday {
    return Intl.message(
      'Saturday',
      name: 'updateServiceScreenDaySaturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get updateServiceScreenDaySunday {
    return Intl.message(
      'Sunday',
      name: 'updateServiceScreenDaySunday',
      desc: '',
      args: [],
    );
  }

  /// `Booking Details`
  String get bookingDetailsScreenTitle {
    return Intl.message(
      'Booking Details',
      name: 'bookingDetailsScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `📍 Service Location`
  String get bookingDetailsScreenLocationTitle {
    return Intl.message(
      '📍 Service Location',
      name: 'bookingDetailsScreenLocationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Open in Maps`
  String get bookingDetailsScreenDirectionsTooltip {
    return Intl.message(
      'Open in Maps',
      name: 'bookingDetailsScreenDirectionsTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Loading map...`
  String get bookingDetailsScreenMapLoading {
    return Intl.message(
      'Loading map...',
      name: 'bookingDetailsScreenMapLoading',
      desc: '',
      args: [],
    );
  }

  /// `Location not available`
  String get bookingDetailsScreenMapNotAvailable {
    return Intl.message(
      'Location not available',
      name: 'bookingDetailsScreenMapNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Showing approximate location`
  String get bookingDetailsScreenMapError {
    return Intl.message(
      'Showing approximate location',
      name: 'bookingDetailsScreenMapError',
      desc: '',
      args: [],
    );
  }

  /// `Location: {country}`
  String bookingDetailsScreenLocation(Object country) {
    return Intl.message(
      'Location: $country',
      name: 'bookingDetailsScreenLocation',
      desc: '',
      args: [country],
    );
  }

  /// `Get Directions`
  String get bookingDetailsScreenDirectionsButton {
    return Intl.message(
      'Get Directions',
      name: 'bookingDetailsScreenDirectionsButton',
      desc: '',
      args: [],
    );
  }

  /// `👤 Client Information`
  String get bookingDetailsScreenClientTitle {
    return Intl.message(
      '👤 Client Information',
      name: 'bookingDetailsScreenClientTitle',
      desc: '',
      args: [],
    );
  }

  /// `{rating} ({reviews} reviews)`
  String bookingDetailsScreenRating(Object rating, Object reviews) {
    return Intl.message(
      '$rating ($reviews reviews)',
      name: 'bookingDetailsScreenRating',
      desc: '',
      args: [rating, reviews],
    );
  }

  /// `Phone Number`
  String get bookingDetailsScreenPhoneLabel {
    return Intl.message(
      'Phone Number',
      name: 'bookingDetailsScreenPhoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get bookingDetailsScreenEmailLabel {
    return Intl.message(
      'Email',
      name: 'bookingDetailsScreenEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `🛠️ Service Details`
  String get bookingDetailsScreenServiceTitle {
    return Intl.message(
      '🛠️ Service Details',
      name: 'bookingDetailsScreenServiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Scheduled Date`
  String get bookingDetailsScreenDateLabel {
    return Intl.message(
      'Scheduled Date',
      name: 'bookingDetailsScreenDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Time Slot`
  String get bookingDetailsScreenTimeSlotLabel {
    return Intl.message(
      'Time Slot',
      name: 'bookingDetailsScreenTimeSlotLabel',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get bookingDetailsScreenDurationLabel {
    return Intl.message(
      'Duration',
      name: 'bookingDetailsScreenDurationLabel',
      desc: '',
      args: [],
    );
  }

  /// `{hours} hours`
  String bookingDetailsScreenDurationValue(Object hours) {
    return Intl.message(
      '$hours hours',
      name: 'bookingDetailsScreenDurationValue',
      desc: '',
      args: [hours],
    );
  }

  /// `Service Description`
  String get bookingDetailsScreenDescriptionLabel {
    return Intl.message(
      'Service Description',
      name: 'bookingDetailsScreenDescriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Special Instructions`
  String get bookingDetailsScreenInstructionsLabel {
    return Intl.message(
      'Special Instructions',
      name: 'bookingDetailsScreenInstructionsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Tools Required`
  String get bookingDetailsScreenToolsLabel {
    return Intl.message(
      'Tools Required',
      name: 'bookingDetailsScreenToolsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Client has tools`
  String get bookingDetailsScreenToolsClient {
    return Intl.message(
      'Client has tools',
      name: 'bookingDetailsScreenToolsClient',
      desc: '',
      args: [],
    );
  }

  /// `Bring your own tools`
  String get bookingDetailsScreenToolsProvider {
    return Intl.message(
      'Bring your own tools',
      name: 'bookingDetailsScreenToolsProvider',
      desc: '',
      args: [],
    );
  }

  /// `💰 Payment Information`
  String get bookingDetailsScreenPaymentTitle {
    return Intl.message(
      '💰 Payment Information',
      name: 'bookingDetailsScreenPaymentTitle',
      desc: '',
      args: [],
    );
  }

  /// `Service Fee`
  String get bookingDetailsScreenServiceFeeLabel {
    return Intl.message(
      'Service Fee',
      name: 'bookingDetailsScreenServiceFeeLabel',
      desc: '',
      args: [],
    );
  }

  /// `${price}`
  String bookingDetailsScreenPrice(Object price) {
    return Intl.message(
      '\$$price',
      name: 'bookingDetailsScreenPrice',
      desc: '',
      args: [price],
    );
  }

  /// `Tax`
  String get bookingDetailsScreenTaxLabel {
    return Intl.message(
      'Tax',
      name: 'bookingDetailsScreenTaxLabel',
      desc: '',
      args: [],
    );
  }

  /// `$0.00`
  String get bookingDetailsScreenTaxValue {
    return Intl.message(
      '\$0.00',
      name: 'bookingDetailsScreenTaxValue',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get bookingDetailsScreenTotalLabel {
    return Intl.message(
      'Total Amount',
      name: 'bookingDetailsScreenTotalLabel',
      desc: '',
      args: [],
    );
  }

  /// `Payment Status`
  String get bookingDetailsScreenPaymentStatusLabel {
    return Intl.message(
      'Payment Status',
      name: 'bookingDetailsScreenPaymentStatusLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get bookingDetailsScreenStatusPending {
    return Intl.message(
      'Pending',
      name: 'bookingDetailsScreenStatusPending',
      desc: '',
      args: [],
    );
  }

  /// `Confirmed`
  String get bookingDetailsScreenStatusConfirmed {
    return Intl.message(
      'Confirmed',
      name: 'bookingDetailsScreenStatusConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get bookingDetailsScreenStatusInProgress {
    return Intl.message(
      'In Progress',
      name: 'bookingDetailsScreenStatusInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get bookingDetailsScreenStatusCompleted {
    return Intl.message(
      'Completed',
      name: 'bookingDetailsScreenStatusCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get bookingDetailsScreenStatusCancelled {
    return Intl.message(
      'Cancelled',
      name: 'bookingDetailsScreenStatusCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Booking`
  String get bookingDetailsScreenActionConfirm {
    return Intl.message(
      'Confirm Booking',
      name: 'bookingDetailsScreenActionConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Start Job`
  String get bookingDetailsScreenActionStart {
    return Intl.message(
      'Start Job',
      name: 'bookingDetailsScreenActionStart',
      desc: '',
      args: [],
    );
  }

  /// `Mark as Completed`
  String get bookingDetailsScreenActionComplete {
    return Intl.message(
      'Mark as Completed',
      name: 'bookingDetailsScreenActionComplete',
      desc: '',
      args: [],
    );
  }

  /// `View Receipt`
  String get bookingDetailsScreenActionReceipt {
    return Intl.message(
      'View Receipt',
      name: 'bookingDetailsScreenActionReceipt',
      desc: '',
      args: [],
    );
  }

  /// `Reschedule`
  String get bookingDetailsScreenActionReschedule {
    return Intl.message(
      'Reschedule',
      name: 'bookingDetailsScreenActionReschedule',
      desc: '',
      args: [],
    );
  }

  /// `Action`
  String get bookingDetailsScreenActionDefault {
    return Intl.message(
      'Action',
      name: 'bookingDetailsScreenActionDefault',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Booking`
  String get bookingDetailsScreenConfirmTitle {
    return Intl.message(
      'Confirm Booking',
      name: 'bookingDetailsScreenConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to confirm this booking?`
  String get bookingDetailsScreenConfirmMessage {
    return Intl.message(
      'Are you sure you want to confirm this booking?',
      name: 'bookingDetailsScreenConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `Start Job`
  String get bookingDetailsScreenStartTitle {
    return Intl.message(
      'Start Job',
      name: 'bookingDetailsScreenStartTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you ready to start this job?`
  String get bookingDetailsScreenStartMessage {
    return Intl.message(
      'Are you ready to start this job?',
      name: 'bookingDetailsScreenStartMessage',
      desc: '',
      args: [],
    );
  }

  /// `Complete Job`
  String get bookingDetailsScreenCompleteTitle {
    return Intl.message(
      'Complete Job',
      name: 'bookingDetailsScreenCompleteTitle',
      desc: '',
      args: [],
    );
  }

  /// `Have you completed all the work?`
  String get bookingDetailsScreenCompleteMessage {
    return Intl.message(
      'Have you completed all the work?',
      name: 'bookingDetailsScreenCompleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Booking`
  String get bookingDetailsScreenCancelTitle {
    return Intl.message(
      'Cancel Booking',
      name: 'bookingDetailsScreenCancelTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this booking? This action cannot be undone.`
  String get bookingDetailsScreenCancelMessage {
    return Intl.message(
      'Are you sure you want to cancel this booking? This action cannot be undone.',
      name: 'bookingDetailsScreenCancelMessage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Booking`
  String get bookingDetailsScreenCancelButton {
    return Intl.message(
      'Cancel Booking',
      name: 'bookingDetailsScreenCancelButton',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get bookingDetailsScreenDialogCancel {
    return Intl.message(
      'Cancel',
      name: 'bookingDetailsScreenDialogCancel',
      desc: '',
      args: [],
    );
  }

  /// `Go Back`
  String get bookingDetailsScreenDialogGoBack {
    return Intl.message(
      'Go Back',
      name: 'bookingDetailsScreenDialogGoBack',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get bookingDetailsScreenDialogConfirm {
    return Intl.message(
      'Confirm',
      name: 'bookingDetailsScreenDialogConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Booking status updated to {status}`
  String bookingDetailsScreenStatusUpdated(Object status) {
    return Intl.message(
      'Booking status updated to $status',
      name: 'bookingDetailsScreenStatusUpdated',
      desc: '',
      args: [status],
    );
  }

  /// `Booking has been cancelled`
  String get bookingDetailsScreenCancelSuccess {
    return Intl.message(
      'Booking has been cancelled',
      name: 'bookingDetailsScreenCancelSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Could not open maps app`
  String get bookingDetailsScreenMapsError {
    return Intl.message(
      'Could not open maps app',
      name: 'bookingDetailsScreenMapsError',
      desc: '',
      args: [],
    );
  }

  /// `Could not launch phone call`
  String get bookingDetailsScreenPhoneError {
    return Intl.message(
      'Could not launch phone call',
      name: 'bookingDetailsScreenPhoneError',
      desc: '',
      args: [],
    );
  }

  /// `Could not launch email`
  String get bookingDetailsScreenEmailError {
    return Intl.message(
      'Could not launch email',
      name: 'bookingDetailsScreenEmailError',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfileScreenTitle {
    return Intl.message(
      'Edit Profile',
      name: 'editProfileScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose from Gallery`
  String get editProfileScreenGalleryOption {
    return Intl.message(
      'Choose from Gallery',
      name: 'editProfileScreenGalleryOption',
      desc: '',
      args: [],
    );
  }

  /// `Take Photo`
  String get editProfileScreenCameraOption {
    return Intl.message(
      'Take Photo',
      name: 'editProfileScreenCameraOption',
      desc: '',
      args: [],
    );
  }

  /// `Failed to pick image: {error}`
  String editProfileScreenPickImageError(Object error) {
    return Intl.message(
      'Failed to pick image: $error',
      name: 'editProfileScreenPickImageError',
      desc: '',
      args: [error],
    );
  }

  /// `Failed to upload image`
  String get editProfileScreenUploadImageError {
    return Intl.message(
      'Failed to upload image',
      name: 'editProfileScreenUploadImageError',
      desc: '',
      args: [],
    );
  }

  /// `Failed to upload image: {error}`
  String editProfileScreenUploadImageErrorDetail(Object error) {
    return Intl.message(
      'Failed to upload image: $error',
      name: 'editProfileScreenUploadImageErrorDetail',
      desc: '',
      args: [error],
    );
  }

  /// `Profile updated successfully!`
  String get editProfileScreenSuccessMessage {
    return Intl.message(
      'Profile updated successfully!',
      name: 'editProfileScreenSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get editProfileScreenPersonalInfo {
    return Intl.message(
      'Personal Information',
      name: 'editProfileScreenPersonalInfo',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get editProfileScreenFirstNameLabel {
    return Intl.message(
      'First Name',
      name: 'editProfileScreenFirstNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your first name`
  String get editProfileScreenFirstNameHint {
    return Intl.message(
      'Enter your first name',
      name: 'editProfileScreenFirstNameHint',
      desc: '',
      args: [],
    );
  }

  /// `First name is required`
  String get editProfileScreenFirstNameError {
    return Intl.message(
      'First name is required',
      name: 'editProfileScreenFirstNameError',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get editProfileScreenLastNameLabel {
    return Intl.message(
      'Last Name',
      name: 'editProfileScreenLastNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your last name`
  String get editProfileScreenLastNameHint {
    return Intl.message(
      'Enter your last name',
      name: 'editProfileScreenLastNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Last name is required`
  String get editProfileScreenLastNameError {
    return Intl.message(
      'Last name is required',
      name: 'editProfileScreenLastNameError',
      desc: '',
      args: [],
    );
  }

  /// `Business Name`
  String get editProfileScreenBusinessNameLabel {
    return Intl.message(
      'Business Name',
      name: 'editProfileScreenBusinessNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Business Name`
  String get editProfileScreenBusinessNameHint {
    return Intl.message(
      'Enter your Business Name',
      name: 'editProfileScreenBusinessNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Business name is required`
  String get editProfileScreenBusinessNameError {
    return Intl.message(
      'Business name is required',
      name: 'editProfileScreenBusinessNameError',
      desc: '',
      args: [],
    );
  }

  /// `Contact Information`
  String get editProfileScreenContactInfo {
    return Intl.message(
      'Contact Information',
      name: 'editProfileScreenContactInfo',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get editProfileScreenEmailLabel {
    return Intl.message(
      'Email Address',
      name: 'editProfileScreenEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get editProfileScreenEmailHint {
    return Intl.message(
      'Enter your email',
      name: 'editProfileScreenEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get editProfileScreenEmailEmptyError {
    return Intl.message(
      'Email is required',
      name: 'editProfileScreenEmailEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address`
  String get editProfileScreenEmailInvalidError {
    return Intl.message(
      'Enter a valid email address',
      name: 'editProfileScreenEmailInvalidError',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get editProfileScreenPhoneLabel {
    return Intl.message(
      'Phone Number',
      name: 'editProfileScreenPhoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get editProfileScreenPhoneHint {
    return Intl.message(
      'Enter your phone number',
      name: 'editProfileScreenPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is required`
  String get editProfileScreenPhoneError {
    return Intl.message(
      'Phone number is required',
      name: 'editProfileScreenPhoneError',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get editProfileScreenSaveButton {
    return Intl.message(
      'Save Changes',
      name: 'editProfileScreenSaveButton',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get editProfileScreenCancelButton {
    return Intl.message(
      'Cancel',
      name: 'editProfileScreenCancelButton',
      desc: '',
      args: [],
    );
  }

  /// `Service Details`
  String get detailSectionTitle {
    return Intl.message(
      'Service Details',
      name: 'detailSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get detailSectionCategoryLabel {
    return Intl.message(
      'Category',
      name: 'detailSectionCategoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Service Type`
  String get detailSectionServiceTypeLabel {
    return Intl.message(
      'Service Type',
      name: 'detailSectionServiceTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Sub-Type`
  String get detailSectionSubTypeLabel {
    return Intl.message(
      'Sub-Type',
      name: 'detailSectionSubTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pricing Model`
  String get detailSectionPricingModelLabel {
    return Intl.message(
      'Pricing Model',
      name: 'detailSectionPricingModelLabel',
      desc: '',
      args: [],
    );
  }

  /// `Price of service`
  String get detailSectionPriceRecurringLabel {
    return Intl.message(
      'Price of service',
      name: 'detailSectionPriceRecurringLabel',
      desc: '',
      args: [],
    );
  }

  /// `Price of each hour`
  String get detailSectionPriceHourlyLabel {
    return Intl.message(
      'Price of each hour',
      name: 'detailSectionPriceHourlyLabel',
      desc: '',
      args: [],
    );
  }

  /// `${price}`
  String detailSectionPriceValue(Object price) {
    return Intl.message(
      '\$$price',
      name: 'detailSectionPriceValue',
      desc: '',
      args: [price],
    );
  }

  /// `Duration`
  String get detailSectionDurationLabel {
    return Intl.message(
      'Duration',
      name: 'detailSectionDurationLabel',
      desc: '',
      args: [],
    );
  }

  /// `{hours} hours`
  String detailSectionDurationValue(Object hours) {
    return Intl.message(
      '$hours hours',
      name: 'detailSectionDurationValue',
      desc: '',
      args: [hours],
    );
  }

  /// `Activate Service`
  String get actionButtonsActivate {
    return Intl.message(
      'Activate Service',
      name: 'actionButtonsActivate',
      desc: '',
      args: [],
    );
  }

  /// `Deactivate Service`
  String get actionButtonsDeactivate {
    return Intl.message(
      'Deactivate Service',
      name: 'actionButtonsDeactivate',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get actionButtonsEdit {
    return Intl.message(
      'Edit',
      name: 'actionButtonsEdit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get actionButtonsDelete {
    return Intl.message(
      'Delete',
      name: 'actionButtonsDelete',
      desc: '',
      args: [],
    );
  }

  /// `Add Payment Method`
  String get addPaymentMethodScreenTitle {
    return Intl.message(
      'Add Payment Method',
      name: 'addPaymentMethodScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get addPaymentMethodScreenNameLabel {
    return Intl.message(
      'Name',
      name: 'addPaymentMethodScreenNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter Name`
  String get addPaymentMethodScreenNameHint {
    return Intl.message(
      'Enter Name',
      name: 'addPaymentMethodScreenNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Name is required`
  String get addPaymentMethodScreenNameError {
    return Intl.message(
      'Name is required',
      name: 'addPaymentMethodScreenNameError',
      desc: '',
      args: [],
    );
  }

  /// `Card Number`
  String get addPaymentMethodScreenCardNumberLabel {
    return Intl.message(
      'Card Number',
      name: 'addPaymentMethodScreenCardNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter Card Number`
  String get addPaymentMethodScreenCardNumberHint {
    return Intl.message(
      'Enter Card Number',
      name: 'addPaymentMethodScreenCardNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Card number is required`
  String get addPaymentMethodScreenCardNumberError {
    return Intl.message(
      'Card number is required',
      name: 'addPaymentMethodScreenCardNumberError',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid 16-digit card number`
  String get addPaymentMethodScreenCardNumberInvalidError {
    return Intl.message(
      'Enter a valid 16-digit card number',
      name: 'addPaymentMethodScreenCardNumberInvalidError',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date`
  String get addPaymentMethodScreenExpiryDateLabel {
    return Intl.message(
      'Expiry Date',
      name: 'addPaymentMethodScreenExpiryDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `MM/YY`
  String get addPaymentMethodScreenExpiryDateHint {
    return Intl.message(
      'MM/YY',
      name: 'addPaymentMethodScreenExpiryDateHint',
      desc: '',
      args: [],
    );
  }

  /// `CVV`
  String get addPaymentMethodScreenCvvLabel {
    return Intl.message(
      'CVV',
      name: 'addPaymentMethodScreenCvvLabel',
      desc: '',
      args: [],
    );
  }

  /// `CVV`
  String get addPaymentMethodScreenCvvHint {
    return Intl.message(
      'CVV',
      name: 'addPaymentMethodScreenCvvHint',
      desc: '',
      args: [],
    );
  }

  /// `CVV is required`
  String get addPaymentMethodScreenCvvError {
    return Intl.message(
      'CVV is required',
      name: 'addPaymentMethodScreenCvvError',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid 3 or 4-digit CVV`
  String get addPaymentMethodScreenCvvInvalidError {
    return Intl.message(
      'Enter a valid 3 or 4-digit CVV',
      name: 'addPaymentMethodScreenCvvInvalidError',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the Terms and Conditions`
  String get addPaymentMethodScreenTermsLabel {
    return Intl.message(
      'I agree to the Terms and Conditions',
      name: 'addPaymentMethodScreenTermsLabel',
      desc: '',
      args: [],
    );
  }

  /// `You must agree to the Terms and Conditions`
  String get addPaymentMethodScreenTermsError {
    return Intl.message(
      'You must agree to the Terms and Conditions',
      name: 'addPaymentMethodScreenTermsError',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get addPaymentMethodScreenContinueButton {
    return Intl.message(
      'Continue',
      name: 'addPaymentMethodScreenContinueButton',
      desc: '',
      args: [],
    );
  }

  /// `All Services`
  String get allServicesScreenTitle {
    return Intl.message(
      'All Services',
      name: 'allServicesScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Create Booking`
  String get bookingFormScreenTitle {
    return Intl.message(
      'Create Booking',
      name: 'bookingFormScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Booking created successfully!`
  String get bookingFormScreenSuccessMessage {
    return Intl.message(
      'Booking created successfully!',
      name: 'bookingFormScreenSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Unknown location`
  String get bookingFormScreenUnknownLocation {
    return Intl.message(
      'Unknown location',
      name: 'bookingFormScreenUnknownLocation',
      desc: '',
      args: [],
    );
  }

  /// `Current Location`
  String get bookingFormScreenCurrentLocation {
    return Intl.message(
      'Current Location',
      name: 'bookingFormScreenCurrentLocation',
      desc: '',
      args: [],
    );
  }

  /// `Your Location`
  String get bookingFormScreenLocationLabel {
    return Intl.message(
      'Your Location',
      name: 'bookingFormScreenLocationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Getting your location...`
  String get bookingFormScreenLoadingLocation {
    return Intl.message(
      'Getting your location...',
      name: 'bookingFormScreenLoadingLocation',
      desc: '',
      args: [],
    );
  }

  /// `Location accuracy: ±{meters} meters`
  String bookingFormScreenLocationAccuracy(Object meters) {
    return Intl.message(
      'Location accuracy: ±$meters meters',
      name: 'bookingFormScreenLocationAccuracy',
      desc: '',
      args: [meters],
    );
  }

  /// `Show on map`
  String get bookingFormScreenShowMap {
    return Intl.message(
      'Show on map',
      name: 'bookingFormScreenShowMap',
      desc: '',
      args: [],
    );
  }

  /// `Unable to get your location. Please enable location services.`
  String get bookingFormScreenLocationError {
    return Intl.message(
      'Unable to get your location. Please enable location services.',
      name: 'bookingFormScreenLocationError',
      desc: '',
      args: [],
    );
  }

  /// `Location is required for service booking.`
  String get bookingFormScreenLocationRequired {
    return Intl.message(
      'Location is required for service booking.',
      name: 'bookingFormScreenLocationRequired',
      desc: '',
      args: [],
    );
  }

  /// `Timezone`
  String get bookingFormScreenTimezoneLabel {
    return Intl.message(
      'Timezone',
      name: 'bookingFormScreenTimezoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `Egypt (Cairo)`
  String get bookingFormScreenTimezoneEgypt {
    return Intl.message(
      'Egypt (Cairo)',
      name: 'bookingFormScreenTimezoneEgypt',
      desc: '',
      args: [],
    );
  }

  /// `UAE (Dubai)`
  String get bookingFormScreenTimezoneUae {
    return Intl.message(
      'UAE (Dubai)',
      name: 'bookingFormScreenTimezoneUae',
      desc: '',
      args: [],
    );
  }

  /// `Please select a timezone`
  String get bookingFormScreenTimezoneError {
    return Intl.message(
      'Please select a timezone',
      name: 'bookingFormScreenTimezoneError',
      desc: '',
      args: [],
    );
  }

  /// `Schedule Details`
  String get bookingFormScreenScheduleSection {
    return Intl.message(
      'Schedule Details',
      name: 'bookingFormScreenScheduleSection',
      desc: '',
      args: [],
    );
  }

  /// `Select Day`
  String get bookingFormScreenDayLabel {
    return Intl.message(
      'Select Day',
      name: 'bookingFormScreenDayLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please select a day`
  String get bookingFormScreenDayError {
    return Intl.message(
      'Please select a day',
      name: 'bookingFormScreenDayError',
      desc: '',
      args: [],
    );
  }

  /// `Select Time Slot`
  String get bookingFormScreenTimeSlotLabel {
    return Intl.message(
      'Select Time Slot',
      name: 'bookingFormScreenTimeSlotLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please select a time slot`
  String get bookingFormScreenTimeSlotError {
    return Intl.message(
      'Please select a time slot',
      name: 'bookingFormScreenTimeSlotError',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get bookingFormScreenStartTimeLabel {
    return Intl.message(
      'Start Time',
      name: 'bookingFormScreenStartTimeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Select Start Time:`
  String get bookingFormScreenStartTimeSelectorLabel {
    return Intl.message(
      'Select Start Time:',
      name: 'bookingFormScreenStartTimeSelectorLabel',
      desc: '',
      args: [],
    );
  }

  /// `Available time slot: {startTime} - {endTime}`
  String bookingFormScreenTimeSlotInfo(Object startTime, Object endTime) {
    return Intl.message(
      'Available time slot: $startTime - $endTime',
      name: 'bookingFormScreenTimeSlotInfo',
      desc: '',
      args: [startTime, endTime],
    );
  }

  /// `30-minute intervals`
  String get bookingFormScreenTimeIntervalInfo {
    return Intl.message(
      '30-minute intervals',
      name: 'bookingFormScreenTimeIntervalInfo',
      desc: '',
      args: [],
    );
  }

  /// `No available time steps in this slot`
  String get bookingFormScreenNoTimeSteps {
    return Intl.message(
      'No available time steps in this slot',
      name: 'bookingFormScreenNoTimeSteps',
      desc: '',
      args: [],
    );
  }

  /// `Recurrence Type`
  String get bookingFormScreenRecurrenceLabel {
    return Intl.message(
      'Recurrence Type',
      name: 'bookingFormScreenRecurrenceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get bookingFormScreenStartDateLabel {
    return Intl.message(
      'Start Date',
      name: 'bookingFormScreenStartDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Select booking date`
  String get bookingFormScreenStartDateHint {
    return Intl.message(
      'Select booking date',
      name: 'bookingFormScreenStartDateHint',
      desc: '',
      args: [],
    );
  }

  /// `Select start date for recurrence`
  String get bookingFormScreenStartDateRecurringHint {
    return Intl.message(
      'Select start date for recurrence',
      name: 'bookingFormScreenStartDateRecurringHint',
      desc: '',
      args: [],
    );
  }

  /// `Start date is required`
  String get bookingFormScreenStartDateError {
    return Intl.message(
      'Start date is required',
      name: 'bookingFormScreenStartDateError',
      desc: '',
      args: [],
    );
  }

  /// `Address Details`
  String get bookingFormScreenAddressSection {
    return Intl.message(
      'Address Details',
      name: 'bookingFormScreenAddressSection',
      desc: '',
      args: [],
    );
  }

  /// `Street Address`
  String get bookingFormScreenStreetLabel {
    return Intl.message(
      'Street Address',
      name: 'bookingFormScreenStreetLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter street address`
  String get bookingFormScreenStreetHint {
    return Intl.message(
      'Enter street address',
      name: 'bookingFormScreenStreetHint',
      desc: '',
      args: [],
    );
  }

  /// `Street address is required`
  String get bookingFormScreenStreetError {
    return Intl.message(
      'Street address is required',
      name: 'bookingFormScreenStreetError',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get bookingFormScreenCityLabel {
    return Intl.message(
      'City',
      name: 'bookingFormScreenCityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter city`
  String get bookingFormScreenCityHint {
    return Intl.message(
      'Enter city',
      name: 'bookingFormScreenCityHint',
      desc: '',
      args: [],
    );
  }

  /// `City is required`
  String get bookingFormScreenCityError {
    return Intl.message(
      'City is required',
      name: 'bookingFormScreenCityError',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get bookingFormScreenStateLabel {
    return Intl.message(
      'State',
      name: 'bookingFormScreenStateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter state`
  String get bookingFormScreenStateHint {
    return Intl.message(
      'Enter state',
      name: 'bookingFormScreenStateHint',
      desc: '',
      args: [],
    );
  }

  /// `State is required`
  String get bookingFormScreenStateError {
    return Intl.message(
      'State is required',
      name: 'bookingFormScreenStateError',
      desc: '',
      args: [],
    );
  }

  /// `Zip Code (Optional)`
  String get bookingFormScreenZipCodeLabel {
    return Intl.message(
      'Zip Code (Optional)',
      name: 'bookingFormScreenZipCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter zip code`
  String get bookingFormScreenZipCodeHint {
    return Intl.message(
      'Enter zip code',
      name: 'bookingFormScreenZipCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Additional Information`
  String get bookingFormScreenAdditionalInfoSection {
    return Intl.message(
      'Additional Information',
      name: 'bookingFormScreenAdditionalInfoSection',
      desc: '',
      args: [],
    );
  }

  /// `Do you have tools for this service?`
  String get bookingFormScreenToolsLabel {
    return Intl.message(
      'Do you have tools for this service?',
      name: 'bookingFormScreenToolsLabel',
      desc: '',
      args: [],
    );
  }

  /// `I have the required tools`
  String get bookingFormScreenToolsTitle {
    return Intl.message(
      'I have the required tools',
      name: 'bookingFormScreenToolsTitle',
      desc: '',
      args: [],
    );
  }

  /// `If not, the provider will bring their own`
  String get bookingFormScreenToolsSubtitle {
    return Intl.message(
      'If not, the provider will bring their own',
      name: 'bookingFormScreenToolsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Service Details (Optional)`
  String get bookingFormScreenDetailsLabel {
    return Intl.message(
      'Service Details (Optional)',
      name: 'bookingFormScreenDetailsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Describe any specific requirements...`
  String get bookingFormScreenDetailsHint {
    return Intl.message(
      'Describe any specific requirements...',
      name: 'bookingFormScreenDetailsHint',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get bookingFormScreenCategoryLabel {
    return Intl.message(
      'Category',
      name: 'bookingFormScreenCategoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get bookingFormScreenTypeLabel {
    return Intl.message(
      'Type',
      name: 'bookingFormScreenTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pricing`
  String get bookingFormScreenPricingLabel {
    return Intl.message(
      'Pricing',
      name: 'bookingFormScreenPricingLabel',
      desc: '',
      args: [],
    );
  }

  /// `${price}/{unit}`
  String bookingFormScreenPricingValue(Object price, Object unit) {
    return Intl.message(
      '\$$price/$unit',
      name: 'bookingFormScreenPricingValue',
      desc: '',
      args: [price, unit],
    );
  }

  /// `Minimum Duration`
  String get bookingFormScreenMinDurationLabel {
    return Intl.message(
      'Minimum Duration',
      name: 'bookingFormScreenMinDurationLabel',
      desc: '',
      args: [],
    );
  }

  /// `{hours} hours`
  String bookingFormScreenDurationValue(Object hours) {
    return Intl.message(
      '$hours hours',
      name: 'bookingFormScreenDurationValue',
      desc: '',
      args: [hours],
    );
  }

  /// `Fixed price - duration cannot be changed`
  String get bookingFormScreenFixedPriceNote {
    return Intl.message(
      'Fixed price - duration cannot be changed',
      name: 'bookingFormScreenFixedPriceNote',
      desc: '',
      args: [],
    );
  }

  /// `Pricing Details`
  String get bookingFormScreenPricingDetailsLabel {
    return Intl.message(
      'Pricing Details',
      name: 'bookingFormScreenPricingDetailsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Hourly Rate:`
  String get bookingFormScreenHourlyRateLabel {
    return Intl.message(
      'Hourly Rate:',
      name: 'bookingFormScreenHourlyRateLabel',
      desc: '',
      args: [],
    );
  }

  /// `${rate}/hour`
  String bookingFormScreenHourlyRateValue(Object rate) {
    return Intl.message(
      '\$$rate/hour',
      name: 'bookingFormScreenHourlyRateValue',
      desc: '',
      args: [rate],
    );
  }

  /// `Duration:`
  String get bookingFormScreenDurationLabel {
    return Intl.message(
      'Duration:',
      name: 'bookingFormScreenDurationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Total Price:`
  String get bookingFormScreenTotalPriceLabel {
    return Intl.message(
      'Total Price:',
      name: 'bookingFormScreenTotalPriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `${price}`
  String bookingFormScreenTotalPriceValue(Object price) {
    return Intl.message(
      '\$$price',
      name: 'bookingFormScreenTotalPriceValue',
      desc: '',
      args: [price],
    );
  }

  /// `Select Duration:`
  String get bookingFormScreenDurationSelectorLabel {
    return Intl.message(
      'Select Duration:',
      name: 'bookingFormScreenDurationSelectorLabel',
      desc: '',
      args: [],
    );
  }

  /// `Minimum: {hours} hours`
  String bookingFormScreenDurationMinimum(Object hours) {
    return Intl.message(
      'Minimum: $hours hours',
      name: 'bookingFormScreenDurationMinimum',
      desc: '',
      args: [hours],
    );
  }

  /// `Please enable location services to continue`
  String get bookingFormScreenLocationRequiredError {
    return Intl.message(
      'Please enable location services to continue',
      name: 'bookingFormScreenLocationRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `Duration must be at least {hours} hours`
  String bookingFormScreenDurationError(Object hours) {
    return Intl.message(
      'Duration must be at least $hours hours',
      name: 'bookingFormScreenDurationError',
      desc: '',
      args: [hours],
    );
  }

  /// `Selected start time must be within the chosen time slot`
  String get bookingFormScreenStartTimeError {
    return Intl.message(
      'Selected start time must be within the chosen time slot',
      name: 'bookingFormScreenStartTimeError',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in all address fields`
  String get bookingFormScreenAddressError {
    return Intl.message(
      'Please fill in all address fields',
      name: 'bookingFormScreenAddressError',
      desc: '',
      args: [],
    );
  }

  /// `Please select recurrence type`
  String get bookingFormScreenRecurrenceError {
    return Intl.message(
      'Please select recurrence type',
      name: 'bookingFormScreenRecurrenceError',
      desc: '',
      args: [],
    );
  }

  /// `Create Booking`
  String get bookingFormScreenSubmitButton {
    return Intl.message(
      'Create Booking',
      name: 'bookingFormScreenSubmitButton',
      desc: '',
      args: [],
    );
  }

  /// `Error: {message}`
  String customerHomeScreenFavoriteError(Object message) {
    return Intl.message(
      'Error: $message',
      name: 'customerHomeScreenFavoriteError',
      desc: '',
      args: [message],
    );
  }

  /// `Error loading services: {message}`
  String customerHomeScreenServicesError(Object message) {
    return Intl.message(
      'Error loading services: $message',
      name: 'customerHomeScreenServicesError',
      desc: '',
      args: [message],
    );
  }

  /// `cleaning`
  String get customerHomeScreenCategoryCleaning {
    return Intl.message(
      'cleaning',
      name: 'customerHomeScreenCategoryCleaning',
      desc: '',
      args: [],
    );
  }

  /// `repair`
  String get customerHomeScreenCategoryRepair {
    return Intl.message(
      'repair',
      name: 'customerHomeScreenCategoryRepair',
      desc: '',
      args: [],
    );
  }

  /// `painting`
  String get customerHomeScreenCategoryPainting {
    return Intl.message(
      'painting',
      name: 'customerHomeScreenCategoryPainting',
      desc: '',
      args: [],
    );
  }

  /// `electrical`
  String get customerHomeScreenCategoryElectrical {
    return Intl.message(
      'electrical',
      name: 'customerHomeScreenCategoryElectrical',
      desc: '',
      args: [],
    );
  }

  /// `Special Offers 🎉`
  String get customerHomeScreenSpecialOffers {
    return Intl.message(
      'Special Offers 🎉',
      name: 'customerHomeScreenSpecialOffers',
      desc: '',
      args: [],
    );
  }

  /// `Spring Cleaning Special`
  String get customerHomeScreenOfferSpringCleaningTitle {
    return Intl.message(
      'Spring Cleaning Special',
      name: 'customerHomeScreenOfferSpringCleaningTitle',
      desc: '',
      args: [],
    );
  }

  /// `Get 20% off on deep cleaning services`
  String get customerHomeScreenOfferSpringCleaningSubtitle {
    return Intl.message(
      'Get 20% off on deep cleaning services',
      name: 'customerHomeScreenOfferSpringCleaningSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `20% OFF`
  String get customerHomeScreenOfferSpringCleaningDiscount {
    return Intl.message(
      '20% OFF',
      name: 'customerHomeScreenOfferSpringCleaningDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Maintenance`
  String get customerHomeScreenOfferWeeklyMaintenanceTitle {
    return Intl.message(
      'Weekly Maintenance',
      name: 'customerHomeScreenOfferWeeklyMaintenanceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe & save 30% on recurring services`
  String get customerHomeScreenOfferWeeklyMaintenanceSubtitle {
    return Intl.message(
      'Subscribe & save 30% on recurring services',
      name: 'customerHomeScreenOfferWeeklyMaintenanceSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `30% OFF`
  String get customerHomeScreenOfferWeeklyMaintenanceDiscount {
    return Intl.message(
      '30% OFF',
      name: 'customerHomeScreenOfferWeeklyMaintenanceDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Emergency Repair`
  String get customerHomeScreenOfferEmergencyRepairTitle {
    return Intl.message(
      'Emergency Repair',
      name: 'customerHomeScreenOfferEmergencyRepairTitle',
      desc: '',
      args: [],
    );
  }

  /// `Same-day service available`
  String get customerHomeScreenOfferEmergencyRepairSubtitle {
    return Intl.message(
      'Same-day service available',
      name: 'customerHomeScreenOfferEmergencyRepairSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `15% OFF`
  String get customerHomeScreenOfferEmergencyRepairDiscount {
    return Intl.message(
      '15% OFF',
      name: 'customerHomeScreenOfferEmergencyRepairDiscount',
      desc: '',
      args: [],
    );
  }

  /// `New Customer Bonus`
  String get customerHomeScreenOfferNewCustomerTitle {
    return Intl.message(
      'New Customer Bonus',
      name: 'customerHomeScreenOfferNewCustomerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Get $25 off your first booking`
  String get customerHomeScreenOfferNewCustomerSubtitle {
    return Intl.message(
      'Get \$25 off your first booking',
      name: 'customerHomeScreenOfferNewCustomerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `$25 OFF`
  String get customerHomeScreenOfferNewCustomerDiscount {
    return Intl.message(
      '\$25 OFF',
      name: 'customerHomeScreenOfferNewCustomerDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Limited Time Offer`
  String get customerHomeScreenOfferLimitedTimeTitle {
    return Intl.message(
      'Limited Time Offer',
      name: 'customerHomeScreenOfferLimitedTimeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Book now and get exclusive discounts`
  String get customerHomeScreenOfferLimitedTimeSubtitle {
    return Intl.message(
      'Book now and get exclusive discounts',
      name: 'customerHomeScreenOfferLimitedTimeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `SPECIAL`
  String get customerHomeScreenOfferLimitedTimeDiscount {
    return Intl.message(
      'SPECIAL',
      name: 'customerHomeScreenOfferLimitedTimeDiscount',
      desc: '',
      args: [],
    );
  }

  /// `🔥 Hot Deals`
  String get customerHomeScreenHotDeals {
    return Intl.message(
      '🔥 Hot Deals',
      name: 'customerHomeScreenHotDeals',
      desc: '',
      args: [],
    );
  }

  /// `Business Registration: {registration}`
  String customerHomeScreenBusinessRegistration(Object registration) {
    return Intl.message(
      'Business Registration: $registration',
      name: 'customerHomeScreenBusinessRegistration',
      desc: '',
      args: [registration],
    );
  }

  /// `Claim Offer`
  String get customerHomeScreenClaimOffer {
    return Intl.message(
      'Claim Offer',
      name: 'customerHomeScreenClaimOffer',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get editProfileScreenEmailErrorEmpty {
    return Intl.message(
      'Email is required',
      name: 'editProfileScreenEmailErrorEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address`
  String get editProfileScreenEmailErrorInvalid {
    return Intl.message(
      'Enter a valid email address',
      name: 'editProfileScreenEmailErrorInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Choose from Gallery`
  String get editProfileScreenChooseFromGallery {
    return Intl.message(
      'Choose from Gallery',
      name: 'editProfileScreenChooseFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Take Photo`
  String get editProfileScreenTakePhoto {
    return Intl.message(
      'Take Photo',
      name: 'editProfileScreenTakePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Failed to pick image: {error}`
  String editProfileScreenImagePickError(Object error) {
    return Intl.message(
      'Failed to pick image: $error',
      name: 'editProfileScreenImagePickError',
      desc: '',
      args: [error],
    );
  }

  /// `Failed to upload image`
  String get editProfileScreenImageUploadError {
    return Intl.message(
      'Failed to upload image',
      name: 'editProfileScreenImageUploadError',
      desc: '',
      args: [],
    );
  }

  /// `Failed to upload image: {error}`
  String editProfileScreenImageUploadErrorDetailed(Object error) {
    return Intl.message(
      'Failed to upload image: $error',
      name: 'editProfileScreenImageUploadErrorDetailed',
      desc: '',
      args: [error],
    );
  }

  /// `Help Center`
  String get helpCenterScreenTitle {
    return Intl.message(
      'Help Center',
      name: 'helpCenterScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `How can we help you?`
  String get helpCenterScreenHeader {
    return Intl.message(
      'How can we help you?',
      name: 'helpCenterScreenHeader',
      desc: '',
      args: [],
    );
  }

  /// `Find answers to common questions and get support`
  String get helpCenterScreenSubheader {
    return Intl.message(
      'Find answers to common questions and get support',
      name: 'helpCenterScreenSubheader',
      desc: '',
      args: [],
    );
  }

  /// `Search for help...`
  String get helpCenterScreenSearchHint {
    return Intl.message(
      'Search for help...',
      name: 'helpCenterScreenSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Frequently Asked Questions`
  String get helpCenterScreenFAQTitle {
    return Intl.message(
      'Frequently Asked Questions',
      name: 'helpCenterScreenFAQTitle',
      desc: '',
      args: [],
    );
  }

  /// `How do I book a service?`
  String get helpCenterScreenFAQBookServiceQuestion {
    return Intl.message(
      'How do I book a service?',
      name: 'helpCenterScreenFAQBookServiceQuestion',
      desc: '',
      args: [],
    );
  }

  /// `To book a service, browse available services, select your preferred time slot, and proceed to payment.`
  String get helpCenterScreenFAQBookServiceAnswer {
    return Intl.message(
      'To book a service, browse available services, select your preferred time slot, and proceed to payment.',
      name: 'helpCenterScreenFAQBookServiceAnswer',
      desc: '',
      args: [],
    );
  }

  /// `What payment methods are accepted?`
  String get helpCenterScreenFAQPaymentMethodsQuestion {
    return Intl.message(
      'What payment methods are accepted?',
      name: 'helpCenterScreenFAQPaymentMethodsQuestion',
      desc: '',
      args: [],
    );
  }

  /// `We accept credit cards, debit cards, and mobile payment options.`
  String get helpCenterScreenFAQPaymentMethodsAnswer {
    return Intl.message(
      'We accept credit cards, debit cards, and mobile payment options.',
      name: 'helpCenterScreenFAQPaymentMethodsAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Can I cancel or reschedule my booking?`
  String get helpCenterScreenFAQCancelRescheduleQuestion {
    return Intl.message(
      'Can I cancel or reschedule my booking?',
      name: 'helpCenterScreenFAQCancelRescheduleQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Yes, you can cancel or reschedule up to 24 hours before your appointment.`
  String get helpCenterScreenFAQCancelRescheduleAnswer {
    return Intl.message(
      'Yes, you can cancel or reschedule up to 24 hours before your appointment.',
      name: 'helpCenterScreenFAQCancelRescheduleAnswer',
      desc: '',
      args: [],
    );
  }

  /// `How do I contact my service provider?`
  String get helpCenterScreenFAQContactProviderQuestion {
    return Intl.message(
      'How do I contact my service provider?',
      name: 'helpCenterScreenFAQContactProviderQuestion',
      desc: '',
      args: [],
    );
  }

  /// `You can message your provider directly through the app after booking.`
  String get helpCenterScreenFAQContactProviderAnswer {
    return Intl.message(
      'You can message your provider directly through the app after booking.',
      name: 'helpCenterScreenFAQContactProviderAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Still need help?`
  String get helpCenterScreenContactTitle {
    return Intl.message(
      'Still need help?',
      name: 'helpCenterScreenContactTitle',
      desc: '',
      args: [],
    );
  }

  /// `Our support team is available 24/7 to assist you with any questions or concerns.`
  String get helpCenterScreenContactDescription {
    return Intl.message(
      'Our support team is available 24/7 to assist you with any questions or concerns.',
      name: 'helpCenterScreenContactDescription',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get helpCenterScreenContactEmail {
    return Intl.message(
      'Email',
      name: 'helpCenterScreenContactEmail',
      desc: '',
      args: [],
    );
  }

  /// `Call`
  String get helpCenterScreenContactPhone {
    return Intl.message(
      'Call',
      name: 'helpCenterScreenContactPhone',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get helpCenterScreenContactChat {
    return Intl.message(
      'Chat',
      name: 'helpCenterScreenContactChat',
      desc: '',
      args: [],
    );
  }

  /// `My Bookings`
  String get myBookingsScreenTitle {
    return Intl.message(
      'My Bookings',
      name: 'myBookingsScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get myBookingsScreenTabUpcoming {
    return Intl.message(
      'Upcoming',
      name: 'myBookingsScreenTabUpcoming',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get myBookingsScreenTabPrevious {
    return Intl.message(
      'Previous',
      name: 'myBookingsScreenTabPrevious',
      desc: '',
      args: [],
    );
  }

  /// `Error: {message}`
  String myBookingsScreenError(Object message) {
    return Intl.message(
      'Error: $message',
      name: 'myBookingsScreenError',
      desc: '',
      args: [message],
    );
  }

  /// `No upcoming bookings`
  String get myBookingsScreenNoUpcoming {
    return Intl.message(
      'No upcoming bookings',
      name: 'myBookingsScreenNoUpcoming',
      desc: '',
      args: [],
    );
  }

  /// `No previous bookings`
  String get myBookingsScreenNoPrevious {
    return Intl.message(
      'No previous bookings',
      name: 'myBookingsScreenNoPrevious',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load bookings`
  String get myBookingsScreenLoadError {
    return Intl.message(
      'Failed to load bookings',
      name: 'myBookingsScreenLoadError',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get myBookingsScreenTryAgain {
    return Intl.message(
      'Try Again',
      name: 'myBookingsScreenTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Cancelling booking...`
  String get myBookingsScreenCancelLoading {
    return Intl.message(
      'Cancelling booking...',
      name: 'myBookingsScreenCancelLoading',
      desc: '',
      args: [],
    );
  }

  /// `User not authenticated`
  String get myBookingsScreenNotAuthenticated {
    return Intl.message(
      'User not authenticated',
      name: 'myBookingsScreenNotAuthenticated',
      desc: '',
      args: [],
    );
  }

  /// `Failed to cancel booking please try later`
  String get myBookingsScreenCancelError {
    return Intl.message(
      'Failed to cancel booking please try later',
      name: 'myBookingsScreenCancelError',
      desc: '',
      args: [],
    );
  }

  /// `Booking cancelled successfully`
  String get myBookingsScreenCancelSuccess {
    return Intl.message(
      'Booking cancelled successfully',
      name: 'myBookingsScreenCancelSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Please login to add a review`
  String get myBookingsScreenReviewLoginError {
    return Intl.message(
      'Please login to add a review',
      name: 'myBookingsScreenReviewLoginError',
      desc: '',
      args: [],
    );
  }

  /// `You have already reviewed this service`
  String get myBookingsScreenReviewExistsError {
    return Intl.message(
      'You have already reviewed this service',
      name: 'myBookingsScreenReviewExistsError',
      desc: '',
      args: [],
    );
  }

  /// `Add Review`
  String get myBookingsScreenReviewTitle {
    return Intl.message(
      'Add Review',
      name: 'myBookingsScreenReviewTitle',
      desc: '',
      args: [],
    );
  }

  /// `How would you rate {serviceName}?`
  String myBookingsScreenReviewPrompt(Object serviceName) {
    return Intl.message(
      'How would you rate $serviceName?',
      name: 'myBookingsScreenReviewPrompt',
      desc: '',
      args: [serviceName],
    );
  }

  /// `Your feedback (optional)`
  String get myBookingsScreenReviewFeedbackLabel {
    return Intl.message(
      'Your feedback (optional)',
      name: 'myBookingsScreenReviewFeedbackLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get myBookingsScreenReviewCancel {
    return Intl.message(
      'Cancel',
      name: 'myBookingsScreenReviewCancel',
      desc: '',
      args: [],
    );
  }

  /// `Submit Review`
  String get myBookingsScreenReviewSubmit {
    return Intl.message(
      'Submit Review',
      name: 'myBookingsScreenReviewSubmit',
      desc: '',
      args: [],
    );
  }

  /// `Submitting review...`
  String get myBookingsScreenReviewSubmitting {
    return Intl.message(
      'Submitting review...',
      name: 'myBookingsScreenReviewSubmitting',
      desc: '',
      args: [],
    );
  }

  /// `Failed to submit review: {message}`
  String myBookingsScreenReviewError(Object message) {
    return Intl.message(
      'Failed to submit review: $message',
      name: 'myBookingsScreenReviewError',
      desc: '',
      args: [message],
    );
  }

  /// `Failed to submit review`
  String get myBookingsScreenReviewErrorGeneric {
    return Intl.message(
      'Failed to submit review',
      name: 'myBookingsScreenReviewErrorGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Review submitted successfully!`
  String get myBookingsScreenReviewSuccess {
    return Intl.message(
      'Review submitted successfully!',
      name: 'myBookingsScreenReviewSuccess',
      desc: '',
      args: [],
    );
  }

  /// `{status}`
  String myBookingsScreenStatus(Object status) {
    return Intl.message(
      '$status',
      name: 'myBookingsScreenStatus',
      desc: '',
      args: [status],
    );
  }

  /// `Unknown Service`
  String get myBookingsScreenUnknownService {
    return Intl.message(
      'Unknown Service',
      name: 'myBookingsScreenUnknownService',
      desc: '',
      args: [],
    );
  }

  /// `Add Review`
  String get myBookingsScreenAddReview {
    return Intl.message(
      'Add Review',
      name: 'myBookingsScreenAddReview',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get myBookingsScreenCancelButton {
    return Intl.message(
      'Cancel',
      name: 'myBookingsScreenCancelButton',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get myBookingsScreenDetailsButton {
    return Intl.message(
      'Details',
      name: 'myBookingsScreenDetailsButton',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Booking?`
  String get myBookingsScreenCancelDialogTitle {
    return Intl.message(
      'Cancel Booking?',
      name: 'myBookingsScreenCancelDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel your booking for {serviceName}?`
  String myBookingsScreenCancelDialogContent(Object serviceName) {
    return Intl.message(
      'Are you sure you want to cancel your booking for $serviceName?',
      name: 'myBookingsScreenCancelDialogContent',
      desc: '',
      args: [serviceName],
    );
  }

  /// `Keep Booking`
  String get myBookingsScreenKeepBooking {
    return Intl.message(
      'Keep Booking',
      name: 'myBookingsScreenKeepBooking',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Booking`
  String get myBookingsScreenCancelBooking {
    return Intl.message(
      'Cancel Booking',
      name: 'myBookingsScreenCancelBooking',
      desc: '',
      args: [],
    );
  }

  /// `Booking Details`
  String get myBookingsScreenDetailsTitle {
    return Intl.message(
      'Booking Details',
      name: 'myBookingsScreenDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get myBookingsScreenDetailsService {
    return Intl.message(
      'Service',
      name: 'myBookingsScreenDetailsService',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get myBookingsScreenDetailsStatus {
    return Intl.message(
      'Status',
      name: 'myBookingsScreenDetailsStatus',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get myBookingsScreenDetailsDate {
    return Intl.message(
      'Date',
      name: 'myBookingsScreenDetailsDate',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get myBookingsScreenDetailsStartTime {
    return Intl.message(
      'Start Time',
      name: 'myBookingsScreenDetailsStartTime',
      desc: '',
      args: [],
    );
  }

  /// `End Time`
  String get myBookingsScreenDetailsEndTime {
    return Intl.message(
      'End Time',
      name: 'myBookingsScreenDetailsEndTime',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get myBookingsScreenDetailsDuration {
    return Intl.message(
      'Duration',
      name: 'myBookingsScreenDetailsDuration',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get myBookingsScreenDetailsTotal {
    return Intl.message(
      'Total',
      name: 'myBookingsScreenDetailsTotal',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get myBookingsScreenDetailsAddress {
    return Intl.message(
      'Address',
      name: 'myBookingsScreenDetailsAddress',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get myBookingsScreenDetailsClose {
    return Intl.message(
      'Close',
      name: 'myBookingsScreenDetailsClose',
      desc: '',
      args: [],
    );
  }

  /// `All Reviews ({count})`
  String myBookingsScreenAllReviews(Object count) {
    return Intl.message(
      'All Reviews ($count)',
      name: 'myBookingsScreenAllReviews',
      desc: '',
      args: [count],
    );
  }

  /// `Anonymous`
  String get myBookingsScreenAnonymous {
    return Intl.message(
      'Anonymous',
      name: 'myBookingsScreenAnonymous',
      desc: '',
      args: [],
    );
  }

  /// `hours`
  String get myBookingsScreenHours {
    return Intl.message(
      'hours',
      name: 'myBookingsScreenHours',
      desc: '',
      args: [],
    );
  }

  /// `My Favorites`
  String get favoritesScreenTitle {
    return Intl.message(
      'My Favorites',
      name: 'favoritesScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Loading your favorites...`
  String get favoritesScreenLoading {
    return Intl.message(
      'Loading your favorites...',
      name: 'favoritesScreenLoading',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong`
  String get favoritesScreenErrorTitle {
    return Intl.message(
      'Oops! Something went wrong',
      name: 'favoritesScreenErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Error: {message}`
  String favoritesScreenError(Object message) {
    return Intl.message(
      'Error: $message',
      name: 'favoritesScreenError',
      desc: '',
      args: [message],
    );
  }

  /// `No favorites yet`
  String get favoritesScreenEmptyTitle {
    return Intl.message(
      'No favorites yet',
      name: 'favoritesScreenEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Start saving your favorite services\nby tapping the heart icon`
  String get favoritesScreenEmptyMessage {
    return Intl.message(
      'Start saving your favorite services\nby tapping the heart icon',
      name: 'favoritesScreenEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `💡 Tip: You can favorite services from\nthe home screen or service details`
  String get favoritesScreenEmptyTip {
    return Intl.message(
      '💡 Tip: You can favorite services from\nthe home screen or service details',
      name: 'favoritesScreenEmptyTip',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get favoritesScreenTryAgain {
    return Intl.message(
      'Try Again',
      name: 'favoritesScreenTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Removed from favorites`
  String get favoritesScreenRemovedSuccess {
    return Intl.message(
      'Removed from favorites',
      name: 'favoritesScreenRemovedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `{count} {favoriteText}`
  String favoritesScreenCount(Object count, Object favoriteText) {
    return Intl.message(
      '$count $favoriteText',
      name: 'favoritesScreenCount',
      desc: '',
      args: [count, favoriteText],
    );
  }

  /// `Favorite`
  String get favoritesScreenFavoriteSingular {
    return Intl.message(
      'Favorite',
      name: 'favoritesScreenFavoriteSingular',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favoritesScreenFavoritePlural {
    return Intl.message(
      'Favorites',
      name: 'favoritesScreenFavoritePlural',
      desc: '',
      args: [],
    );
  }

  /// `{hours} hrs`
  String favoritesScreenDuration(Object hours) {
    return Intl.message(
      '$hours hrs',
      name: 'favoritesScreenDuration',
      desc: '',
      args: [hours],
    );
  }

  /// `{category}`
  String favoritesScreenCategory(Object category) {
    return Intl.message(
      '$category',
      name: 'favoritesScreenCategory',
      desc: '',
      args: [category],
    );
  }

  /// `CLEANING`
  String get favoritesScreenCategoryCleaning {
    return Intl.message(
      'CLEANING',
      name: 'favoritesScreenCategoryCleaning',
      desc: '',
      args: [],
    );
  }

  /// `REPAIR`
  String get favoritesScreenCategoryRepair {
    return Intl.message(
      'REPAIR',
      name: 'favoritesScreenCategoryRepair',
      desc: '',
      args: [],
    );
  }

  /// `PAINTING`
  String get favoritesScreenCategoryPainting {
    return Intl.message(
      'PAINTING',
      name: 'favoritesScreenCategoryPainting',
      desc: '',
      args: [],
    );
  }

  /// `ELECTRICAL`
  String get favoritesScreenCategoryElectrical {
    return Intl.message(
      'ELECTRICAL',
      name: 'favoritesScreenCategoryElectrical',
      desc: '',
      args: [],
    );
  }

  /// `OTHER`
  String get favoritesScreenCategoryDefault {
    return Intl.message(
      'OTHER',
      name: 'favoritesScreenCategoryDefault',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicyScreenTitle {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicyScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Last updated: {date}`
  String privacyPolicyScreenLastUpdated(Object date) {
    return Intl.message(
      'Last updated: $date',
      name: 'privacyPolicyScreenLastUpdated',
      desc: '',
      args: [date],
    );
  }

  /// `1. Information We Collect`
  String get privacyPolicyScreenSection1Title {
    return Intl.message(
      '1. Information We Collect',
      name: 'privacyPolicyScreenSection1Title',
      desc: '',
      args: [],
    );
  }

  /// `We collect information you provide directly to us, including:\n- Personal information (name, email, phone number)\n- Service preferences and booking history\n- Payment information\n- Location data for service delivery`
  String get privacyPolicyScreenSection1Content {
    return Intl.message(
      'We collect information you provide directly to us, including:\n- Personal information (name, email, phone number)\n- Service preferences and booking history\n- Payment information\n- Location data for service delivery',
      name: 'privacyPolicyScreenSection1Content',
      desc: '',
      args: [],
    );
  }

  /// `2. How We Use Your Information`
  String get privacyPolicyScreenSection2Title {
    return Intl.message(
      '2. How We Use Your Information',
      name: 'privacyPolicyScreenSection2Title',
      desc: '',
      args: [],
    );
  }

  /// `We use your information to:\n- Provide and improve our services\n- Process your bookings and payments\n- Communicate with you about services\n- Ensure safety and security\n- Comply with legal obligations`
  String get privacyPolicyScreenSection2Content {
    return Intl.message(
      'We use your information to:\n- Provide and improve our services\n- Process your bookings and payments\n- Communicate with you about services\n- Ensure safety and security\n- Comply with legal obligations',
      name: 'privacyPolicyScreenSection2Content',
      desc: '',
      args: [],
    );
  }

  /// `3. Data Sharing`
  String get privacyPolicyScreenSection3Title {
    return Intl.message(
      '3. Data Sharing',
      name: 'privacyPolicyScreenSection3Title',
      desc: '',
      args: [],
    );
  }

  /// `We may share your information with:\n- Service providers to fulfill bookings\n- Payment processors for transaction processing\n- Legal authorities when required by law\n- Business partners with your consent`
  String get privacyPolicyScreenSection3Content {
    return Intl.message(
      'We may share your information with:\n- Service providers to fulfill bookings\n- Payment processors for transaction processing\n- Legal authorities when required by law\n- Business partners with your consent',
      name: 'privacyPolicyScreenSection3Content',
      desc: '',
      args: [],
    );
  }

  /// `4. Data Security`
  String get privacyPolicyScreenSection4Title {
    return Intl.message(
      '4. Data Security',
      name: 'privacyPolicyScreenSection4Title',
      desc: '',
      args: [],
    );
  }

  /// `We implement security measures including:\n- Encryption of sensitive data\n- Secure servers and infrastructure\n- Regular security audits\n- Access controls and authentication`
  String get privacyPolicyScreenSection4Content {
    return Intl.message(
      'We implement security measures including:\n- Encryption of sensitive data\n- Secure servers and infrastructure\n- Regular security audits\n- Access controls and authentication',
      name: 'privacyPolicyScreenSection4Content',
      desc: '',
      args: [],
    );
  }

  /// `5. Your Rights`
  String get privacyPolicyScreenSection5Title {
    return Intl.message(
      '5. Your Rights',
      name: 'privacyPolicyScreenSection5Title',
      desc: '',
      args: [],
    );
  }

  /// `You have the right to:\n- Access your personal information\n- Correct inaccurate data\n- Request data deletion\n- Opt-out of marketing communications\n- Data portability`
  String get privacyPolicyScreenSection5Content {
    return Intl.message(
      'You have the right to:\n- Access your personal information\n- Correct inaccurate data\n- Request data deletion\n- Opt-out of marketing communications\n- Data portability',
      name: 'privacyPolicyScreenSection5Content',
      desc: '',
      args: [],
    );
  }

  /// `6. Contact Us`
  String get privacyPolicyScreenSection6Title {
    return Intl.message(
      '6. Contact Us',
      name: 'privacyPolicyScreenSection6Title',
      desc: '',
      args: [],
    );
  }

  /// `If you have questions about this privacy policy, please contact us at:\n- Email: privacy@mahu.com\n- Phone: +1 (555) 123-4567\n- Address: 123 Service Street, City, Country`
  String get privacyPolicyScreenSection6Content {
    return Intl.message(
      'If you have questions about this privacy policy, please contact us at:\n- Email: privacy@mahu.com\n- Phone: +1 (555) 123-4567\n- Address: 123 Service Street, City, Country',
      name: 'privacyPolicyScreenSection6Content',
      desc: '',
      args: [],
    );
  }

  /// `By using our services, you agree to the terms of this Privacy Policy.`
  String get privacyPolicyScreenConsent {
    return Intl.message(
      'By using our services, you agree to the terms of this Privacy Policy.',
      name: 'privacyPolicyScreenConsent',
      desc: '',
      args: [],
    );
  }

  /// `Loading your profile...`
  String get profileScreenLoading {
    return Intl.message(
      'Loading your profile...',
      name: 'profileScreenLoading',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load profile`
  String get profileScreenErrorTitle {
    return Intl.message(
      'Failed to load profile',
      name: 'profileScreenErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please try again later`
  String get profileScreenErrorDefault {
    return Intl.message(
      'Please try again later',
      name: 'profileScreenErrorDefault',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get profileScreenTryAgain {
    return Intl.message(
      'Try Again',
      name: 'profileScreenTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `User Profile`
  String get profileScreenEmptyTitle {
    return Intl.message(
      'User Profile',
      name: 'profileScreenEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `No profile information available`
  String get profileScreenEmptyMessage {
    return Intl.message(
      'No profile information available',
      name: 'profileScreenEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `This feature is coming soon!`
  String get profileScreenComingSoon {
    return Intl.message(
      'This feature is coming soon!',
      name: 'profileScreenComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `ACCOUNT`
  String get profileScreenSectionAccount {
    return Intl.message(
      'ACCOUNT',
      name: 'profileScreenSectionAccount',
      desc: '',
      args: [],
    );
  }

  /// `SUPPORT`
  String get profileScreenSectionSupport {
    return Intl.message(
      'SUPPORT',
      name: 'profileScreenSectionSupport',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get profileScreenPersonalInfoTitle {
    return Intl.message(
      'Personal Information',
      name: 'profileScreenPersonalInfoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Update your personal details`
  String get profileScreenPersonalInfoSubtitle {
    return Intl.message(
      'Update your personal details',
      name: 'profileScreenPersonalInfoSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Address Book`
  String get profileScreenAddressBookTitle {
    return Intl.message(
      'Address Book',
      name: 'profileScreenAddressBookTitle',
      desc: '',
      args: [],
    );
  }

  /// `Manage your addresses`
  String get profileScreenAddressBookSubtitle {
    return Intl.message(
      'Manage your addresses',
      name: 'profileScreenAddressBookSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Help Center`
  String get profileScreenHelpCenterTitle {
    return Intl.message(
      'Help Center',
      name: 'profileScreenHelpCenterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Get help and support`
  String get profileScreenHelpCenterSubtitle {
    return Intl.message(
      'Get help and support',
      name: 'profileScreenHelpCenterSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get profileScreenPrivacyPolicyTitle {
    return Intl.message(
      'Privacy Policy',
      name: 'profileScreenPrivacyPolicyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Read our privacy policy`
  String get profileScreenPrivacyPolicySubtitle {
    return Intl.message(
      'Read our privacy policy',
      name: 'profileScreenPrivacyPolicySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get profileScreenTermsOfServiceTitle {
    return Intl.message(
      'Terms of Service',
      name: 'profileScreenTermsOfServiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Read our terms and conditions`
  String get profileScreenTermsOfServiceSubtitle {
    return Intl.message(
      'Read our terms and conditions',
      name: 'profileScreenTermsOfServiceSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get profileScreenLogoutTitle {
    return Intl.message(
      'Log Out',
      name: 'profileScreenLogoutTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign out of your account`
  String get profileScreenLogoutSubtitle {
    return Intl.message(
      'Sign out of your account',
      name: 'profileScreenLogoutSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get profileScreenLogoutDialogTitle {
    return Intl.message(
      'Log Out',
      name: 'profileScreenLogoutDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out of your account?`
  String get profileScreenLogoutDialogContent {
    return Intl.message(
      'Are you sure you want to log out of your account?',
      name: 'profileScreenLogoutDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get profileScreenLogoutCancel {
    return Intl.message(
      'Cancel',
      name: 'profileScreenLogoutCancel',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get profileScreenLogoutConfirm {
    return Intl.message(
      'Log Out',
      name: 'profileScreenLogoutConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Unknown User`
  String get profileScreenUnknownUser {
    return Intl.message(
      'Unknown User',
      name: 'profileScreenUnknownUser',
      desc: '',
      args: [],
    );
  }

  /// `No email provided`
  String get profileScreenNoEmail {
    return Intl.message(
      'No email provided',
      name: 'profileScreenNoEmail',
      desc: '',
      args: [],
    );
  }

  /// `No phone provided`
  String get profileScreenNoPhone {
    return Intl.message(
      'No phone provided',
      name: 'profileScreenNoPhone',
      desc: '',
      args: [],
    );
  }

  /// `Search Results for "{query}"`
  String searchResultsScreenTitle(Object query) {
    return Intl.message(
      'Search Results for "$query"',
      name: 'searchResultsScreenTitle',
      desc: '',
      args: [query],
    );
  }

  /// `No services found`
  String get searchResultsScreenEmptyTitle {
    return Intl.message(
      'No services found',
      name: 'searchResultsScreenEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Try searching with different keywords`
  String get searchResultsScreenEmptyMessage {
    return Intl.message(
      'Try searching with different keywords',
      name: 'searchResultsScreenEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `{hours} hrs`
  String searchResultsScreenDuration(Object hours) {
    return Intl.message(
      '$hours hrs',
      name: 'searchResultsScreenDuration',
      desc: '',
      args: [hours],
    );
  }

  /// `CLEANING`
  String get searchResultsScreenCategoryCleaning {
    return Intl.message(
      'CLEANING',
      name: 'searchResultsScreenCategoryCleaning',
      desc: '',
      args: [],
    );
  }

  /// `REPAIR`
  String get searchResultsScreenCategoryRepair {
    return Intl.message(
      'REPAIR',
      name: 'searchResultsScreenCategoryRepair',
      desc: '',
      args: [],
    );
  }

  /// `PAINTING`
  String get searchResultsScreenCategoryPainting {
    return Intl.message(
      'PAINTING',
      name: 'searchResultsScreenCategoryPainting',
      desc: '',
      args: [],
    );
  }

  /// `ELECTRICAL`
  String get searchResultsScreenCategoryElectrical {
    return Intl.message(
      'ELECTRICAL',
      name: 'searchResultsScreenCategoryElectrical',
      desc: '',
      args: [],
    );
  }

  /// `OTHER`
  String get searchResultsScreenCategoryDefault {
    return Intl.message(
      'OTHER',
      name: 'searchResultsScreenCategoryDefault',
      desc: '',
      args: [],
    );
  }

  /// `BASIC`
  String get searchResultsScreenServiceTypeBasic {
    return Intl.message(
      'BASIC',
      name: 'searchResultsScreenServiceTypeBasic',
      desc: '',
      args: [],
    );
  }

  /// `PREMIUM`
  String get searchResultsScreenServiceTypePremium {
    return Intl.message(
      'PREMIUM',
      name: 'searchResultsScreenServiceTypePremium',
      desc: '',
      args: [],
    );
  }

  /// `STANDARD`
  String get searchResultsScreenServiceTypeStandard {
    return Intl.message(
      'STANDARD',
      name: 'searchResultsScreenServiceTypeStandard',
      desc: '',
      args: [],
    );
  }

  /// `OTHER`
  String get searchResultsScreenServiceTypeDefault {
    return Intl.message(
      'OTHER',
      name: 'searchResultsScreenServiceTypeDefault',
      desc: '',
      args: [],
    );
  }

  /// `Select Address`
  String get selectAddressScreenTitle {
    return Intl.message(
      'Select Address',
      name: 'selectAddressScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add New Address`
  String get selectAddressScreenAddNew {
    return Intl.message(
      'Add New Address',
      name: 'selectAddressScreenAddNew',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get selectAddressScreenContinue {
    return Intl.message(
      'Continue',
      name: 'selectAddressScreenContinue',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get selectAddressScreenHomeLabel {
    return Intl.message(
      'Home',
      name: 'selectAddressScreenHomeLabel',
      desc: '',
      args: [],
    );
  }

  /// `7421 Ajman Street, Ajman,\n floor 3, UAE`
  String get selectAddressScreenSampleAddress {
    return Intl.message(
      '7421 Ajman Street, Ajman,\n floor 3, UAE',
      name: 'selectAddressScreenSampleAddress',
      desc: '',
      args: [],
    );
  }

  /// `Select Payment Method`
  String get selectPaymentMethodScreenTitle {
    return Intl.message(
      'Select Payment Method',
      name: 'selectPaymentMethodScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get selectPaymentMethodScreenCashSection {
    return Intl.message(
      'Cash',
      name: 'selectPaymentMethodScreenCashSection',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get selectPaymentMethodScreenCashLabel {
    return Intl.message(
      'Cash',
      name: 'selectPaymentMethodScreenCashLabel',
      desc: '',
      args: [],
    );
  }

  /// `More Payment Options`
  String get selectPaymentMethodScreenMoreOptionsSection {
    return Intl.message(
      'More Payment Options',
      name: 'selectPaymentMethodScreenMoreOptionsSection',
      desc: '',
      args: [],
    );
  }

  /// `Master Card 1`
  String get selectPaymentMethodScreenMasterCardLabel {
    return Intl.message(
      'Master Card 1',
      name: 'selectPaymentMethodScreenMasterCardLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add New Payment Method`
  String get selectPaymentMethodScreenAddNew {
    return Intl.message(
      'Add New Payment Method',
      name: 'selectPaymentMethodScreenAddNew',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get selectPaymentMethodScreenContinue {
    return Intl.message(
      'Continue',
      name: 'selectPaymentMethodScreenContinue',
      desc: '',
      args: [],
    );
  }

  /// `Select Rooms`
  String get selectRoomsScreenTitle {
    return Intl.message(
      'Select Rooms',
      name: 'selectRoomsScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Living Room`
  String get selectRoomsScreenLivingRoomLabel {
    return Intl.message(
      'Living Room',
      name: 'selectRoomsScreenLivingRoomLabel',
      desc: '',
      args: [],
    );
  }

  /// `Bedroom`
  String get selectRoomsScreenBedroomLabel {
    return Intl.message(
      'Bedroom',
      name: 'selectRoomsScreenBedroomLabel',
      desc: '',
      args: [],
    );
  }

  /// `Dining Room`
  String get selectRoomsScreenDiningRoomLabel {
    return Intl.message(
      'Dining Room',
      name: 'selectRoomsScreenDiningRoomLabel',
      desc: '',
      args: [],
    );
  }

  /// `Bathroom`
  String get selectRoomsScreenBathroomLabel {
    return Intl.message(
      'Bathroom',
      name: 'selectRoomsScreenBathroomLabel',
      desc: '',
      args: [],
    );
  }

  /// `Kitchen`
  String get selectRoomsScreenKitchenLabel {
    return Intl.message(
      'Kitchen',
      name: 'selectRoomsScreenKitchenLabel',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get selectRoomsScreenContinue {
    return Intl.message(
      'Continue',
      name: 'selectRoomsScreenContinue',
      desc: '',
      args: [],
    );
  }

  /// `{count} Services Available`
  String serviceCategoryScreenServicesCount(Object count) {
    return Intl.message(
      '$count Services Available',
      name: 'serviceCategoryScreenServicesCount',
      desc: '',
      args: [count],
    );
  }

  /// `No services found`
  String get serviceCategoryScreenEmptyTitle {
    return Intl.message(
      'No services found',
      name: 'serviceCategoryScreenEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `We currently have no {category} services available`
  String serviceCategoryScreenEmptyMessage(Object category) {
    return Intl.message(
      'We currently have no $category services available',
      name: 'serviceCategoryScreenEmptyMessage',
      desc: '',
      args: [category],
    );
  }

  /// `Deep Clean`
  String get serviceCategoryScreenDeepCleanTitle {
    return Intl.message(
      'Deep Clean',
      name: 'serviceCategoryScreenDeepCleanTitle',
      desc: '',
      args: [],
    );
  }

  /// `Recurring`
  String get serviceCategoryScreenRecurringTitle {
    return Intl.message(
      'Recurring',
      name: 'serviceCategoryScreenRecurringTitle',
      desc: '',
      args: [],
    );
  }

  /// `One-Time`
  String get serviceCategoryScreenOneTimeTitle {
    return Intl.message(
      'One-Time',
      name: 'serviceCategoryScreenOneTimeTitle',
      desc: '',
      args: [],
    );
  }

  /// `{categoryName}`
  String serviceCategoryScreenDefaultTitle(Object categoryName) {
    return Intl.message(
      '$categoryName',
      name: 'serviceCategoryScreenDefaultTitle',
      desc: '',
      args: [categoryName],
    );
  }

  /// `Thorough cleaning of all areas including hard-to-reach spots. Perfect for deep sanitization and intensive cleaning needs.`
  String get serviceCategoryScreenDeepCleanDescription {
    return Intl.message(
      'Thorough cleaning of all areas including hard-to-reach spots. Perfect for deep sanitization and intensive cleaning needs.',
      name: 'serviceCategoryScreenDeepCleanDescription',
      desc: '',
      args: [],
    );
  }

  /// `Regular scheduled cleaning services to maintain your space. Set your preferred frequency and enjoy consistent cleanliness.`
  String get serviceCategoryScreenRecurringDescription {
    return Intl.message(
      'Regular scheduled cleaning services to maintain your space. Set your preferred frequency and enjoy consistent cleanliness.',
      name: 'serviceCategoryScreenRecurringDescription',
      desc: '',
      args: [],
    );
  }

  /// `Single cleaning sessions for specific needs. Ideal for special occasions, move-ins/move-outs, or when you need a one-time refresh.`
  String get serviceCategoryScreenOneTimeDescription {
    return Intl.message(
      'Single cleaning sessions for specific needs. Ideal for special occasions, move-ins/move-outs, or when you need a one-time refresh.',
      name: 'serviceCategoryScreenOneTimeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Browse our {categoryName} services in this category.`
  String serviceCategoryScreenDefaultDescription(Object categoryName) {
    return Intl.message(
      'Browse our $categoryName services in this category.',
      name: 'serviceCategoryScreenDefaultDescription',
      desc: '',
      args: [categoryName],
    );
  }

  /// `Recurring`
  String get serviceCategoryScreenServiceTypeRecurring {
    return Intl.message(
      'Recurring',
      name: 'serviceCategoryScreenServiceTypeRecurring',
      desc: '',
      args: [],
    );
  }

  /// `One-Time`
  String get serviceCategoryScreenServiceTypeOneTime {
    return Intl.message(
      'One-Time',
      name: 'serviceCategoryScreenServiceTypeOneTime',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get serviceCategoryScreenServiceTypeDefault {
    return Intl.message(
      'Other',
      name: 'serviceCategoryScreenServiceTypeDefault',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get serviceCategoryScreenUnknownProvider {
    return Intl.message(
      'Unknown',
      name: 'serviceCategoryScreenUnknownProvider',
      desc: '',
      args: [],
    );
  }

  /// `Independent Provider`
  String get serviceCategoryScreenDefaultProvider {
    return Intl.message(
      'Independent Provider',
      name: 'serviceCategoryScreenDefaultProvider',
      desc: '',
      args: [],
    );
  }

  /// `Error: {message}`
  String serviceDetailsScreenFavoriteError(Object message) {
    return Intl.message(
      'Error: $message',
      name: 'serviceDetailsScreenFavoriteError',
      desc: '',
      args: [message],
    );
  }

  /// `{rating} ({count} reviews)`
  String serviceDetailsScreenRating(Object rating, Object count) {
    return Intl.message(
      '$rating ($count reviews)',
      name: 'serviceDetailsScreenRating',
      desc: '',
      args: [rating, count],
    );
  }

  /// `{hours} hours`
  String serviceDetailsScreenDuration(Object hours) {
    return Intl.message(
      '$hours hours',
      name: 'serviceDetailsScreenDuration',
      desc: '',
      args: [hours],
    );
  }

  /// `Available Time`
  String get serviceDetailsScreenAvailableTimeTitle {
    return Intl.message(
      'Available Time',
      name: 'serviceDetailsScreenAvailableTimeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Available Days:`
  String get serviceDetailsScreenAvailableDaysLabel {
    return Intl.message(
      'Available Days:',
      name: 'serviceDetailsScreenAvailableDaysLabel',
      desc: '',
      args: [],
    );
  }

  /// `Time Slots:`
  String get serviceDetailsScreenTimeSlotsLabel {
    return Intl.message(
      'Time Slots:',
      name: 'serviceDetailsScreenTimeSlotsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Starting from`
  String get serviceDetailsScreenStartingFrom {
    return Intl.message(
      'Starting from',
      name: 'serviceDetailsScreenStartingFrom',
      desc: '',
      args: [],
    );
  }

  /// `Book Now`
  String get serviceDetailsScreenBookNow {
    return Intl.message(
      'Book Now',
      name: 'serviceDetailsScreenBookNow',
      desc: '',
      args: [],
    );
  }

  /// `About This Service`
  String get serviceDetailsScreenAboutTitle {
    return Intl.message(
      'About This Service',
      name: 'serviceDetailsScreenAboutTitle',
      desc: '',
      args: [],
    );
  }

  /// ` Read more`
  String get serviceDetailsScreenReadMore {
    return Intl.message(
      ' Read more',
      name: 'serviceDetailsScreenReadMore',
      desc: '',
      args: [],
    );
  }

  /// ` Show less`
  String get serviceDetailsScreenShowLess {
    return Intl.message(
      ' Show less',
      name: 'serviceDetailsScreenShowLess',
      desc: '',
      args: [],
    );
  }

  /// `Customer Reviews`
  String get serviceDetailsScreenReviewsTitle {
    return Intl.message(
      'Customer Reviews',
      name: 'serviceDetailsScreenReviewsTitle',
      desc: '',
      args: [],
    );
  }

  /// `{count} reviews`
  String serviceDetailsScreenReviewsCount(Object count) {
    return Intl.message(
      '$count reviews',
      name: 'serviceDetailsScreenReviewsCount',
      desc: '',
      args: [count],
    );
  }

  /// `No reviews yet`
  String get serviceDetailsScreenNoReviewsTitle {
    return Intl.message(
      'No reviews yet',
      name: 'serviceDetailsScreenNoReviewsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Be the first to review this service!`
  String get serviceDetailsScreenNoReviewsMessage {
    return Intl.message(
      'Be the first to review this service!',
      name: 'serviceDetailsScreenNoReviewsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Based on {count} reviews`
  String serviceDetailsScreenBasedOnReviews(Object count) {
    return Intl.message(
      'Based on $count reviews',
      name: 'serviceDetailsScreenBasedOnReviews',
      desc: '',
      args: [count],
    );
  }

  /// `View all {count} reviews`
  String serviceDetailsScreenViewAllReviews(Object count) {
    return Intl.message(
      'View all $count reviews',
      name: 'serviceDetailsScreenViewAllReviews',
      desc: '',
      args: [count],
    );
  }

  /// `All Reviews ({count})`
  String serviceDetailsScreenAllReviewsTitle(Object count) {
    return Intl.message(
      'All Reviews ($count)',
      name: 'serviceDetailsScreenAllReviewsTitle',
      desc: '',
      args: [count],
    );
  }

  /// `Recurring`
  String get serviceDetailsScreenServiceTypeRecurring {
    return Intl.message(
      'Recurring',
      name: 'serviceDetailsScreenServiceTypeRecurring',
      desc: '',
      args: [],
    );
  }

  /// `One-Time`
  String get serviceDetailsScreenServiceTypeOneTime {
    return Intl.message(
      'One-Time',
      name: 'serviceDetailsScreenServiceTypeOneTime',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get serviceDetailsScreenServiceTypeDefault {
    return Intl.message(
      'Other',
      name: 'serviceDetailsScreenServiceTypeDefault',
      desc: '',
      args: [],
    );
  }

  /// `Service Provider`
  String get serviceDetailsScreenDefaultProviderName {
    return Intl.message(
      'Service Provider',
      name: 'serviceDetailsScreenDefaultProviderName',
      desc: '',
      args: [],
    );
  }

  /// `Independent Provider`
  String get serviceDetailsScreenDefaultProviderType {
    return Intl.message(
      'Independent Provider',
      name: 'serviceDetailsScreenDefaultProviderType',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termsOfServiceScreenTitle {
    return Intl.message(
      'Terms of Service',
      name: 'termsOfServiceScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Last updated: {date}`
  String termsOfServiceScreenLastUpdated(Object date) {
    return Intl.message(
      'Last updated: $date',
      name: 'termsOfServiceScreenLastUpdated',
      desc: '',
      args: [date],
    );
  }

  /// `Please read these Terms of Service carefully before using our services.`
  String get termsOfServiceScreenIntro {
    return Intl.message(
      'Please read these Terms of Service carefully before using our services.',
      name: 'termsOfServiceScreenIntro',
      desc: '',
      args: [],
    );
  }

  /// `1. Acceptance of Terms`
  String get termsOfServiceScreenSection1Title {
    return Intl.message(
      '1. Acceptance of Terms',
      name: 'termsOfServiceScreenSection1Title',
      desc: '',
      args: [],
    );
  }

  /// `By accessing or using Mahu Home Services, you agree to be bound by these Terms of Service and our Privacy Policy. If you do not agree to these terms, please do not use our services.`
  String get termsOfServiceScreenSection1Content {
    return Intl.message(
      'By accessing or using Mahu Home Services, you agree to be bound by these Terms of Service and our Privacy Policy. If you do not agree to these terms, please do not use our services.',
      name: 'termsOfServiceScreenSection1Content',
      desc: '',
      args: [],
    );
  }

  /// `2. Service Description`
  String get termsOfServiceScreenSection2Title {
    return Intl.message(
      '2. Service Description',
      name: 'termsOfServiceScreenSection2Title',
      desc: '',
      args: [],
    );
  }

  /// `Mahu Home Services connects users with service providers for various home services including cleaning, repair, painting, and electrical services. We act as an intermediary platform.`
  String get termsOfServiceScreenSection2Content {
    return Intl.message(
      'Mahu Home Services connects users with service providers for various home services including cleaning, repair, painting, and electrical services. We act as an intermediary platform.',
      name: 'termsOfServiceScreenSection2Content',
      desc: '',
      args: [],
    );
  }

  /// `3. User Accounts`
  String get termsOfServiceScreenSection3Title {
    return Intl.message(
      '3. User Accounts',
      name: 'termsOfServiceScreenSection3Title',
      desc: '',
      args: [],
    );
  }

  /// `You must create an account to use our services. You are responsible for:\n- Maintaining account security\n- Providing accurate information\n- All activities under your account\n- Notifying us of unauthorized access`
  String get termsOfServiceScreenSection3Content {
    return Intl.message(
      'You must create an account to use our services. You are responsible for:\n- Maintaining account security\n- Providing accurate information\n- All activities under your account\n- Notifying us of unauthorized access',
      name: 'termsOfServiceScreenSection3Content',
      desc: '',
      args: [],
    );
  }

  /// `4. Booking and Payments`
  String get termsOfServiceScreenSection4Title {
    return Intl.message(
      '4. Booking and Payments',
      name: 'termsOfServiceScreenSection4Title',
      desc: '',
      args: [],
    );
  }

  /// `- Bookings are subject to provider availability\n- Payments are processed through secure channels\n- Cancellation policies vary by service type\n- Refunds are subject to our refund policy`
  String get termsOfServiceScreenSection4Content {
    return Intl.message(
      '- Bookings are subject to provider availability\n- Payments are processed through secure channels\n- Cancellation policies vary by service type\n- Refunds are subject to our refund policy',
      name: 'termsOfServiceScreenSection4Content',
      desc: '',
      args: [],
    );
  }

  /// `5. User Conduct`
  String get termsOfServiceScreenSection5Title {
    return Intl.message(
      '5. User Conduct',
      name: 'termsOfServiceScreenSection5Title',
      desc: '',
      args: [],
    );
  }

  /// `You agree not to:\n- Use the service for illegal purposes\n- Harass service providers or other users\n- Post false or misleading information\n- Attempt to circumvent the platform\n- Damage the reputation of the service`
  String get termsOfServiceScreenSection5Content {
    return Intl.message(
      'You agree not to:\n- Use the service for illegal purposes\n- Harass service providers or other users\n- Post false or misleading information\n- Attempt to circumvent the platform\n- Damage the reputation of the service',
      name: 'termsOfServiceScreenSection5Content',
      desc: '',
      args: [],
    );
  }

  /// `6. Limitation of Liability`
  String get termsOfServiceScreenSection6Title {
    return Intl.message(
      '6. Limitation of Liability',
      name: 'termsOfServiceScreenSection6Title',
      desc: '',
      args: [],
    );
  }

  /// `Mahu Home Services is not liable for:\n- Quality of services provided by third parties\n- Damages or losses during service provision\n- Disputes between users and service providers\n- Technical issues beyond our control`
  String get termsOfServiceScreenSection6Content {
    return Intl.message(
      'Mahu Home Services is not liable for:\n- Quality of services provided by third parties\n- Damages or losses during service provision\n- Disputes between users and service providers\n- Technical issues beyond our control',
      name: 'termsOfServiceScreenSection6Content',
      desc: '',
      args: [],
    );
  }

  /// `7. Termination`
  String get termsOfServiceScreenSection7Title {
    return Intl.message(
      '7. Termination',
      name: 'termsOfServiceScreenSection7Title',
      desc: '',
      args: [],
    );
  }

  /// `We may terminate or suspend your account at our discretion if you violate these terms. You may also terminate your account at any time.`
  String get termsOfServiceScreenSection7Content {
    return Intl.message(
      'We may terminate or suspend your account at our discretion if you violate these terms. You may also terminate your account at any time.',
      name: 'termsOfServiceScreenSection7Content',
      desc: '',
      args: [],
    );
  }

  /// `8. Changes to Terms`
  String get termsOfServiceScreenSection8Title {
    return Intl.message(
      '8. Changes to Terms',
      name: 'termsOfServiceScreenSection8Title',
      desc: '',
      args: [],
    );
  }

  /// `We may modify these terms at any time. Continued use of the service constitutes acceptance of modified terms.`
  String get termsOfServiceScreenSection8Content {
    return Intl.message(
      'We may modify these terms at any time. Continued use of the service constitutes acceptance of modified terms.',
      name: 'termsOfServiceScreenSection8Content',
      desc: '',
      args: [],
    );
  }

  /// `9. Governing Law`
  String get termsOfServiceScreenSection9Title {
    return Intl.message(
      '9. Governing Law',
      name: 'termsOfServiceScreenSection9Title',
      desc: '',
      args: [],
    );
  }

  /// `These terms are governed by the laws of {jurisdiction}. Any disputes shall be resolved in the courts of {jurisdiction}.`
  String termsOfServiceScreenSection9Content(Object jurisdiction) {
    return Intl.message(
      'These terms are governed by the laws of $jurisdiction. Any disputes shall be resolved in the courts of $jurisdiction.',
      name: 'termsOfServiceScreenSection9Content',
      desc: '',
      args: [jurisdiction],
    );
  }

  /// `By using Mahu Home Services, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service.`
  String get termsOfServiceScreenAcknowledgment {
    return Intl.message(
      'By using Mahu Home Services, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service.',
      name: 'termsOfServiceScreenAcknowledgment',
      desc: '',
      args: [],
    );
  }

  /// `Your Jurisdiction`
  String get termsOfServiceScreenDefaultJurisdiction {
    return Intl.message(
      'Your Jurisdiction',
      name: 'termsOfServiceScreenDefaultJurisdiction',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categoriesWidgetTitle {
    return Intl.message(
      'Categories',
      name: 'categoriesWidgetTitle',
      desc: '',
      args: [],
    );
  }

  /// `Deep Clean`
  String get categoriesWidgetDeepCleanLabel {
    return Intl.message(
      'Deep Clean',
      name: 'categoriesWidgetDeepCleanLabel',
      desc: '',
      args: [],
    );
  }

  /// `Recurring`
  String get categoriesWidgetRecurringLabel {
    return Intl.message(
      'Recurring',
      name: 'categoriesWidgetRecurringLabel',
      desc: '',
      args: [],
    );
  }

  /// `One-Time`
  String get categoriesWidgetOneTimeLabel {
    return Intl.message(
      'One-Time',
      name: 'categoriesWidgetOneTimeLabel',
      desc: '',
      args: [],
    );
  }

  /// `{label}`
  String categoriesWidgetDefaultLabel(Object label) {
    return Intl.message(
      '$label',
      name: 'categoriesWidgetDefaultLabel',
      desc: '',
      args: [label],
    );
  }

  /// `Date`
  String get dateAndTimeFormFieldWidgetDateLabel {
    return Intl.message(
      'Date',
      name: 'dateAndTimeFormFieldWidgetDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get dateAndTimeFormFieldWidgetTimeLabel {
    return Intl.message(
      'Time',
      name: 'dateAndTimeFormFieldWidgetTimeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get dateAndTimeFormFieldWidgetSelectDateHint {
    return Intl.message(
      'Select Date',
      name: 'dateAndTimeFormFieldWidgetSelectDateHint',
      desc: '',
      args: [],
    );
  }

  /// `Select Time`
  String get dateAndTimeFormFieldWidgetSelectTimeHint {
    return Intl.message(
      'Select Time',
      name: 'dateAndTimeFormFieldWidgetSelectTimeHint',
      desc: '',
      args: [],
    );
  }

  /// `Hi, {name}`
  String homeAppbarLeadingWidgetGreeting(Object name) {
    return Intl.message(
      'Hi, $name',
      name: 'homeAppbarLeadingWidgetGreeting',
      desc: '',
      args: [name],
    );
  }

  /// `Hello`
  String get homeAppbarLeadingWidgetDefaultGreeting {
    return Intl.message(
      'Hello',
      name: 'homeAppbarLeadingWidgetDefaultGreeting',
      desc: '',
      args: [],
    );
  }

  /// `{location}`
  String homeAppbarLeadingWidgetLocation(Object location) {
    return Intl.message(
      '$location',
      name: 'homeAppbarLeadingWidgetLocation',
      desc: '',
      args: [location],
    );
  }

  /// `Select Location`
  String get homeAppbarLeadingWidgetDefaultLocation {
    return Intl.message(
      'Select Location',
      name: 'homeAppbarLeadingWidgetDefaultLocation',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get labelWithViewAllButtonWidgetViewAll {
    return Intl.message(
      'View All',
      name: 'labelWithViewAllButtonWidgetViewAll',
      desc: '',
      args: [],
    );
  }

  /// `Card Holder Name`
  String get paymentCardDetailsWidgetCardHolderLabel {
    return Intl.message(
      'Card Holder Name',
      name: 'paymentCardDetailsWidgetCardHolderLabel',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date`
  String get paymentCardDetailsWidgetExpiryDateLabel {
    return Intl.message(
      'Expiry Date',
      name: 'paymentCardDetailsWidgetExpiryDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Popular Services`
  String get popularServicesWidgetTitle {
    return Intl.message(
      'Popular Services',
      name: 'popularServicesWidgetTitle',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get popularServicesWidgetViewAll {
    return Intl.message(
      'View All',
      name: 'popularServicesWidgetViewAll',
      desc: '',
      args: [],
    );
  }

  /// `Recommended services for you`
  String get recommendedServicesWidgetTitle {
    return Intl.message(
      'Recommended services for you',
      name: 'recommendedServicesWidgetTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search for services...`
  String get searchBarWidgetHint {
    return Intl.message(
      'Search for services...',
      name: 'searchBarWidgetHint',
      desc: '',
      args: [],
    );
  }

  /// `Min Duration: `
  String get serviceCardMinDurationLabel {
    return Intl.message(
      'Min Duration: ',
      name: 'serviceCardMinDurationLabel',
      desc: '',
      args: [],
    );
  }

  /// `{hours} hours`
  String serviceCardDuration(Object hours) {
    return Intl.message(
      '$hours hours',
      name: 'serviceCardDuration',
      desc: '',
      args: [hours],
    );
  }

  /// `$`
  String get serviceCardCurrencySymbol {
    return Intl.message(
      '\$',
      name: 'serviceCardCurrencySymbol',
      desc: '',
      args: [],
    );
  }

  /// `Deep Clean`
  String get serviceCardDeepCleanName {
    return Intl.message(
      'Deep Clean',
      name: 'serviceCardDeepCleanName',
      desc: '',
      args: [],
    );
  }

  /// `Recurring`
  String get serviceCardRecurringName {
    return Intl.message(
      'Recurring',
      name: 'serviceCardRecurringName',
      desc: '',
      args: [],
    );
  }

  /// `One-Time`
  String get serviceCardOneTimeName {
    return Intl.message(
      'One-Time',
      name: 'serviceCardOneTimeName',
      desc: '',
      args: [],
    );
  }

  /// `{duration} hrs • {price}`
  String serviceListTileDurationAndPrice(Object duration, Object price) {
    return Intl.message(
      '$duration hrs • $price',
      name: 'serviceListTileDurationAndPrice',
      desc: '',
      args: [duration, price],
    );
  }

  /// `$`
  String get serviceListTileCurrencySymbol {
    return Intl.message(
      '\$',
      name: 'serviceListTileCurrencySymbol',
      desc: '',
      args: [],
    );
  }

  /// `Deep Clean`
  String get serviceListTileDeepCleanName {
    return Intl.message(
      'Deep Clean',
      name: 'serviceListTileDeepCleanName',
      desc: '',
      args: [],
    );
  }

  /// `Recurring`
  String get serviceListTileRecurringName {
    return Intl.message(
      'Recurring',
      name: 'serviceListTileRecurringName',
      desc: '',
      args: [],
    );
  }

  /// `One-Time`
  String get serviceListTileOneTimeName {
    return Intl.message(
      'One-Time',
      name: 'serviceListTileOneTimeName',
      desc: '',
      args: [],
    );
  }

  /// `Cleaning`
  String get serviceListTileCleaningCategory {
    return Intl.message(
      'Cleaning',
      name: 'serviceListTileCleaningCategory',
      desc: '',
      args: [],
    );
  }

  /// `Painting`
  String get serviceListTilePaintingCategory {
    return Intl.message(
      'Painting',
      name: 'serviceListTilePaintingCategory',
      desc: '',
      args: [],
    );
  }

  /// `Home Cleaning`
  String get serviceSummaryCardHomeCleaningName {
    return Intl.message(
      'Home Cleaning',
      name: 'serviceSummaryCardHomeCleaningName',
      desc: '',
      args: [],
    );
  }

  /// `/hour`
  String get serviceSummaryCardPerHour {
    return Intl.message(
      '/hour',
      name: 'serviceSummaryCardPerHour',
      desc: '',
      args: [],
    );
  }

  /// `AED`
  String get serviceSummaryCardCurrencySymbol {
    return Intl.message(
      'AED',
      name: 'serviceSummaryCardCurrencySymbol',
      desc: '',
      args: [],
    );
  }

  /// `Professional home cleaning service`
  String get serviceSummaryCardHomeCleaningDescription {
    return Intl.message(
      'Professional home cleaning service',
      name: 'serviceSummaryCardHomeCleaningDescription',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get profileScreenLanguageTitle {
    return Intl.message(
      'Language',
      name: 'profileScreenLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Change app language`
  String get profileScreenLanguageSubtitle {
    return Intl.message(
      'Change app language',
      name: 'profileScreenLanguageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguageTitle {
    return Intl.message(
      'Change Language',
      name: 'changeLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to change the app language?`
  String get changeLanguageConfirmation {
    return Intl.message(
      'Are you sure you want to change the app language?',
      name: 'changeLanguageConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguageButton {
    return Intl.message(
      'Change Language',
      name: 'changeLanguageButton',
      desc: '',
      args: [],
    );
  }

  /// `Language changed to {language}`
  String languageChangedMessage(Object language) {
    return Intl.message(
      'Language changed to $language',
      name: 'languageChangedMessage',
      desc: '',
      args: [language],
    );
  }

  /// `Confirm`
  String get confirmButton {
    return Intl.message(
      'Confirm',
      name: 'confirmButton',
      desc: '',
      args: [],
    );
  }

  /// `Option name`
  String get optionName {
    return Intl.message(
      'Option name',
      name: 'optionName',
      desc: '',
      args: [],
    );
  }

  /// `Extra Price`
  String get extraPrice {
    return Intl.message(
      'Extra Price',
      name: 'extraPrice',
      desc: '',
      args: [],
    );
  }

  /// `Option description (optional)`
  String get optionDescriptionOptional {
    return Intl.message(
      'Option description (optional)',
      name: 'optionDescriptionOptional',
      desc: '',
      args: [],
    );
  }

  /// `Add Option`
  String get addOption {
    return Intl.message(
      'Add Option',
      name: 'addOption',
      desc: '',
      args: [],
    );
  }

  /// `Service Options`
  String get serviceOptions {
    return Intl.message(
      'Service Options',
      name: 'serviceOptions',
      desc: '',
      args: [],
    );
  }

  /// `Extra Fees`
  String get bookingFormScreenExtraFeesLabel {
    return Intl.message(
      'Extra Fees',
      name: 'bookingFormScreenExtraFeesLabel',
      desc: '',
      args: [],
    );
  }

  /// `Total Extra Fees`
  String get bookingFormScreenExtraFeesTotalLabel {
    return Intl.message(
      'Total Extra Fees',
      name: 'bookingFormScreenExtraFeesTotalLabel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
