import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/models/use_model.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/core/utils/helpers/request_hundler.dart';
import 'package:mahu_home_services_app/core/utils/helpers/upload_media_helper.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/client_register_screen.dart';

class AuthServices {
  Future<Either<Failure, UserModel>> registerAsClient({
    required String email,
    required String phone,
    required String password,
    required String firstName,
    required String lastName,
    required String otpMethod,
    required String refrenceId,
  }) {
    return RequestHundler.handleRequest<UserModel>(
      request: (options) => RequestHundler.dio.post(
        '/auth/register',
        data: {
          "email": email,
          "phone": phone,
          "password": password,
          "firstName": firstName,
          "lastName": lastName,
          "role": "user",
          "verificationType": otpMethod,
          "businessRegistration": refrenceId,
        },
        options: options,
      ),
      onSuccess: (data) {
        return UserModel.fromJson(data['user']);
      },
      headers: {"Accept-Language": CacheHelper.getString(appLang) ?? 'en'},
    );
  }

  Future<Either<Failure, UserModel>> registerAsProvider({
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
    String imageUrl =
        await UploadMediaHelper.uploadImage(File(avatarPath)) ?? '';

    return RequestHundler.handleRequest<UserModel>(
      request: (options) async {
        var data = {
          "email": email,
          "phone": phone,
          "password": password,
          "firstName": firstName,
          "lastName": lastName,
          "avatar": imageUrl,
          "role": "provider",
          "businessName": businessName,
          "serviceProviderCategory": businessCategory,
          "verificationType": otpMethod,
        };
        print(data);
        return RequestHundler.dio.post(
          '/auth/register',
          data: data,
        );
      },
      onSuccess: (data) {
        return UserModel.fromJson(data['user']);
      },
      headers: {"Accept-Language": CacheHelper.getString(appLang) ?? 'en'},
    );
  }

  Future<Either<Failure, LoginResponse>> login({
    required String emailOrPhone,
    required String password,
    required String fcmToken,
  }) {
    return RequestHundler.handleRequest<LoginResponse>(
      request: (options) {
        var authCredentials = {
          'emailOrPhone': emailOrPhone,
          "password": password,
          "fcmToken": fcmToken,
        };
        print(authCredentials);
        return RequestHundler.dio.post(
          '/auth/login',
          data: authCredentials,
        );
      },
      onSuccess: (data) {
        return LoginResponse.fromJson(data);
      },
      headers: {"Accept-Language": CacheHelper.getString(appLang) ?? 'en'},
    );
  }

  Future<Either<Failure, Unit>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) {
    return RequestHundler.handleRequest<Unit>(
      request: (options) =>
          RequestHundler.dio.put('/auth/reset-password', data: {
        "email": email,
        "otp": otp,
        "newPassword": newPassword,
      }),
      onSuccess: (_) => unit,
      headers: {"Accept-Language": CacheHelper.getString(appLang) ?? 'en'},
    );
  }

  Future<Either<Failure, Unit>> forgotPassword({required String email}) {
    return RequestHundler.handleRequest<Unit>(
      request: (options) =>
          RequestHundler.dio.post('/auth/forgot-password', data: {
        "email": email,
      }),
      onSuccess: (_) => unit,
      headers: {"Accept-Language": CacheHelper.getString(appLang) ?? 'en'},
    );
  }

  Future<Either<Failure, Unit>> resendOTP({required String email}) {
    return RequestHundler.handleRequest<Unit>(
      request: (options) => RequestHundler.dio.post('/auth/resend-otp', data: {
        'emailOrPhone': email,
        "type": "email",
      }),
      onSuccess: (_) => unit,
      headers: {"Accept-Language": CacheHelper.getString(appLang) ?? 'en'},
    );
  }

  Future<Either<Failure, Unit>> verify({
    required OtpChannel channal,
    required String value,
    required String otp,
  }) {
    return RequestHundler.handleRequest<Unit>(
      request: (options) => RequestHundler.dio.post(
        
        '/auth/verify-${channal.name}',
        data: {
          channal.name: value,
          "otp": otp,
        },
        options: options,
      ),
      onSuccess: (_) => unit,
      headers: {"Accept-Language": CacheHelper.getString(appLang) ?? 'en'},
    );
  }
}

class LoginResponse {
  final String token;
  final String serviceProviderCategory;
  final String? businessRegistration; // nullable
  final UserModel user;

  LoginResponse({
    required this.token,
    required this.serviceProviderCategory,
    this.businessRegistration,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] ?? '',
      serviceProviderCategory: json['serviceProviderCategory'] ?? '',
      businessRegistration: json['businessRegistration'], // nullable
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'serviceProviderCategory': serviceProviderCategory,
        'businessRegistration': businessRegistration,
        'user': user.toJson(),
      };
}
