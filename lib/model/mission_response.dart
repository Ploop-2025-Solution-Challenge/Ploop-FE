import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ploop_fe/model/mission.dart';

part 'mission_response.freezed.dart';
part 'mission_response.g.dart';

@freezed
abstract class MissionResponse with _$MissionResponse {
  const factory MissionResponse({
    required String partnerName,
    required List<Mission> partnerMissions, // ?
    required List<Mission> myMissions,
  }) = _MissionResponse;

  factory MissionResponse.fromJson(Map<String, dynamic> json) =>
      _$MissionResponseFromJson(json);
}
