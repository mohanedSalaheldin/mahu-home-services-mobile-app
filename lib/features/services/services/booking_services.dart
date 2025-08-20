import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/utils/helpers/request_hundler.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/features/services/models/booking_model.dart';

class BookingServices {
  Future<Either<Failure, List<BookingModel>>> getMyBookings() {
    String token = CacheHelper.getString('token') ?? '';

    return RequestHundler.handleRequest<List<BookingModel>>(
      request: () => RequestHundler.dio.get('/providers/me/bookings',
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
    );
  }

  Future<Either<Failure, List<BookingModel>>> getUserPreviousBookings() {
    String token = CacheHelper.getString('token') ?? '';

    return RequestHundler.handleRequest<List<BookingModel>>(
      request: () => RequestHundler.dio.get(
        '/users/me/bookings',
        queryParameters: {
          'previous': 'true',
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

  Future<Either<Failure, Unit>> changeBookingStatus(
      String bookingID, String status) {
    String token = CacheHelper.getString('token') ?? '';

    return RequestHundler.handleRequest<Unit>(
      request: () => RequestHundler.dio.put('/bookings/$bookingID/status',
          data: {"status": status},
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          })),
      onSuccess: (data) {
        return unit;
      },
    );
  }
}
