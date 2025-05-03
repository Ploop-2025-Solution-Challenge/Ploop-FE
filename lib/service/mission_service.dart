import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:ploop_fe/provider/jwt_provider.dart';
import 'package:ploop_fe/model/mission_response.dart';

class MissionService {
  static Future<List<MissionResponse>?> getMissions(String jwt) async {
    final url = Uri.parse('https://api.ploop.store/api/user/missions');
    if (jwt == '') {
      debugPrint('empty jwt');
      return null;
    }
    final headers = {
      'Authorization': 'Bearer $jwt',
    };
    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        debugPrint('OK: ${responseData.body}');
        return responseData
            .map((data) => MissionResponse.fromJson(data))
            .toList();
      } else {
        debugPrint('get failed: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      debugPrint('error: $e');
    }
    return null;
  }
}
