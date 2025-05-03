import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:ploop_fe/model/mission_response.dart';
import 'package:ploop_fe/provider/jwt_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mission_provider.g.dart';

@riverpod
Future<MissionResponse> missionData(Ref ref) async {
  final jwt = ref.read(jwtNotifierProvider).jwt;
  debugPrint('jwt: $jwt');
  if (jwt != null) {
    final url = Uri.parse('https://api.ploop.store/api/user/missions/summary');
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $jwt'
    };
    final response = await http.get(url, headers: headers);
    // debugPrint('$url, $headers');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      debugPrint('OK: $responseData');
      return MissionResponse.fromJson(responseData);
    } else {
      debugPrint('${response.statusCode}: ${response.body}');
    }
  } else {
    debugPrint('error: null jwt');
  }
  return const MissionResponse(
      partnerName: '', partnerMissions: [], myMissions: []);
}
