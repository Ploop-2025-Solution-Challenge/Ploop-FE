import 'package:freezed_annotation/freezed_annotation.dart';

part 'mission.freezed.dart';
part 'mission.g.dart';

@freezed
abstract class Mission with _$Mission {
  const factory Mission({
    required String name, // mission name
    required bool isVerified,
  }) = _Mission;

  factory Mission.fromJson(Map<String, dynamic> json) =>
      _$MissionFromJson(json);
}
