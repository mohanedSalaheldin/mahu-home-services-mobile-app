import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/models/use_model.dart';
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
      request: () => RequestHundler.dio.post('/auth/register', data: {
        "email": email,
        "phone": phone,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "role": "user",
        "verificationType": otpMethod,
        "businessRegistration": refrenceId,
      }),
      onSuccess: (data) {
        return UserModel.fromJson(data['user']);
      },
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
      request: () async {
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
    );
  }

  Future<Either<Failure, LoginResponse>> login({
    required String emailOrPhone,
    required String password,
  }) {
    return RequestHundler.handleRequest<LoginResponse>(
      request: () {
        var data2 = {
          'emailOrPhone': emailOrPhone,
          "password": password,
        };
        print(data2);
        return RequestHundler.dio.post(
          '/auth/login',
          data: data2,
        );
      },
      onSuccess: (data) {
        return LoginResponse.fromJson(data);
      },
    );
  }

  Future<Either<Failure, Unit>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) {
    return RequestHundler.handleRequest<Unit>(
      request: () => RequestHundler.dio.put('/auth/reset-password', data: {
        "email": email,
        "otp": otp,
        "newPassword": newPassword,
      }),
      onSuccess: (_) => unit,
    );
  }

  Future<Either<Failure, Unit>> forgotPassword({required String email}) {
    return RequestHundler.handleRequest<Unit>(
      request: () => RequestHundler.dio.post('/auth/forgot-password', data: {
        "email": email,
      }),
      onSuccess: (_) => unit,
    );
  }

  Future<Either<Failure, Unit>> resendOTP({required String email}) {
    return RequestHundler.handleRequest<Unit>(
      request: () => RequestHundler.dio.post('/auth/resend-otp', data: {
        'emailOrPhone': email,
        "type": "email",
      }),
      onSuccess: (_) => unit,
    );
  }

  Future<Either<Failure, Unit>> verify({
    required OtpChannel channal,
    required String value,
    required String otp,
  }) {
    return RequestHundler.handleRequest<Unit>(
      request: () =>
          RequestHundler.dio.post('/auth/verify-${channal.name}', data: {
        channal.name: value,
        "otp": otp,
      }),
      onSuccess: (_) => unit,
    );
  }
}

class LoginResponse {
  final String token;
  final String? businessRegistration; // nullable الآن
  final UserModel user;

  LoginResponse({
    required this.token,
    this.businessRegistration,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] ?? '',
      businessRegistration: json['businessRegistration'], // nullable
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'businessRegistration': businessRegistration,
        'user': user.toJson(),
      };
}
