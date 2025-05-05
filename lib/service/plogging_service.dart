import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ploop_fe/model/activity_request.dart';

class PloggingActivityService {
  static Future<void> postPloggingDataToServer(
      ActivityRequest activity, String jwt) async {
    final url = Uri.parse('https://api.ploop.store/api/plogging/end');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt'
    };
    final body = jsonEncode(activity.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final routeId = jsonDecode(response.body);

        debugPrint('OK: $routeId');
      } else {
        debugPrint('post failed: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      debugPrint('error: $e');
    }
  }
}
