// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:ploop_fe/model/user_model.dart';

// class UserService {
//   static Future<void> getMissionList(UserRequest user) async {
//     final url = Uri.parse('https://api.ploop.store/api/mission/current');
//     final headers = {'Content-Type': 'application/json'};
//     // TODO: add key-value
//     final body = jsonEncode({});

//     try {
//       final response = await http.patch(url, headers: headers, body: body);

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);

//         debugPrint('OK: ${responseData.body}');
//       } else {
//         debugPrint('patch failed: ${response.statusCode} ${response.body}');
//       }
//     } catch (e) {
//       debugPrint('error: $e');
//     }
//   }
// }
