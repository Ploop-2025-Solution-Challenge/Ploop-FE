import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';

part 'bin_request.freezed.dart';
part 'bin_request.g.dart';

@freezed
abstract class BinRequest with _$BinRequest {
  const factory BinRequest({
    @JsonKey(includeFromJson: false, includeToJson: false) MultipartFile? image,
    required double latitude,
    required double longitude,
  }) = _BinRequest;

  factory BinRequest.fromJson(Map<String, dynamic> json) =>
      _$BinRequestFromJson(json);
}
