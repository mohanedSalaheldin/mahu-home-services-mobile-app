import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';

class UploadMediaHelper {
  static Future<String?> uploadImage(File imageFile) async {
    const String baseUrl = apiBaseURL; // Replace with your actual base URL
    const String endpoint = '/users/upload-media';
    String token =
        CacheHelper.getString('token') ?? ''; // Replace with your actual token

    final Dio dio = Dio();

    // Set Authorization header
    dio.options.headers['Authorization'] = 'Bearer $token';

    // Create FormData with image file
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
        
      ),
    });

    try {
      final response = await dio.post(
        '$baseUrl$endpoint',
        data: formData,
      );
      print(response.data);
      // Check if the response contains the expected data
      if (response.statusCode == 200 && response.data['imageUrl'] != null) {
        return response.data['imageUrl'];
      } else {
        print('Unexpected response: ${response.data}');
        return null;
      }
    } on DioException catch (e) {
      print('Upload failed: ${e.response?.data ?? e.message}');
      return null;
    }
  }
}

class UploadTestScreen extends StatefulWidget {
  const UploadTestScreen({super.key});

  @override
  _UploadTestScreenState createState() => _UploadTestScreenState();
}

class _UploadTestScreenState extends State<UploadTestScreen> {
  File? _selectedImage;
  String? _uploadedImageUrl;
  bool _isUploading = false;

  final picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> handleUpload() async {
    if (_selectedImage == null) return;

    setState(() {
      _isUploading = true;
    });

    final imageUrl = await UploadMediaHelper.uploadImage(_selectedImage!);
    setState(() {
      _uploadedImageUrl = imageUrl;
      _isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Image Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('Pick Image'),
            ),
            if (_selectedImage != null)
              Image.file(_selectedImage!, height: 150),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isUploading ? null : handleUpload,
              child: _isUploading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Upload Image'),
            ),
            const SizedBox(height: 16),
            if (_uploadedImageUrl != null)
              Column(
                children: [
                  const Text('Uploaded Image:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Image.network(_uploadedImageUrl!, height: 150),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
