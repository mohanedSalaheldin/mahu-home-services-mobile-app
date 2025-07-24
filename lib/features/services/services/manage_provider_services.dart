import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/network_info.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';

class ManageProviderServices {
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

  // Example method to add a service
  void addService(String serviceName) {
    // Logic to add a service
    print('Service $serviceName added.');
  }

  // Example method to update a service
  void updateService(String serviceId, String newServiceName) {
    // Logic to update a service
    print('Service $serviceId updated to $newServiceName.');
  }

  // Example method to delete a service
  void deleteService(String serviceId) {
    // Logic to delete a service
    print('Service $serviceId deleted.');
  }

  // Example method to retrieve all services
  Future<Either<Failure, List<ServiceModel>>> getAllServices() {
    String token = CacheHelper.getString('token') ?? '';
    return _handleRequest<List<ServiceModel>>(
      request: () => _dio.get('/services',
          data: {},
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          })),
      onSuccess: (data) {
        return (data as List)
            .map((service) => ServiceModel.fromJson(service))
            .toList();
      },
      knownFailures: {},
    );
  }
}
