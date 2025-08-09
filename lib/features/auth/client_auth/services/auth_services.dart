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
  }) {
    return RequestHundler.handleRequest<UserModel>(
      request: () => RequestHundler.dio.post('/auth/register', data: {
        "email": email,
        "phone": phone,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "role": "user",
        "verificationType": otpMethod
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
          "businessRegistration": "REG123456",
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

  Future<Either<Failure, String>> login({
    required String emailOrPhone,
    required String password,
  }) {
    return RequestHundler.handleRequest<String>(
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
      onSuccess: (data) => data['token'],
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
      request: () => RequestHundler.dio.post('/auth/verify-email', data: {
        channal.name: value,
        "otp": otp,
      }),
      onSuccess: (_) => unit,
    );
  }
}
