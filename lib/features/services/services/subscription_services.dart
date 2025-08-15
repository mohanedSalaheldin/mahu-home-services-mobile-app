import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/core/utils/helpers/request_hundler.dart';
import 'package:mahu_home_services_app/features/services/models/subscription_model.dart';

class SubscriptionServices {
  /// Get user's subscription
  Future<Either<Failure, Subscription>> getUserSubscription(String userId) async {
    try {
      Response response = await RequestHundler.dio.get(
        '$apiBaseURL/subscription/users/$userId',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${CacheHelper.getString('token')}',
            'Content-Type': 'application/json',
          },
        ),
      );

      return Right(Subscription.fromJson(response.data['data']));
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return Left(Failure('No active subscription found'));
      }
      return Left(Failure('Failed to get subscription: ${e.message}'));
    } catch (e) {
      return Left(Failure('Unexpected error occurred'));
    }
  }

  /// Subscribe user to a plan
  Future<Either<Failure, Subscription>> subscribeToPlan({
    required String userId,
    required String planId,
  }) async {
    try {
      Response response = await RequestHundler.dio.post(
        '$apiBaseURL/subscriptions',
        data: {
          'userId': userId,
          'planId': planId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${CacheHelper.getString('token')}',
            'Content-Type': 'application/json',
          },
        ),
      );

      return Right(Subscription.fromJson(response.data['data']));
    } on DioException catch (e) {
      return Left(Failure('Failed to subscribe: ${e.message}'));
    } catch (e) {
      return Left(Failure('Unexpected error occurred'));
    }
  }
}