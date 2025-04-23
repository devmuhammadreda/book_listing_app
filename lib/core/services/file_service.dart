import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'permissions_service.dart';

class FileService {
  Future<List<File>?> takePhoto() async {
    bool hasCameraPermission = await PermissionServices.checkCameraPermission();
    if (!hasCameraPermission) {
      return null;
    }

    final ImagePicker picker = ImagePicker();
    try {
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        return [File(photo.path)];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to take photo: $e');
      }
    }
    return null;
  }

  Future<List<File>?> pickImageFromGallery() async {
    bool hasGalleryPermission = await PermissionServices.permissionPhotoOrStorage();
    if (!hasGalleryPermission) {
      return null;
    }

    final ImagePicker picker = ImagePicker();
    try {
      final List<XFile> images = await picker.pickMultiImage();
      return images.map((image) => File(image.path)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
    return null;
  }

  Future<List<File>?> pickFiles() async {
    bool hasStoragePermission =
        await PermissionServices.checkStoragePermissions();
    if (!hasStoragePermission) {
      return null;
    }
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ["pdf"],
      );
      if (result != null) {
        return result.paths.map((path) => File(path!)).toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to pick files: $e');
      }
    }
    return null;
  }
}
