import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ploop_fe/model/activity_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'plogging_provider.g.dart';

@Riverpod(keepAlive: true)
class PloggingActivityNotifier extends _$PloggingActivityNotifier {
  PloggingActivityNotifier() : super();

  @override
  ActivityRequest build() {
    return const ActivityRequest(
        userId: '',
        activityRoute: [],
        timeDuration: '',
        updatedDateTime: '',
        distanceMiles: 0.0,
        trashCollectedCount: 0);
  }

  void setRoute(List<LatLng> route) {
    List<(double, double)> convertedRoute = [];
    route.map((e) => convertedRoute.add((e.latitude, e.longitude)));
    if (convertedRoute != []) {
      state = state.copyWith(activityRoute: convertedRoute);
    }
  }

  void setTimeDuration(String duration) {
    state = state.copyWith(timeDuration: duration);
  }

  void setUpdatedTime() {
    // need formatting
    state = state.copyWith(updatedDateTime: DateTime.now().toString());
  }

  void setUserId(String id) {
    state = state.copyWith(userId: id);
  }

  void setCollectedCount(int count) {
    state = state.copyWith(trashCollectedCount: count);
  }

  void setDistance(double miles) {
    state = state.copyWith(distanceMiles: miles);
  }

  void reset() {
    state = const ActivityRequest(
        userId: '',
        activityRoute: [],
        timeDuration: '',
        updatedDateTime: '',
        distanceMiles: 0.0,
        trashCollectedCount: 0);
  }
}
