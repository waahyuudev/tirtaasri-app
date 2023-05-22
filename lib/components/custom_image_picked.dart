import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tirtaasri_app/components/custom_text.dart';

import '../theme/colors.dart';
import '../theme/styles.dart';

class CustomImagePicked extends StatelessWidget {
  final Function(String?) onPicked;

  const CustomImagePicked({super.key, required this.onPicked});

  void _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 500,
      maxHeight: 500,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      _cropImage(pickedFile);
    }
  }

  Future<void> _cropImage(XFile? pickedFile) async {
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              activeControlsWidgetColor: AppColors.primaryColor,
              toolbarTitle: 'Cropper',
              toolbarColor: AppColors.primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        validateImage(croppedFile.path);
      }
    }
  }

  void validateImage(String path) {
    File file = File(path);
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    debugPrint("sizeInMb $sizeInMb");
    if (sizeInMb > 1) {
      // This file is Longer the
    } else {
      onPicked(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 0,
          title: CustomText(
              text: "Upload Profile",
              color: AppColors.black87,
              style: AppStyles.bold16),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: () => _pickImage(ImageSource.camera),
          horizontalTitleGap: 0,
          title: CustomText(
              text: "Camera",
              color: AppColors.black87,
              style: AppStyles.regular14),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: () => _pickImage(ImageSource.gallery),
          horizontalTitleGap: 0,
          title: CustomText(
              text: "Gallery",
              color: AppColors.black87,
              style: AppStyles.regular14),
        )
      ],
    );
  }
}
