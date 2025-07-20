import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/models/use_model.dart';
import 'package:mahu_home_services_app/core/network_info.dart';

class AuthServices {
  final NetworkInfo _networkInfo = NetworkInfoImpl();
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: apiBaseURL,
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<Either<Failure, T>> _handleRequest<T>({
    required Future<Response> Function() request,
    required T Function(dynamic data)? onSuccess,
    Map<int, Failure>? knownFailures,
  }) async {
    if (!await _networkInfo.isConnected) return Left(OfflineFailure());

    try {
      final response = await request();
      final data = response.data;
      print(data);

      return Right(onSuccess != null ? onSuccess(data) : unit as T);
    } on DioException catch (e) {
      print(e.toString());
      final code = e.response?.statusCode;
      if (code != null &&
          knownFailures != null &&
          knownFailures.containsKey(code)) {
        return Left(knownFailures[code]!);
      }
      print(e.toString());

      return Left(ServerFailure());
    } catch (_) {
      print(_.toString());

      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, UserModel>> registerAsClient({
    required String email,
    required String phone,
    required String password,
    required String firstName,
    required String lastName,
  }) {
    return _handleRequest<UserModel>(
      request: () => _dio.post('/auth/register', data: {
        "email": email,
        "phone": phone,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "role": "user",
        "verificationType": "email"
      }),
      onSuccess: (data) {
        return UserModel.fromJson(data['user']);
      },
      knownFailures: {
        400: UserAlreadyExistsFailure(),
      },
    );
  }

  Future<Either<Failure, UserModel>> registerAsProvider({
    required String email,
    required String phone,
    required String password,
    required String firstName,
    required String lastName,
    required XFile? avatarPath,
    required String businessName,
  }) {
    return _handleRequest<UserModel>(
      request: () async {
        MultipartFile? avatarFile;
        if (avatarPath != null) {
          avatarFile = await MultipartFile.fromFile(
            avatarPath.path,
            filename: '${firstName + phone}_avatar.jpg',
          );
        }

        return _dio.post(
          '/auth/register',
          // options: Options(
          //   contentType: 'multipart/form-data',
          // ),
          data: {
            "email": email,
            "phone": phone,
            "password": password,
            "firstName": firstName,
            "lastName": lastName,
            "avatar":
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTU3HFVnkYFJ_OIogo__Qv58bmhwRqZJcQhOA&s',
            "role": "provider",
            "businessName": businessName,
            "businessRegistration": "REG123456",
            "verificationType": "email",
          },
        );
      },
      onSuccess: (data) {
        return UserModel.fromJson(data['user']);
      },
      knownFailures: {
        400: UserAlreadyExistsFailure(),
      },
    );
  }

  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  }) {
    return _handleRequest<String>(
      request: () => _dio.post('/auth/login', data: {
        "email": email,
        "password": password,
      }),
      onSuccess: (data) => data['token'],
      knownFailures: {
        401: LoginInvalidCredentialsFailure(),
      },
    );
  }

  Future<Either<Failure, Unit>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) {
    return _handleRequest<Unit>(
      request: () => _dio.put('/auth/reset-password', data: {
        "email": email,
        "otp": otp,
        "newPassword": newPassword,
      }),
      onSuccess: (_) => unit,
      knownFailures: {
        400: InvalidOTPFailure(),
      },
    );
  }

  Future<Either<Failure, Unit>> forgotPassword({required String email}) {
    return _handleRequest<Unit>(
      request: () => _dio.post('/auth/forgot-password', data: {
        "email": email,
      }),
      onSuccess: (_) => unit,
      knownFailures: {
        404: UserNotFoundFailure(),
      },
    );
  }

  Future<Either<Failure, Unit>> resendOTP({required String email}) {
    return _handleRequest<Unit>(
      request: () => _dio.post('/auth/resend-otp', data: {
        "email": email,
        "type": "email",
      }),
      onSuccess: (_) => unit,
      knownFailures: {
        404: UserNotFoundFailure(),
      },
    );
  }

  Future<Either<Failure, Unit>> verifyEmail({
    required String email,
    required String otp,
  }) {
    return _handleRequest<Unit>(
      request: () => _dio.post('/auth/verify-email', data: {
        "email": email,
        "otp": otp,
      }),
      onSuccess: (_) => unit,
      knownFailures: {
        400: InvalidOTPFailure(),
        404: UserNotFoundFailure(),
      },
    );
  }
}
