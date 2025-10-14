import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/utils/helpers/request_hundler.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/core/utils/helpers/upload_media_helper.dart';
import 'package:mahu_home_services_app/features/services/models/provider_performance.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';

class ManageProviderServices {
  Future<Either<Failure, Unit>> addService(ServiceModel service) async {
    String token = CacheHelper.getString('token') ?? '';

    print('Token: $token');

    // Handle image upload
    String imageUrl = service.image;

    if (service.image.startsWith('file://') ||
        (service.image.isNotEmpty && !service.image.startsWith('http'))) {
      try {
        final file = File(service.image);
        if (await file.exists()) {
          imageUrl = await UploadMediaHelper.uploadImage(file) ?? service.image;
        } else {
          print('Image file does not exist: ${service.image}');
          imageUrl = '';
        }
      } catch (e) {
        print('Error uploading image: $e');
        imageUrl = service.image;
      }
    }

    return RequestHundler.handleRequest<Unit>(
      request: (options) => RequestHundler.dio.post(
        '/services',
        data: {
          "name": service.name,
          "description": service.description,
          "category": service.category,
          "serviceType": service.serviceType,
          "subType": service.subType,
          "basePrice": service.basePrice,
          "pricingModel": service.pricingModel,
          "duration": service.duration,
          "image": imageUrl, // Use the processed image URL
          "active": service.active, // Use the service's active value
          "isApproved":
              service.isApproved, // Use the service's isApproved value
          "availableDays": service.availableDays,
          "availableSlots": service.availableSlots
              .map((slot) => {
                    "startTime": slot.startTime,
                    "endTime": slot.endTime,
                  })
              .toList(),
          'options': service.options
              .map((option) => {
                    "name": option.name,
                    "price": option.price,
                    'description': option.description,
                    'pricingModel': service.pricingModel,
                    'appliesTo': service.serviceType,
                    'active': true,
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
      headers: {"Accept-Language": CacheHelper.getString(appLang) ?? 'en'},
    );
  }

  // Example method to change active servicevice
  Future<Either<Failure, Unit>> toggleServiceStatus(
      String serviceId, bool isActive) async {
    final token = CacheHelper.getString('token') ?? '';

    final String endpoint = isActive
        ? '/services/unactive/$serviceId'
        : '/services/active/$serviceId';

    try {
      return RequestHundler.handleRequest<Unit>(
        request: (options) => RequestHundler.dio.put(
          endpoint,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
        ),
        onSuccess: (data) {
          debugPrint(
            'Service ${isActive ? "deactivated" : "activated"} successfully → $serviceId',
          );
          return unit; // No payload expected, just success
        },
        headers: {"Accept-Language": CacheHelper.getString(appLang) ?? 'en'},
      );
    } catch (e, stack) {
      debugPrint(
          'Unexpected error while toggling service $serviceId: $e\n$stack');
      return left(Failure('Unexpected error occurred'));
    }
  }

  Future<Either<Failure, Unit>> updateService(ServiceModel service) async {
    String token = CacheHelper.getString('token') ?? '';
    String imageUrl = '';
    if (service.image.isNotEmpty &&
        (service.image.startsWith('file://') ||
            !service.image.startsWith('http'))) {
      imageUrl = await UploadMediaHelper.uploadImage(File(service.image)) ?? '';
    }

    return RequestHundler.handleRequest<Unit>(
      request: (options) {
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
          'options': service.options
              .map((option) => {
                    "name": option.name,
                    "price": option.price,
                    'description': option.description,
                    'pricingModel': service.pricingModel,
                    'appliesTo': service.serviceType,
                    'active': true,
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
      headers: {"Accept-Language": CacheHelper.getString(appLang) ?? 'en'},
    );
  }

  // Example method to retrieve all services
  Future<Either<Failure, List<ServiceModel>>> getAllServices() {
    String token = CacheHelper.getString('token') ?? '';
    print('--------------------');
    print(token);
    print('--------------------');
    return RequestHundler.handleRequest<List<ServiceModel>>(
      request: (options) => RequestHundler.dio.get(
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
      headers: {"Accept-Language": CacheHelper.getString(appLang) ?? 'en'},
    );
  }

  Future<Either<Failure, ProviderPerformanceModel>> getProviderPerformance() {
    String token = CacheHelper.getString('token') ?? '';
    return RequestHundler.handleRequest<ProviderPerformanceModel>(
      request: (options) => RequestHundler.dio.get('/providers/me/performance',
          data: {},
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          })),
      onSuccess: (data) {
        return ProviderPerformanceModel.fromJson(data['data']);
      },
      headers: {"Accept-Language": CacheHelper.getString(appLang) ?? 'en'},
    );
  }
}
