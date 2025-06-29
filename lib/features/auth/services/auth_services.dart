import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/models/use_model.dart';
import 'package:mahu_home_services_app/core/network_info.dart';

class AuthServices {
  final NetworkInfo _networkInfo = NetworkInfoImpl();
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://mahu-home-services-server.vercel.app/api/v1',
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

      return Right(onSuccess != null ? onSuccess(data) : unit as T);
    } on DioException catch (e) {
      final code = e.response?.statusCode;
      if (code != null &&
          knownFailures != null &&
          knownFailures.containsKey(code)) {
        return Left(knownFailures[code]!);
      }
      return Left(ServerFailure());
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, UserModel>> register({
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
      }),
      onSuccess: (data) => UserModel.fromJson(data['user']),
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
