import 'dart:io';

import 'package:image_picker/image_picker.dart';

bool isNotNullOrEmpty(dynamic obj) => !isNullOrEmpty(obj);

/// For String, List, Map
bool isNullOrEmpty(dynamic obj) =>
    obj == null ||
    ((obj is String || obj is List || obj is Map) && obj.isEmpty);

Future<String> pickPhoto(ImageSource imageSource) async {
  final pickedFile = (imageSource == ImageSource.camera
      ? await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 50,
          maxWidth: 2048,
          maxHeight: 2048,
        )
      : await ImagePicker().pickImage(source: ImageSource.gallery));
  if (pickedFile == null) {
    return '';
  }
  File image = File(pickedFile.path);

  return image.path;
}
