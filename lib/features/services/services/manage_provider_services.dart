import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/network_info.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/core/utils/helpers/upload_media_helper.dart';
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

  // Example method to add a service
  Future<Either<Failure, Unit>> addService(ServiceModel service) async {
    String token = CacheHelper.getString('token') ?? '';
    print('--------------------');
    print(
        'Adding service with token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4ODIzOTkzOWVkMWEyNzZjNzRjMjM4MiIsImlhdCI6MTc1MzM2NjYwMCwiZXhwIjoxNzU1OTU4NjAwfQ.BdYJYVs2p7qeMywo7EZCdvPCOeqmIiPDG-QIm1XTreE');
    print('--------------------');
    String imageUrl =
        await UploadMediaHelper.uploadImage(File(service.image)) ?? '';
    return _handleRequest<Unit>(
      request: () => _dio.post(
        '/services',
        data: {
          "name": service.name,
          "description": service.description,
          "category": service.category,
          "serviceType": service.serviceType,
          "subType": service.subType,
          "basePrice": service.basePrice, // per hour
          "pricingModel": service.pricingModel, // hourly or fixed
          "duration": service.duration, // minimum 1 hour
          "image": imageUrl,
          "active": true,
          "isApproved": true
        },
        // data: {
        //   "name": "Air Conditioner Installation",
        //   "description":
        //       "Professional air conditioner installation with warranty and expert technicians.",
        //   "category": "electrical",
        //   "serviceType": "one-time",
        //   "subType": "normal",
        //   "basePrice": 250,
        //   "pricingModel": "fixed",
        //   "duration": 120,
        //   "image":
        //       "https://images.unsplash.com/photo-1615873968403-89d77c6b0a35?auto=format&fit=crop&w=800&q=80",
        //   "active": true,
        //   "isApproved": true
        // },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      ),
      onSuccess: (data) {
        print('Service added successfully: $data');
        return unit; // Return unit if no specific data is expected
      },
      knownFailures: {
        500: ServerFailure(),
      },
    );
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
        return (data['data'] as List)
            .map((service) => ServiceModel.fromJson(service))
            .toList();
      },
      knownFailures: {},
    );
  }
  
}
