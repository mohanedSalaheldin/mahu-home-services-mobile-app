import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/utils/helpers/request_hundler.dart';

class ReviewServices {
  Future<Either<Failure, bool>> addReview({
    required String serviceId,
    required int rating,
    required String feedback,
    required String token,
  }) {
    return RequestHundler.handleRequest<bool>(
      request: () => RequestHundler.dio.post(
        '$apiBaseURL/services/$serviceId/reviews',
        data: {
          'rating': rating,
          'feedback': feedback,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      ),
      onSuccess: (data) {
        return true;
      },
    );
  }

  Future<Either<Failure, Map<String, dynamic>>> getServiceReviews(
      String serviceId) {
    return RequestHundler.handleRequest<Map<String, dynamic>>(
      request: () => RequestHundler.dio.get(
        '/services/$serviceId/reviews',
      ),
      onSuccess: (data) {
        print('Full API response: $data');

        // Handle the nested structure
        if (data is Map<String, dynamic> &&
            data.containsKey('data') &&
            data['data'] is Map<String, dynamic>) {
          return data['data'] as Map<String, dynamic>;
        }

        // Fallback: try to handle if it's already the data object
        if (data is Map<String, dynamic> && data.containsKey('reviews')) {
          return data;
        }

        return {}; // Return empty map
      },
    );
  }

  Future<Either<Failure, Map<String, dynamic>?>> getMyReviewForService(
      String serviceId, String token) {
    return RequestHundler.handleRequest<Map<String, dynamic>?>(
      request: () => RequestHundler.dio.get(
        '$apiBaseURL/services/$serviceId/reviews/my-review',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      ),
      onSuccess: (data) {
        return data;
      },
    );
  }
}
