import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/core/utils/helpers/request_hundler.dart';

class ReviewServices {
  Future<Either<Failure, bool>> addReview({
    required String serviceId,
    required int rating,
    required String feedback,
    required String token,
  }) {
    return RequestHundler.handleRequest<bool>(
      request: (options) => RequestHundler.dio.post(
        '$apiBaseURL/services/$serviceId/reviews',
        data: {
          'rating': rating,
          'feedback': feedback,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
            'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
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
      request: (options) => RequestHundler.dio.get(
        '/services/$serviceId/reviews',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Accept-Language": CacheHelper.getString(appLang) ?? 'en',
          },
        ),
      ),
      onSuccess: (data) {
        print('Full API response: $data');

        // If API returned a wrapper with `data` as a List (common pattern),
        // transform it into the expected Map shape used by the UI:
        // { 'reviews': List, 'averageRating': double, 'totalReviews': int }
        if (data is Map<String, dynamic>) {
          // case: { success: true, count: 8, data: [ ... ] }
          if (data.containsKey('data') && data['data'] is List<dynamic>) {
            final List<dynamic> reviewsList = List<dynamic>.from(data['data']);
            final int total = data['count'] is int ? data['count'] as int : reviewsList.length;
            final double avg = (data['averageRating'] != null)
                ? (double.tryParse(data['averageRating'].toString()) ?? 0.0)
                : 0.0;

            return {
              'reviews': reviewsList,
              'averageRating': avg,
              'totalReviews': total,
            };
          }

          // case: API already returns the expected object with 'reviews'
          if (data.containsKey('reviews') && data['reviews'] is List<dynamic>) {
            return data;
          }
        }

        // If response is a plain List (unlikely through current handler but handle anyway)
        if (data is List<dynamic>) {
          return {
            'reviews': data,
            'averageRating': 0.0,
            'totalReviews': data.length,
          };
        }

        // Last resort: return empty shape
        return {
          'reviews': <dynamic>[],
          'averageRating': 0.0,
          'totalReviews': 0,
        };
      },
    );
  }

  Future<Either<Failure, Map<String, dynamic>?>> getMyReviewForService(
      String serviceId, String token) {
    return RequestHundler.handleRequest<Map<String, dynamic>?>(
      request: (options) => RequestHundler.dio.get(
        '$apiBaseURL/services/$serviceId/reviews/my-review',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
          },
        ),
      ),
      onSuccess: (data) {
        return data;
      },
    );
  }
}
