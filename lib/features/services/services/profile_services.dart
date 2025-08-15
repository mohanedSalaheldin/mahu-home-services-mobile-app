import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/core/utils/helpers/request_hundler.dart';
import 'package:mahu_home_services_app/features/services/models/user_base_profile_model.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart'; // تأكد من مسار الـ apiBaseURL

class ProfileServices {
  /// Get logged-in user's profile
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
      return Right(
        UserBaseProfileModel.fromJson(response.data['data']),
      );
    } catch (e) {
      print(e);
      return Left(Failure('Server Error'));
    }
  }

  /// Edit logged-in provider's profile
  Future<Either<Failure, UserBaseProfileModel>> editProfile({
    String? email,
    String? phone,
    String? firstName,
    String? lastName,
    String? avatar,
  }) async {
    try {
      final Map<String, dynamic> data = {};

      if (email != null) data['email'] = email;
      if (phone != null) data['phone'] = phone;

      final Map<String, dynamic> profileData = {};
      if (firstName != null) profileData['firstName'] = firstName;
      if (lastName != null) profileData['lastName'] = lastName;
      if (avatar != null) profileData['avatar'] = avatar;

      if (profileData.isNotEmpty) data['profile'] = profileData;

      Response response = await RequestHundler.dio.put(
        '$apiBaseURL/providers/me',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${CacheHelper.getString('token')}',
            'Content-Type': 'application/json',
          },
        ),
      );

      return Right(
        UserBaseProfileModel.fromJson(response.data['data']['profile']),
      );
    } catch (e) {
      print(e);
      return Left(Failure('Failed to update profile'));
    }
  }
}


Future<String?> uploadImage(File imageFile) async {
  try {
    String uploadUrl = '$apiBaseURL/users/upload-media';

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imageFile.path, filename: 'avatar.jpg'),
    });

    Dio dio = Dio();

    final response = await dio.post(
      uploadUrl,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer ${CacheHelper.getString('token')}',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // حسب رد السيرفر، غيّر حسب هيكلة البيانات التي ترجعها
      // مثلا: response.data['data']['url'] أو response.data['url']
      String imageUrl = response.data['data']['url'];
      return imageUrl;
    } else {
      print('Failed to upload image: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error uploading image: $e');
    return null;
  }
}

