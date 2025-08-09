import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/utils/helpers/request_hundler.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/core/utils/helpers/upload_media_helper.dart';
import 'package:mahu_home_services_app/features/services/models/provider_performance.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';

class ManageProviderServices {
  Future<Either<Failure, Unit>> addService(ServiceModel service) async {
    String token = CacheHelper.getString('token') ?? '';

    print('--------------------');
    print(token);
    print('--------------------');
    String imageUrl =
        await UploadMediaHelper.uploadImage(File(service.image)) ?? '';
    return RequestHundler.handleRequest<Unit>(
      request: () => RequestHundler.dio.post(
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
          "isApproved": true,
          "availableDays": service.availableDays,
          "availableSlots": service.availableSlots
              .map((slot) => {
                    "startTime": slot.startTime,
                    "endTime": slot.endTime,
                  })
              .toList(),
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      ),
      onSuccess: (data) {
        print('Service added successfully: $data');
        return unit;
      },
    );
  }

  // Example method to delete a service
  Future<Either<Failure, Unit>> deleteService(String serviceId) async {
    String token = CacheHelper.getString('token') ?? '';
    return RequestHundler.handleRequest<Unit>(
      request: () => RequestHundler.dio.delete(
        '/services/service/$serviceId',
        // data: {},
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
    );
  }

  Future<Either<Failure, Unit>> updateService(ServiceModel service) async {
    String token = CacheHelper.getString('token') ?? '';
    String imageUrl = '';
    if (service.image.isNotEmpty) {
      imageUrl = await UploadMediaHelper.uploadImage(File(service.image)) ?? '';
    }

    return RequestHundler.handleRequest<Unit>(
      request: () {
        var data2 = {
          "name": service.name,
          "description": service.description,
          "basePrice": service.basePrice, // per hour
          "duration": service.duration, // minimum 1 hour
          "availableDays": service.availableDays,
          "availableSlots": service.availableSlots
              .map((slot) => {
                    "startTime": slot.startTime,
                    "endTime": slot.endTime,
                  })
              .toList(),
        };
        if (imageUrl.isNotEmpty) {
          data2['image'] = imageUrl;
        }
        return RequestHundler.dio.put(
          '/services/${service.id}',
          data: data2,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
        );
      },
      onSuccess: (data) {
        print('Service added successfully: $data');
        return unit;
      },
    );
  }

  // Example method to retrieve all services
  Future<Either<Failure, List<ServiceModel>>> getAllServices() {
    String token = CacheHelper.getString('token') ?? '';
    print('--------------------');
    print(token);
    print('--------------------');
    return RequestHundler.handleRequest<List<ServiceModel>>(
      request: () => RequestHundler.dio.get(
        '/services/mine',
        data: {},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      ),
      onSuccess: (data) {
        return (data['data'] as List)
            .map((service) => ServiceModel.fromJson(service))
            .toList();
      },
    );
  }

  Future<Either<Failure, ProviderPerformanceModel>> getProviderPerformance() {
    String token = CacheHelper.getString('token') ?? '';
    return RequestHundler.handleRequest<ProviderPerformanceModel>(
      request: () => RequestHundler.dio.get('/providers/me/performance',
          data: {},
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          })),
      onSuccess: (data) {
        return ProviderPerformanceModel.fromJson(data['data']);
      },
    );
  }
}
