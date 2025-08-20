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

  Future<Either<Failure, List<ServiceModel>>> getServicesByProvider(String referenceId) {
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
}
