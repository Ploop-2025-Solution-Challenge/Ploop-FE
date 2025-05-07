import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'country_list_provider.g.dart';

@riverpod
Future<List<String>> countryList(Ref ref) async {
  final url = Uri.parse('https://restcountries.com/v3.1/all?fields=name');
  final headers = {
    'Content-Type': 'application/json; charset=utf-8',
  };
  final response = await http.get(url, headers: headers);
  // debugPrint('$url, $headers');

  if (response.statusCode == 200) {
    final responseData = jsonDecode(utf8.decode(response.bodyBytes));
    debugPrint('OK: $responseData');

    List<String> countries = (responseData as List)
        .map((country) => country['name']['common'] as String)
        .toList()
      ..sort();

    debugPrint('map: ${countries.toString()}');

    return countries;
  } else {
    debugPrint('${response.statusCode}: ${response.body}');
  }
  return [];
}
