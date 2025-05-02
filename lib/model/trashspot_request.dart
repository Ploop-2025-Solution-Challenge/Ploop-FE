import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';

part 'trashspot_request.freezed.dart';
part 'trashspot_request.g.dart';

@freezed
abstract class TrashspotRequest with _$TrashspotRequest {
  const factory TrashspotRequest({
    @JsonKey(includeFromJson: false, includeToJson: false) MultipartFile? image,
    required double latitude,
    required double longitude,
  }) = _TrashspotRequest;

  factory TrashspotRequest.fromJson(Map<String, dynamic> json) =>
      _$TrashspotRequestFromJson(json);
}
