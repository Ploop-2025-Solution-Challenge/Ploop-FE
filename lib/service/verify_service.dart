import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class VerifyService {
  static Future<bool> postVerification(
      int userMissionId, String jwt, XFile imageFile) async {
    final url = Uri.parse(
        'https://api.ploop.store/api/mission/verification?userMissionId=$userMissionId');
    final headers = {
      'Authorization': 'Bearer $jwt',
    };

    try {
      final request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);

      final bytes = await imageFile.readAsBytes();
      final multipartFile = http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: imageFile.name,
      );
      request.files.add(multipartFile);

      final streamedResponse = await request.send();
      debugPrint(
          '${request.url}, ${request.headers}, ${request.fields}, ${request.files}');
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(utf8.decode(response.bodyBytes));
        debugPrint('OK: $responseData');
        return (responseData['verified']);
      } else {
        debugPrint('post failed: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      debugPrint('error: $e');
    }
    return false;
  }
}
