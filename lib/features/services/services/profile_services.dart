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
import 'package:image_picker/image_picker.dart';

class ProfileServices {
  /// Get provider profile by referenceId
  Future<Either<Failure, UserBaseProfileModel>> getProviderProfile(
      String referenceId) async {
    try {
      Response response = await RequestHundler.dio.get(
        '$apiBaseURL/providers/$referenceId',
        options: Options(
          headers: {
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

  Future<Either<Failure, UserBaseProfileModel>> editUserProfile({
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
      if (firstName != null) data['firstName'] = firstName;
      if (lastName != null) data['lastName'] = lastName;
      if (avatar != null) data['avatar'] = avatar;

      Response response = await RequestHundler.dio.put(
        '$apiBaseURL/users/me',
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
  
  
  Future<Either<Failure, UserBaseProfileModel>> editProviderProfile({
    String? email,
    String? phone,
    String? firstName,
    String? lastName,
    String? businessName,
    String? avatar,
  }) async {
    try {
      final Map<String, dynamic> data = {};

      if (email != null) data['email'] = email;
      if (phone != null) data['phone'] = phone;
      if (firstName != null) data['firstName'] = firstName;
      if (lastName != null) data['lastName'] = lastName;
      if (businessName != null) data['businessName'] = lastName;
      if (avatar != null) data['avatar'] = avatar;

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

Future<File?> pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}

Future<String?> uploadImage(File imageFile) async {
  try {
    String uploadUrl = '$apiBaseURL/users/upload-media';

    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imageFile.path, 
        filename: 'avatar_${DateTime.now().millisecondsSinceEpoch}.jpg',
      ),
    });

    // Use RequestHundler.dio if available, otherwise create new Dio instance
    final dio = RequestHundler.dio;

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
      // Corrected based on your Postman response
      // The image URL is directly in response.data['imageUrl'], not nested under 'data'
      String imageUrl = response.data['imageUrl'];
      return imageUrl;
    } else {
      print('Failed to upload image: ${response.statusCode}');
      print('Response data: ${response.data}');
      return null;
    }
  } catch (e) {
    print('Error uploading image: $e');
    return null;
  }
}