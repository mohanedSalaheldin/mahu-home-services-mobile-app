import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/utils/app_users_configs.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/core/utils/helpers/request_hundler.dart';
import 'package:mahu_home_services_app/features/services/models/booking_model.dart';
import 'package:mahu_home_services_app/features/services/models/new_booking_model.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/user_booking/models/booking_model.dart';

class UserBookingServices {
  Future<Either<Failure, List<ServiceModel>>> getAllServices() {
    // Get all services for all providers
    return RequestHundler.handleRequest<List<ServiceModel>>(
      request: (options) => RequestHundler.dio.get(
        '/services/list',
        data: {},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-vercel-protection-bypass': 'zfUQ9ZLDwFJu2T4hgp4j9KI9Q1DxesP0',
          },
        ),
      ),
      onSuccess: (data) {
        return (data['data'] as List)
            .map((service) => ServiceModel.fromJson(service))
            .toList();
      },
      headers: {
        'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
      },
    );
  }

  Future<Either<Failure, List<ServiceModel>>> getServicesByProvider(
      String referenceId) {
    // Get services for a specific provider
    return RequestHundler.handleRequest<List<ServiceModel>>(
      request: (options) => RequestHundler.dio.get(
        '/services/list/$referenceId',
        data: {},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-vercel-protection-bypass': 'zfUQ9ZLDwFJu2T4hgp4j9KI9Q1DxesP0',
          },
        ),
      ),
      onSuccess: (data) {
        return (data['data'] as List)
            .map((service) => ServiceModel.fromJson(service))
            .toList();
      },
      headers: {
        'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
      },
    );
  }

  Future<Either<Failure, bool>> cancelBooking(String bookingId, String token) {
    print('Cancelling booking: $bookingId');
    return RequestHundler.handleRequest<bool>(
      request: (options) => RequestHundler.dio.delete(
        '/bookings/$bookingId/cancel',
        data: {},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
            'x-vercel-protection-bypass': 'zfUQ9ZLDwFJu2T4hgp4j9KI9Q1DxesP0',
          },
        ),
      ),
      onSuccess: (data) {
        print('API Response: $data'); // Debug print

        // Handle different response formats
        if (data is Map<String, dynamic>) {
          // Check if response has 'success' field
          if (data.containsKey('success')) {
            final success = data['success'] as bool?;
            return success ?? false;
          }
          // If no 'success' field but response exists, assume success
          return true;
        }

        // If response is not a map but exists, assume success
        return true;
      },
      headers: {
        'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
      },
    );
  }

  // booking_service.dart
  Future<Either<Failure, Unit>> createBooking(
      Map<String, dynamic> bookingData) {
    String token = CacheHelper.getString('token') ?? '';

    print('Sending booking request: $bookingData');

    return RequestHundler.handleRequest<Unit>(
      request: (options) => RequestHundler.dio.post(
        '/bookings',
        data: bookingData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
            'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
            'x-vercel-protection-bypass': 'zfUQ9ZLDwFJu2T4hgp4j9KI9Q1DxesP0',
          },
        ),
      ),
      onSuccess: (data) {
        print('Booking created successfully: $data');
        return unit;
      },
      headers: {
        'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
      },
    );
  }

  // booking_service.dart
  Future<Either<Failure, List<BookingNewModel>>> getUserPreviousBookings() {
    String token = CacheHelper.getString('token') ?? '';

    return RequestHundler.handleRequest<List<BookingNewModel>>(
      request: (options) => RequestHundler.dio.get(
        '/users/me/bookings',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'x-vercel-protection-bypass': 'zfUQ9ZLDwFJu2T4hgp4j9KI9Q1DxesP0',
        }),
      ),
      onSuccess: (data) {
        // Handle the API response structure
        if (data is Map<String, dynamic> && data.containsKey('data')) {
          final bookingsJson = data['data'] as List;
          return bookingsJson
              .map((book) => BookingNewModel.fromJson(book))
              .toList();
        } else if (data is List) {
          // Handle case where response is directly a list
          return data.map((book) => BookingNewModel.fromJson(book)).toList();
        }
        return [];
      },
      headers: {
        'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
      },
    );
  }

  // FAVORITES ENDPOINTS

  // Add service to favorites
  Future<Either<Failure, Unit>> addToFavorites(String serviceId) {
    String token = CacheHelper.getString('token') ?? '';

    return RequestHundler.handleRequest<Unit>(
      request: (options) => RequestHundler.dio.post(
        '/favorites',
        data: {
          "serviceId": serviceId,
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
          'x-vercel-protection-bypass': 'zfUQ9ZLDwFJu2T4hgp4j9KI9Q1DxesP0',
        }),
      ),
      onSuccess: (data) {
        print('Service added to favorites: $data');
        return unit;
      },
      headers: {
        'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
      },
    );
  }

  // Remove service from favorites
  Future<Either<Failure, Unit>> removeFromFavorites(String serviceId) {
    String token = CacheHelper.getString('token') ?? '';

    return RequestHundler.handleRequest<Unit>(
      request: (options) => RequestHundler.dio.delete(
        '/favorites/$serviceId',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
          'x-vercel-protection-bypass': 'zfUQ9ZLDwFJu2T4hgp4j9KI9Q1DxesP0',
        }),
      ),
      onSuccess: (data) {
        print('Service removed from favorites: $data');
        return unit;
      },
      headers: {
        'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
      },
    );
  }

  // Get user's favorite services
  Future<Either<Failure, List<ServiceModel>>> getUserFavorites() {
    String token = CacheHelper.getString('token') ?? '';

    return RequestHundler.handleRequest<List<ServiceModel>>(
      request: (options) => RequestHundler.dio.get(
        '/favorites',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
          'x-vercel-protection-bypass': 'zfUQ9ZLDwFJu2T4hgp4j9KI9Q1DxesP0',
        }),
      ),
      onSuccess: (data) {
        // { success: true, count: x, data: [ services ] }
        final servicesJson = data['data'] as List;
        return servicesJson
            .map((service) => ServiceModel.fromJson(service))
            .toList();
      },
      headers: {
        'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
      },
    );
  }

  // Check if service is favorited by user
  Future<Either<Failure, bool>> checkIsFavorited(String serviceId) {
    String token = CacheHelper.getString('token') ?? '';

    return RequestHundler.handleRequest<bool>(
      request: (options) => RequestHundler.dio.get(
        '/favorites/check/$serviceId',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
          'x-vercel-protection-bypass': 'zfUQ9ZLDwFJu2T4hgp4j9KI9Q1DxesP0',
        }),
      ),
      onSuccess: (data) {
        // { success: true, data: { isFavorited: true/false } }
        final isFavorited = data['data']['isFavorited'] as bool;
        return isFavorited;
      },
      headers: {
        'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
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
      request: (options) => RequestHundler.dio.get(
        '/favorites',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
            'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
            'x-vercel-protection-bypass': 'zfUQ9ZLDwFJu2T4hgp4j9KI9Q1DxesP0',
          },
        ),
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
      headers: {
        'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
      },
    );
  }
}
