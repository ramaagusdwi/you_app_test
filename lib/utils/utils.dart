import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

enum Severity { Info, Success, Error }

class Utils {
  static createSnackBar(String message, {Severity type = Severity.Info, Duration? duration}) {
    return SnackBar(
      backgroundColor: type == Severity.Info
          ? Colors.blue
          : type == Severity.Error
              ? Colors.red
              : Colors.green,
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      duration: duration ?? const Duration(seconds: 2),
    );
  }

  static Future<bool> checkAndRequestCameraPermissions() async {
    var status = await Permission.camera.status;

    if (await Permission.camera.isPermanentlyDenied) {
      AppSettings.openAppSettings(callback: () {
        log('callback');
      });
      return false;
    }

    if (!status.isGranted) {
      log('isNotGranted');
      var stts = await Permission.camera.request();
      log('CEK ISDENIED: ${stts.isDenied}');
      log('CEK ISRESTRICTED: ${stts.isRestricted}');
      log('CEK ISRESTRICTED: ${stts.isRestricted}');
      return stts.isGranted;
    } else {
      log('isGranted');
      return true;
    }
  }

  static Future<String?> pickMedia({bool isCamera = true}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = isCamera
        ? await picker.pickImage(source: ImageSource.camera, imageQuality: 1)
        : await picker.pickImage(source: ImageSource.gallery, imageQuality: 1);
    return image?.path;
  }

  static Future<List<String>> pickMultiImage() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile> images = await _picker.pickMultiImage(imageQuality: 25);

    List<String> listPath = [];
    for (var i in images) {
      listPath.add(i.path);
    }

    return listPath;
  }

  static String convertToBase64(String path) {
    final bytes = File(path).readAsBytesSync();
    String base64Image = "data:image/png;base64," + base64Encode(bytes);
    return base64Image;
  }
}
