import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/core/utils/helpers/request_hundler.dart';
import 'package:mahu_home_services_app/features/services/models/user_base_profile_model.dart';

class ProfileServices {

  Future<Either<Failure, UserBaseProfileModel>> getProfile() async {
    try {
      Response response = await RequestHundler.dio.get(
        '$apiBaseURL/users/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${CacheHelper.getString('token')}',
            'Content-Type': 'application/json',
          },
        ),
      );
      print(response.data);
      return Right(
          UserBaseProfileModel.fromJson(response.data['data']['profile']));
    } catch (e) {
      print(e);
      return Left(Failure('Server Error'));
    }
  }
}
