import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/user_request.dart';
import '../model/user_response.dart';

class UserService {
  static Future<void> patchUserProfileToServer(
      UserRequest user, String jwt) async {
    final url = Uri.parse('https://api.ploop.store/api/user/profile');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt'
    };
    final body = jsonEncode(user.toJson());

    try {
      final response = await http.patch(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // debugPrint('OK: $responseData');
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
        // debugPrint('OK: $responseData');
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
