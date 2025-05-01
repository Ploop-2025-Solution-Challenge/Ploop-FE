import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'activity_request.freezed.dart';
part 'activity_request.g.dart';

@freezed
abstract class ActivityRequest with _$ActivityRequest {
  const factory ActivityRequest({
    required String userId,
    required List<(double, double)> activityRoute,
    required String timeDuration,
    required String updatedDateTime,
    required double distanceMiles,
    required int trashCollectedCount,
  }) = _ActivityRequest;

  factory ActivityRequest.fromJson(Map<String, dynamic> json) =>
      _$ActivityRequestFromJson(json);
}
