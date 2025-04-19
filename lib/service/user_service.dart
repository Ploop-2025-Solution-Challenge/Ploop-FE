import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ploop_fe/model/user_model.dart';

class UserService {
  static Future<void> patchUserProfileToServer(PatchUserRequest user) async {
    final url = Uri.parse('https://api.ploop.store/api/user/patch');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'country': user.country,
      'region': user.region,
      'date of birth': user.dateOfBirth, // or calculated age
      'gender': user.gender,
      'nickname': user.nickname,
      'difficulty': user.difficulty,
      'motivation': user.motivation,
      'location preferences': user.locationPreferences,
    });

    try {
      final response = await http.patch(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        debugPrint('OK: ${responseData.body}');
      } else {
        debugPrint('patch failed: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  static Future<UserResponse?> getUserProfile(String jwt) async {
    final url = Uri.parse('https://api.ploop.store/api/user/me');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt'
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        debugPrint('OK: $responseData.body');
        return UserResponse.fromJson(responseData);
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
