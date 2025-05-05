import 'package:freezed_annotation/freezed_annotation.dart';

part 'trashspot_response.freezed.dart';
part 'trashspot_response.g.dart';

@freezed
abstract class TrashspotResponse with _$TrashspotResponse {
  const factory TrashspotResponse({
    required int id,
    required double latitude,
    required double longitude,
    required String imageUrl,
    required String createdAt,
  }) = _TrashspotResponse;

  factory TrashspotResponse.fromJson(Map<String, dynamic> json) =>
      _$TrashspotResponseFromJson(json);
}
