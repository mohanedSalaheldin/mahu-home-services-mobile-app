import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/utils/helpers/network_info.dart';

class RequestHundler {
  static final NetworkInfo _networkInfo = NetworkInfoImpl();

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: apiBaseURL,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  static Future<Either<Failure, T>> handleRequest<T>({
    required Future<Response> Function() request,
    required T Function(dynamic data)? onSuccess,
  }) async {
    if (!await _networkInfo.isConnected) {
      return Left(Failure('No Internet Connection'));
    }

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

      if (e.response?.data is Map<String, dynamic>) {
        final errorData = e.response!.data as Map<String, dynamic>;
        final message =
            errorData['error'] ?? errorData['message'] ?? 'Server Error';
        return Left(Failure(message));
      }

      return Left(Failure('Server Error'));
    }
  }
}
