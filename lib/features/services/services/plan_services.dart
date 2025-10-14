import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/core/utils/helpers/request_hundler.dart';
import 'package:mahu_home_services_app/features/services/models/plan_model.dart';

class PlanServices {
  /// Get all available plans
  Future<Either<Failure, List<Plan>>> getPlans() async {
    try {
      Response response = await RequestHundler.dio.get(
        '$apiBaseURL/plans',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${CacheHelper.getString('token')}',
            'Content-Type': 'application/json',
            'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
          },
        ),
      );

      List<Plan> plans = (response.data as List)
          .map((planJson) => Plan.fromJson(planJson))
          .toList();

      return Right(plans);
    } on DioException catch (e) {
      return Left(Failure('Failed to get plans: ${e.message}'));
    } catch (e) {
      return Left(Failure('Unexpected error occurred'));
    }
  }

  /// Subscribe user to a plan
  Future<Either<Failure, void>> subscribeToPlan({
    required String userId,
    required String planId,
  }) async {
    try {
      await RequestHundler.dio.post(
        '$apiBaseURL/subscription',
        data: {
          'userId': userId,
          'planId': planId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${CacheHelper.getString('token')}',
            'Content-Type': 'application/json',
            'Accept-Language': CacheHelper.getString(appLang) ?? 'en',
          },
        ),
      );

      return const Right(null);
    } on DioException catch (e) {
      return Left(Failure('Failed to subscribe: ${e.message}'));
    } catch (e) {
      return Left(Failure('Unexpected error occurred'));
    }
  }
}
