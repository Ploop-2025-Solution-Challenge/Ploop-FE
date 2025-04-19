import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<void> sendIdTokenToServer(String idToken) async {
    final url = Uri.parse('');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'idToken': idToken});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final jwt = responseData['accessToken'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt', jwt);

        print('saved jwt: $jwt');
      } else {
        print('login failed: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('error: $e');
    }
  }
}
