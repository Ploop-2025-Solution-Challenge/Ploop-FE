import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ploop_fe/model/activity_filter.dart';
import 'package:ploop_fe/model/activity_response.dart';
import 'package:ploop_fe/model/route_model.dart';
import 'package:ploop_fe/provider/jwt_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'world_route_provider.g.dart';

@riverpod
Future<List<RouteModel>?> worldRoute(Ref ref, LatLngBounds bounds) async {
  final jwt = ref.read(jwtNotifierProvider).jwt;

  if (jwt != null) {
    final url = Uri.parse(
        'https://api.ploop.store/api/world/routes/bounds?minLat=${bounds.southwest.latitude}&maxLat=${bounds.northeast.latitude}&minLng=${bounds.southwest.longitude}&maxLng=${bounds.northeast.longitude}');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    };
    final response = await http.get(url, headers: headers);
    // debugPrint('$url, $headers');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      debugPrint('OK: ${responseData[0]['activityRouteJson']}');

      if (responseData != null) {
        return responseData.map((data) {
          debugPrint('data: $data');
          RouteModel.fromJson(data);
        }).toList();
      } else {
        debugPrint('null responseData');
      }
    } else {
      debugPrint('${response.statusCode}: ${response.body}');
    }
  } else {
    debugPrint('error: null jwt');
  }
  return null;
}
