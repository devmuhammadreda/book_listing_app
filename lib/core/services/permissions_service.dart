// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

enum LocationPermissionResult {
  Granted,
  Denied,
  DeniedForever,
  UnableToDetermine,
}

class PermissionServices {
  static Future<bool> checkPermission(Permission permission) async {
    PermissionStatus status = await permission.status;
    switch (status) {
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.denied:
        // Permission is denied, request it again
        PermissionStatus requestedStatus = await permission.request();
        return requestedStatus == PermissionStatus.granted;
      case PermissionStatus.permanentlyDenied:
        return false;
      default:
        // Unable to determine permission status
        return false;
    }
  }

  static Future<bool> checkCameraPermission() async {
    return await checkPermission(Permission.camera);
  }

  static Future<bool> checkContactsPermission() async {
    return await checkPermission(Permission.contacts);
  }

  static Future<bool> getGalleryPermission() async {
    return await checkPermission(Permission.storage);
  }

  static Future<bool> checkMicrophonePermission() async {
    return await checkPermission(Permission.microphone);
  }

  static Future<bool> checkStoragePermissions() async {
    PermissionStatus status = await Permission.storage.status;
    switch (status) {
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.denied:
        PermissionStatus requestedStatus = await Permission.storage.request();
        return requestedStatus == PermissionStatus.granted;
      case PermissionStatus.permanentlyDenied:
        return false;
      default:
        return false;
    }
  }

  static Future<bool> permissionPhotoOrStorage() async {
    bool perm = false;
    if (Platform.isIOS) {
      perm = await permissionPhotos();
    } else if (Platform.isAndroid) {
      final AndroidDeviceInfo android = await DeviceInfoPlugin().androidInfo;
      final int sdkInt = android.version.sdkInt;
      perm = sdkInt > 32 ? await permissionPhotos() : await permissionStorage();
    } else {}
    return Future<bool>.value(perm);
  }

  static Future<bool> permissionPhotos() async {
    bool hasPhotosPermission = false;
    final PermissionStatus try0 = await Permission.photos.status;
    if (try0 == PermissionStatus.granted) {
      hasPhotosPermission = true;
    } else {
      final PermissionStatus try1 = await Permission.photos.request();
      if (try1 == PermissionStatus.granted) {
        hasPhotosPermission = true;
      } else {}
    }
    return Future<bool>.value(hasPhotosPermission);
  }

  static Future<bool> permissionStorage() async {
    bool hasStoragePermission = false;
    final PermissionStatus try0 = await Permission.storage.status;
    if (try0 == PermissionStatus.granted) {
      hasStoragePermission = true;
    } else {
      final PermissionStatus try1 = await Permission.storage.request();
      if (try1 == PermissionStatus.granted) {
        hasStoragePermission = true;
      } else {}
    }
    return Future<bool>.value(hasStoragePermission);
  }
}
