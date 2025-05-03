import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ploop_fe/model/activity_filter.dart';
import 'package:ploop_fe/model/activity_response.dart';
import 'package:ploop_fe/provider/jwt_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity_data_provider.g.dart';

@riverpod
Future<ActivityResponse> activityData(
    Ref ref, Range range, DateTime startDate, DateTime endDate) async {
  // final filter = ref.watch(activityFilterNotifierProvider);
  final jwt = ref.read(jwtNotifierProvider).jwt;
  debugPrint('jwt: $jwt');

  final String startParam = DateFormat('y-MM-dd').format(startDate);
  final String endParam = DateFormat('y-MM-dd').format(endDate);

  if (jwt != null) {
    final url = Uri.parse(
        'https://api.ploop.store/api/activity?range=${range.name}&startDate=$startParam&endDate=$endParam');
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $jwt'
    };
    final response = await http.get(url, headers: headers);
    debugPrint('$url, $headers');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      debugPrint('OK: $responseData');
      return ActivityResponse.fromJson(responseData);
    } else {
      debugPrint('${response.statusCode}: ${response.body}');
    }
  } else {
    debugPrint('error: null jwt');
  }
  return const ActivityResponse(
      totalTrash: 0,
      totalMiles: 0,
      totalHours: 0,
      challengeCompleted: 0,
      challengeGoal: 0,
      graphData: []);
}
