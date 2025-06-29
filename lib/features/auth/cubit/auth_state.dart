import 'package:mahu_home_services_app/core/errors/failures.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class RegisterLoadingState extends AuthState {}

final class RegisterSucessededState extends AuthState {}

final class RegisterFailedState extends AuthState {
  final Failure failure;

  RegisterFailedState({required this.failure});
}

final class LoginLoadingState extends AuthState {}

final class LoginSucessededState extends AuthState {}

final class LoginFailedState extends AuthState {
  final Failure failure;

  LoginFailedState({required this.failure});
}

final class VerifyEmailLoadingState extends AuthState {}

final class VerifyEmailSucessededState extends AuthState {}

final class VerifyEmailFailedState extends AuthState {
  final Failure failure;

  VerifyEmailFailedState({required this.failure});
}

final class ForgotPasswordLoadingState extends AuthState {}

final class ForgotPasswordSucessededState extends AuthState {}

final class ForgotPasswordFailedState extends AuthState {
  final Failure failure;

  ForgotPasswordFailedState({required this.failure});
}

final class ResetPasswordLoadingState extends AuthState {}

final class ResetPasswordSucessededState extends AuthState {}

final class ResetPasswordFailedState extends AuthState {
  final Failure failure;

  ResetPasswordFailedState({required this.failure});
}
final class OTPResendLoadingState extends AuthState {}

final class OTPResendSucessededState extends AuthState {}

final class OTPResendFailedState extends AuthState {
  final Failure failure;

  OTPResendFailedState({required this.failure});
}
