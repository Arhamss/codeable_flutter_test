import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageConversionHelper {
  const ImageConversionHelper._();

  static const _mimeTypes = {
    'png': 'image/png',
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'webp': 'image/webp',
    'gif': 'image/gif',
    'heic': 'image/heic',
  };

  static Future<List<String>> convertToBase64(List<XFile> images) async {
    final result = <String>[];
    for (final image in images) {
      final bytes = await File(image.path).readAsBytes();
      final base64 = base64Encode(bytes);
      final ext = image.path.toLowerCase().split('.').last;
      final mimeType = _mimeTypes[ext] ?? 'application/octet-stream';
      result.add('data:$mimeType;base64,$base64');
    }
    return result;
  }
}
