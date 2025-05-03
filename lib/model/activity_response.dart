import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_response.freezed.dart';
part 'activity_response.g.dart';

@freezed
abstract class GraphData with _$GraphData {
  const factory GraphData({
    required String label,
    required int trashCount,
  }) = _GraphData;
  factory GraphData.fromJson(Map<String, dynamic> json) =>
      _$GraphDataFromJson(json);
}

@freezed
abstract class ActivityResponse with _$ActivityResponse {
  const factory ActivityResponse({
    required int totalTrash,
    required double totalMiles,
    required double totalHours,
    required int challengeCompleted,
    required int challengeGoal,
    required List<GraphData> graphData,
    int? maxVal,
    int? graphMaxVal,
  }) = _ActivityResponse;

  factory ActivityResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivityResponseFromJson(json);
}
