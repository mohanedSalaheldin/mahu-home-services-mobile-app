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
        List<dynamic> servicesJson = [];
        if (data is Map<String, dynamic> && data['data'] is List<dynamic>) {
          servicesJson = List<dynamic>.from(data['data']);
        } else if (data is List<dynamic>) {
          servicesJson = data;
        }

        return servicesJson
            .map((service) => ServiceModel.fromJson(service as Map<String, dynamic>))
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
        List<dynamic> servicesJson = [];
        if (data is Map<String, dynamic> && data['data'] is List<dynamic>) {
          servicesJson = List<dynamic>.from(data['data']);
        } else if (data is List<dynamic>) {
          servicesJson = data;
        }

        return servicesJson
            .map((service) => ServiceModel.fromJson(service as Map<String, dynamic>))
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

        // Handle different response formats safely
        if (data is Map<String, dynamic>) {
          if (data.containsKey('success')) {
            final successVal = data['success'];
            if (successVal is bool) return successVal;
            if (successVal is String) return successVal.toLowerCase() == 'true';
          }
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
        // Handle the API response structure safely
        List<dynamic> bookingsJson = [];
        if (data is Map<String, dynamic> && data['data'] is List<dynamic>) {
          bookingsJson = List<dynamic>.from(data['data']);
        } else if (data is List<dynamic>) {
          bookingsJson = data;
        }

        return bookingsJson
            .map((book) => BookingNewModel.fromJson(book as Map<String, dynamic>))
            .toList();
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
        List<dynamic> servicesJson = [];
        if (data is Map<String, dynamic> && data['data'] is List<dynamic>) {
          servicesJson = List<dynamic>.from(data['data']);
        } else if (data is List<dynamic>) {
          servicesJson = data;
        }

        return servicesJson
            .map((service) => ServiceModel.fromJson(service as Map<String, dynamic>))
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
        if (data is Map<String, dynamic>) {
          final inner = data['data'];
          if (inner is Map<String, dynamic>) {
            final val = inner['isFavorited'];
            if (val is bool) return val;
            if (val is String) return val.toLowerCase() == 'true';
          }

          // sometimes server returns isFavorited at top-level
          final topVal = data['isFavorited'];
          if (topVal is bool) return topVal;
          if (topVal is String) return topVal.toLowerCase() == 'true';
        }

        return false;
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
        List<dynamic> servicesJson = [];
        if (data is Map<String, dynamic> && data['data'] is List<dynamic>) {
          servicesJson = List<dynamic>.from(data['data']);
        } else if (data is List<dynamic>) {
          servicesJson = data;
        }

        final services = servicesJson
            .map((service) => ServiceModel.fromJson(service as Map<String, dynamic>))
            .toList();

        return {
          'services': services,
          'count': data is Map<String, dynamic> ? data['count'] : null,
          'pagination': data is Map<String, dynamic> ? data['pagination'] : null,
        };
      },
      headers: {
        'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
      },
    );
  }
}
