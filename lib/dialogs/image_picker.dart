import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

showImagePicker<T>(
    {Function(XFile?)? onResult,
    int maxCunt = 1,
    BuildContext? context}) async {
  showModalBottomSheet<void>(
      context: context!,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                XFile? file = await _showPhotoAlbum(context);
                if (onResult != null) onResult(file);
              },
              title: const Text("Gallery"),
              leading: const Icon(Icons.image),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                XFile? file = await _showCamera();
                if (onResult != null) onResult(file);
              },
              title: const Text("Camera"),
              leading: const Icon(Icons.camera),
            )
          ],
        );
      });
}

Future<XFile?> _showPhotoAlbum(BuildContext context) async {
  XFile? file;
  await Permission.photos.request();
  var permissionStatus = await Permission.photos.status;
  if (permissionStatus.isGranted) {
    ImagePicker imagePicker = ImagePicker();
    file = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 95);
    return file;
  } else {
    Navigator.pop(context);
    return file;
  }
}

Future<XFile?> _showCamera() async {
  XFile? file;
  await Permission.camera.request();
  var permissionStatus = await Permission.camera.status;
  if (permissionStatus.isGranted) {
    ImagePicker imagePicker = ImagePicker();
    file = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 95);
    return file;
  } else {
    return file;
  }
}
