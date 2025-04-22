import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ploop_fe/model/bin_request.dart';

class BinService {
  static Future<bool> postBinPositionToServer(
      BinRequest bin, String jwt, XFile imageFile) async {
    final url = Uri.parse('https://api.ploop.store/api/map/bin');
    final headers = {
      'Authorization': 'Bearer $jwt',
    };

    try {
      final request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);

      // 이미지 파일 추가
      final bytes = await imageFile.readAsBytes();
      final multipartFile = http.MultipartFile.fromBytes(
        'image',
        bytes,
        filename: imageFile.name,
      );
      request.files.add(multipartFile);

      // 필드 추가
      request.fields['longitude'] = bin.longitude.toString();
      request.fields['latitude'] = bin.latitude.toString();

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

  // static Future<BinResponse?> getBinPosition()
}
