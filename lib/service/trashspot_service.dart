import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ploop_fe/model/trashspot_request.dart';
import 'package:ploop_fe/model/trashspot_response.dart';

class TrashspotService {
  static Future<bool> postTrashspotPositionToServer(
      TrashspotRequest spot, String jwt, XFile imageFile) async {
    final url = Uri.parse('https://api.ploop.store/api/map/trashspot');
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
      request.fields['longitude'] = spot.longitude.toString();
      request.fields['latitude'] = spot.latitude.toString();

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

  static Future<List<TrashspotResponse>?> getSpotPosition(
      String jwt, LatLngBounds bounds) async {
    final url = Uri.parse(
        'https://api.ploop.store/api/map/trashspot/bounds?minLat=${bounds.southwest.latitude}&maxLat=${bounds.northeast.latitude}&minLng=${bounds.southwest.longitude}&maxLng=${bounds.northeast.latitude}');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        debugPrint('OK: $responseData');
        return responseData
            .map((data) => TrashspotResponse.fromJson(data))
            .toList();
      } else {
        debugPrint('get failed: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('error: $e');
      return null;
    }
  }
}
