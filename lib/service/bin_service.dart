import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ploop_fe/model/bin_request.dart';
import 'package:ploop_fe/model/bin_response.dart';

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

      final bytes = await imageFile.readAsBytes();
      final multipartFile = http.MultipartFile.fromBytes(
        'image',
        bytes,
        filename: imageFile.name,
      );
      request.files.add(multipartFile);

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

  static Future<List<BinResponse>?> getBinPosition(
      String jwt, LatLngBounds bounds) async {
    final url = Uri.parse(
        'https://api.ploop.store/api/map/bin/bounds?minLat=${bounds.southwest.latitude}&maxLat=${bounds.northeast.latitude}&minLng=${bounds.southwest.longitude}&maxLng=${bounds.northeast.longitude}');
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
        // debugPrint('OK: $responseData');
        return responseData.map((data) => BinResponse.fromJson(data)).toList();
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
