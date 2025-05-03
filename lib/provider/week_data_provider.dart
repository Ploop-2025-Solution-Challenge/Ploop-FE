import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ploop_fe/model/activity_response.dart';
import 'package:ploop_fe/model/user_info_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'week_data_provider.g.dart';

@riverpod
class WeekDataNotifier extends _$WeekDataNotifier {
  WeekDataNotifier() : super();

  @override
  ActivityResponse build() {
    return const ActivityResponse(
        totalTrash: 0,
        totalMiles: 0.0,
        totalHours: 0.0,
        challengeCompleted: 0,
        challengeGoal: 0,
        graphData: [],
        maxVal: 0,
        graphMaxVal: 0);
  }

  void setGraphData(List<GraphData> data) {
    state = state.copyWith(graphData: data);
  }

  void setMaxVal() {
    if (state.graphData.isEmpty) {
      throw FormatException('state.graphData not set yet');
    }
    final int maxVal = state.graphData
        .map((e) => e.trashCount)
        .toList()
        .reduce((curr, next) => curr > next ? curr : next);

    state = state.copyWith(maxVal: maxVal);
    setGraphMax();
  }

  void setGraphMax() {
    final int maxVal = state.maxVal!; // called after setMaxVal
    if (state.maxVal == 0) {
      state = state.copyWith(graphMaxVal: 0);
      return;
    }
    int graphMaxVal =
        (state.maxVal! % 5 == 0) ? maxVal + 5 : maxVal + (5 - (maxVal % 5));
    debugPrint('$graphMaxVal');
    if (graphMaxVal / 4.5 < maxVal) {
      debugPrint('$graphMaxVal, $maxVal');
      graphMaxVal += 5;
    }
    state = state.copyWith(graphMaxVal: graphMaxVal);
  }

  void setTotalTrashCount(int trash) {
    state = state.copyWith(totalTrash: trash);
  }

  void setTotalDistance(double dist) {
    state = state.copyWith(totalMiles: dist);
  }

  void setTotalDuration(double hour) {
    state = state.copyWith(totalHours: hour);
  }

  void setTotalChallengeCount(int totalChallenge) {
    state = state.copyWith(challengeGoal: totalChallenge);
  }

  void setVerifiedChallengeCount(int totalVerified) {
    state = state.copyWith(challengeCompleted: totalVerified);
  }

  void reset() {
    state = const ActivityResponse(
        totalTrash: 0,
        totalMiles: 0.0,
        totalHours: 0.0,
        challengeCompleted: 0,
        challengeGoal: 0,
        graphData: []);
  }
}
