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
    List<List<double>> convertedRoute =
        route.map((e) => [e.latitude, e.longitude]).toList();

    if (convertedRoute.isNotEmpty) {
      state = state.copyWith(activityRoute: convertedRoute);
    }
  }

  void setTimeDuration(String duration) {
    state = state.copyWith(timeDuration: duration);
  }

  void setUpdatedTime() {
    // need formatting
    final formattedNow = DateTime.now().toIso8601String();
    // "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}T${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}";
    state = state.copyWith(updatedDateTime: formattedNow);
  }

  void setUserId(int id) {
    if (id != -1) {
      state = state.copyWith(userId: id.toString());
    } else {
      state = state.copyWith(userId: 'test');
    }
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
