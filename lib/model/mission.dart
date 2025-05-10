import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mission.freezed.dart';
part 'mission.g.dart';

@freezed
abstract class Mission with _$Mission {
  const factory Mission({
    required int userMissionId,
    required String name,
    required bool verified,
  }) = _Mission;

  factory Mission.fromJson(Map<String, dynamic> json) =>
      _$MissionFromJson(json);
}
