import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/network_info.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/features/services/models/booking_model.dart';
import 'package:mahu_home_services_app/features/services/views/screens/booking_details_screen.dart';

class BookingServices {
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

  Future<Either<Failure, List<BookingModel>>> getAllServices() {
    String token = CacheHelper.getString('token') ?? '';
    return _handleRequest<List<BookingModel>>(
      request: () => _dio.get('/providers/me/bookings',
          data: {},
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          })),
      onSuccess: (data) {
        return (data['data'] as List)
            .map((book) => BookingModel.fromJson(book))
            .toList();
      },
      knownFailures: {},
    );
  }
}
