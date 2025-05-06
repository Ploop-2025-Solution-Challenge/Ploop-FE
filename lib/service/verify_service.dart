import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class VerifyService {
  static Future<bool> postVerification(
      int userMissionId, String jwt, XFile imageFile) async {
    final url = Uri.parse('https://api.ploop.store/api/mission/verification');
    final headers = {
      'Authorization': 'Bearer $jwt',
    };

    try {
      final request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);

      final bytes = await imageFile.readAsBytes();
      final multipartFile = http.MultipartFile.fromBytes(
        'image',
        bytes,
        filename: imageFile.name,
      );
      request.files.add(multipartFile);
      request.fields['userMissionId'] = userMissionId.toString();

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        debugPrint('OK: $responseData');
        return true;
      } else {
        debugPrint('post failed: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      debugPrint('error: $e');
    }
    return false;
  }
}
