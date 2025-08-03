import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/network_info.dart';
import 'package:mahu_home_services_app/core/utils/app_users_configs.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/features/services/models/booking_model.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/user_booking/models/booking_model.dart';

class UserBookingServices {
  // This class is responsible for managing provider services.
  // It can include methods to add, update, delete, or retrieve services.

  final NetworkInfo _networkInfo = NetworkInfoImpl();
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: apiBaseURL,
      headers: {
        'Content-Type': 'application/json',
      },
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
      print('⚠️ DioException Caught');
      print('Status code: ${e.response?.statusCode}');
      print('Response body: ${e.response?.data}');
      print('Headers: ${e.response?.headers}');
      print('Request data: ${e.requestOptions.data}');
      print('Full error: $e');

      final code = e.response?.statusCode;
      if (code != null &&
          knownFailures != null &&
          knownFailures.containsKey(code)) {
        return Left(knownFailures[code]!);
      }

      return Left(ServerFailure());
    }
  }

  // Example method to retrieve all services
  Future<Either<Failure, List<ServiceModel>>> getAllServices() {
    return _handleRequest<List<ServiceModel>>(
      request: () => _dio.get(
        '/services/list/${AppUsersConfigs.appProvider}',
        data: {},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      ),
      onSuccess: (data) {
        return (data['data'] as List)
            .map((service) => ServiceModel.fromJson(service))
            .toList();
      },
      knownFailures: {},
    );
  }

  Future<Either<Failure, Unit>> createBBooking(UserBookingModel model) {
    String token = CacheHelper.getString('token') ?? '';

    return _handleRequest<Unit>(
      request: () => _dio.post(
        '/bookings',
        data: {
          "service": model.service,
          "schedule": {
            "startDate": model.schedule.startDate,
            "recurrence": model.schedule.recurrence
          },
          "address": model.address,
          "details": model.details
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      ),
      onSuccess: (data) {
        print(data);
        return unit;
      },
      knownFailures: {},
    );
  }
}
