import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/utils/app_users_configs.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/core/utils/helpers/request_hundler.dart';
import 'package:mahu_home_services_app/features/services/models/booking_model.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/user_booking/models/booking_model.dart';

class UserBookingServices {
  Future<Either<Failure, List<ServiceModel>>> getAllServices() {
    // Get all services for all providers
    return RequestHundler.handleRequest<List<ServiceModel>>(
      request: () => RequestHundler.dio.get(
        '/services/list',
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
    );
  }

  Future<Either<Failure, List<ServiceModel>>> getServicesByProvider(
      String referenceId) {
    // Get services for a specific provider
    return RequestHundler.handleRequest<List<ServiceModel>>(
      request: () => RequestHundler.dio.get(
        '/services/list/$referenceId',
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
    );
  }

  Future<Either<Failure, Unit>> createBooking(UserBookingModel model) {
    String token = CacheHelper.getString('token') ?? '';

    return RequestHundler.handleRequest<Unit>(
      request: () => RequestHundler.dio.post(
        '/bookings',
        data: {
          "service": model.service,
          "price": model.price, // Include price
          "schedule": model.schedule.toJson(),
          "address": model.address.toJson(),
          if (model.details != null) "details": model.details,
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
    );
  }

  Future<Either<Failure, List<BookingModel>>> getUserPreviousBookings() {
    String token = CacheHelper.getString('token') ?? '';

    return RequestHundler.handleRequest<List<BookingModel>>(
      request: () => RequestHundler.dio.get(
        '/users/me/bookings',
        queryParameters: {
          'previous': 'true', // مهم عشان يجيب البوكينجات السابقة فقط
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      ),
      onSuccess: (data) {
        // { success: true, count: x, pagination: {...}, data: [ bookings ] }
        final bookingsJson = data['data'] as List;
        return bookingsJson.map((book) => BookingModel.fromJson(book)).toList();
      },
    );
  }

  // FAVORITES ENDPOINTS

  // Add service to favorites
  Future<Either<Failure, Unit>> addToFavorites(String serviceId) {
    String token = CacheHelper.getString('token') ?? '';

    return RequestHundler.handleRequest<Unit>(
      request: () => RequestHundler.dio.post(
        '/favorites',
        data: {
          "serviceId": serviceId,
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      ),
      onSuccess: (data) {
        print('Service added to favorites: $data');
        return unit;
      },
    );
  }

  // Remove service from favorites
  Future<Either<Failure, Unit>> removeFromFavorites(String serviceId) {
    String token = CacheHelper.getString('token') ?? '';

    return RequestHundler.handleRequest<Unit>(
      request: () => RequestHundler.dio.delete(
        '/favorites/$serviceId',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      ),
      onSuccess: (data) {
        print('Service removed from favorites: $data');
        return unit;
      },
    );
  }

  // Get user's favorite services
  Future<Either<Failure, List<ServiceModel>>> getUserFavorites() {
    String token = CacheHelper.getString('token') ?? '';

    return RequestHundler.handleRequest<List<ServiceModel>>(
      request: () => RequestHundler.dio.get(
        '/favorites',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      ),
      onSuccess: (data) {
        // { success: true, count: x, data: [ services ] }
        final servicesJson = data['data'] as List;
        return servicesJson
            .map((service) => ServiceModel.fromJson(service))
            .toList();
      },
    );
  }

  // Check if service is favorited by user
  Future<Either<Failure, bool>> checkIsFavorited(String serviceId) {
    String token = CacheHelper.getString('token') ?? '';

    return RequestHundler.handleRequest<bool>(
      request: () => RequestHundler.dio.get(
        '/favorites/check/$serviceId',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      ),
      onSuccess: (data) {
        // { success: true, data: { isFavorited: true/false } }
        final isFavorited = data['data']['isFavorited'] as bool;
        return isFavorited;
      },
    );
  }

  // Get user's favorite services with pagination
  Future<Either<Failure, Map<String, dynamic>>> getUserFavoritesPaginated({
    int page = 1,
    int limit = 10,
  }) {
    String token = CacheHelper.getString('token') ?? '';

    return RequestHundler.handleRequest<Map<String, dynamic>>(
      request: () => RequestHundler.dio.get(
        '/favorites',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      ),
      onSuccess: (data) {
        // { success: true, count: x, pagination: {...}, data: [ services ] }
        final servicesJson = data['data'] as List;
        final services = servicesJson
            .map((service) => ServiceModel.fromJson(service))
            .toList();

        return {
          'services': services,
          'count': data['count'],
          'pagination': data['pagination'],
        };
      },
    );
  }
}
