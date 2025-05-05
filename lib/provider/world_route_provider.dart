// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:ploop_fe/model/activity_filter.dart';
// import 'package:ploop_fe/model/activity_response.dart';
// import 'package:ploop_fe/model/route_model.dart';
// import 'package:ploop_fe/provider/jwt_provider.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'world_route_provider.g.dart';

// @riverpod
// Future<RouteModel> worldRoute(
//     Ref ref, LatLngBounds bounds) async {
//   final jwt = ref.read(jwtNotifierProvider).jwt;

//   if (jwt != null) {
//     final url = Uri.parse(
//         'https://api.ploop.store/api/activity?range=${range.name}&startDate=$startParam&endDate=$endParam');
//     final headers = {
//       'Content-Type': 'application/json; charset=utf-8',
//       'Authorization': 'Bearer $jwt'
//     };
//     final response = await http.get(url, headers: headers);
//     // debugPrint('$url, $headers');

//     if (response.statusCode == 200) {
//       final responseData = jsonDecode(utf8.decode(response.bodyBytes));
//       debugPrint('OK: $responseData');
//       return RouteModel.fromJson(responseData);
//     } else {
//       debugPrint('${response.statusCode}: ${response.body}');
//     }
//   } else {
//     debugPrint('error: null jwt');
//   }
//   return const RouteModel(routeId: '-1', userId: userId, route: route, updatedDateTime: updatedDateTime)
// }
