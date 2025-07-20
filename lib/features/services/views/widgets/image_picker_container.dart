import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class ImagePickerContainer extends StatelessWidget {
  final VoidCallback onTap;
  final XFile? selectedImage;

  const ImagePickerContainer({
    super.key,
    required this.onTap,
    required this.selectedImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        color: AppColors.blue,
        strokeWidth: 2,
        dashPattern: const [8],
        borderType: BorderType.RRect,
        radius: const Radius.circular(8),
        child: Container(
          height: 168.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.blue[50],
          ),
          child: Center(
            child: selectedImage == null
                ? Image.asset(
                    'assets/icons/upload.png',
                    height: 70.h,
                  )
                : Image.file(
                    File(selectedImage!.path),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
          ),
        ),
      ),
    );
  }
}
