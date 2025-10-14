import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/models/use_model.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/services/auth_services.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_state.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/client_register_screen.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthServices _authServices = AuthServices();

  static AuthCubit get(context) => BlocProvider.of(context);

  UserModel _registerResponceUser = UserModel(
      id: 'id',
      email: 'email',
      phone: 'phone',
      role: 'role',
      // token: 'token',
      isVerified: false,
      profile: UserProfile(firstName: 'firstName', lastName: 'lastName'));

  UserModel get registerResponceUser => _registerResponceUser;

  void registerAsClient({
    required String email,
    required String phone,
    required String password,
    required String firstName,
    required String lastName,
    required String otpMethod,
    required String refrenceId,
  }) async {
    emit(RegisterLoadingState());
    Either<Failure, UserModel> res = await _authServices.registerAsClient(
      email: email,
      phone: phone,
      password: password,
      firstName: firstName,
      lastName: lastName,
      otpMethod: otpMethod,
      refrenceId: refrenceId,
    );
    res.fold(
      (failure) {
        emit(RegisterFailedState(failure: failure));
      },
      (user) async {
        _registerResponceUser = user;
        emit(RegisterSucessededState());
      },
    );
  }

  void registerAsProvider({
    required String email,
    required String phone,
    required String password,
    required String firstName,
    required String lastName,
    required String avatarPath,
    required String businessName,
    required String otpMethod,
    required String businessCategory,
  }) async {
    emit(RegisterLoadingState());
    Either<Failure, UserModel> res = await _authServices.registerAsProvider(
      email: email,
      phone: phone,
      password: password,
      firstName: firstName,
      lastName: lastName,
      avatarPath: avatarPath,
      businessName: businessName,
      otpMethod: otpMethod,
      businessCategory: businessCategory,
    );
    res.fold(
      (failure) {
        emit(RegisterFailedState(failure: failure));
      },
      (user) async {
        _registerResponceUser = user;
        emit(RegisterSucessededState());
      },
    );
  }

  void login({
    required String emailOrPhone,
    required String password,
  }) async {
    emit(LoginLoadingState());

    String fcmToken = await FirebaseMessaging.instance.getToken() ?? '';

    final res = await _authServices.login(
      emailOrPhone: emailOrPhone,
      password: password,
      fcmToken: fcmToken,
    );

    res.fold(
      (failure) {
        emit(LoginFailedState(failure: failure));
      },
      (loginResponse) async {
        await CacheHelper.saveString('token', loginResponse.token);
        await CacheHelper.saveString(
            'serviceProviderCategory', loginResponse.serviceProviderCategory);
        await CacheHelper.saveString(
            'referenceId', loginResponse.businessRegistration.toString());
        await CacheHelper.saveString('userId', loginResponse.user.id);
        emit(LoginSucessededState(userModel: loginResponse.user));
      },
    );
  }

  void forgotPassword({required String email}) async {
    emit(ForgotPasswordLoadingState());
    Either<Failure, Unit> res =
        await _authServices.forgotPassword(email: email);
    res.fold(
      (failure) {
        emit(ForgotPasswordFailedState(failure: failure));
      },
      (_) async {
        emit(ForgotPasswordSucessededState());
      },
    );
  }

  void resendOTP({required String email}) async {
    emit(OTPResendLoadingState());
    Either<Failure, Unit> res = await _authServices.resendOTP(email: email);
    res.fold(
      (failure) {
        emit(OTPResendFailedState(failure: failure));
      },
      (_) async {
        emit(OTPResendSucessededState());
      },
    );
  }

  void resetPassword({
    required String email,
    required String newPassword,
    required String otp,
  }) async {
    emit(ResetPasswordLoadingState());
    Either<Failure, Unit> res = await _authServices.resetPassword(
      email: email,
      newPassword: newPassword,
      otp: otp,
    );
    res.fold(
      (failure) {
        emit(ResetPasswordFailedState(failure: failure));
      },
      (_) async {
        emit(ResetPasswordSucessededState());
      },
    );
  }

  void verify({
    required String otp,
    required OtpChannel channal,
  }) async {
    emit(VerifyEmailLoadingState());
    Either<Failure, Unit> res = await _authServices.verify(
      channal: channal,
      value: channal == OtpChannel.email
          ? registerResponceUser.email
          : registerResponceUser.phone,
      otp: otp,
    );
    res.fold(
      (failure) {
        emit(VerifyEmailFailedState(failure: failure));
      },
      (_) async {
        emit(VerifyEmailSucessededState());
      },
    );
  }
}
