import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';

part 'bin_response.freezed.dart';
part 'bin_response.g.dart';

@freezed
abstract class BinResponse with _$BinResponse {
  const factory BinResponse({
    required int id,
    required double latitude,
    required double longitude,
  }) = _BinResponse;

  factory BinResponse.fromJson(Map<String, dynamic> json) =>
      _$BinResponseFromJson(json);
}
