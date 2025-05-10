import 'package:ploop_fe/model/activity_filter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity_filter_provider.g.dart';

@riverpod
class ActivityFilterNotifier extends _$ActivityFilterNotifier {
  @override
  ActivityFilter build() {
    final now = DateTime.now();
    return ActivityFilter(
      range: Range.W,
      startDate: DateTime.now().subtract(Duration(days: now.weekday % 7)),
      endDate: DateTime.now().add(Duration(days: 7 - (now.weekday % 7))),
    );
  }

  void update(Range newRange) {
    final now = DateTime.now();
    DateTime start, end;

    switch (newRange) {
      case Range.W:
        start = now.subtract(Duration(days: now.weekday % 7));
        end = start.add(const Duration(days: 6));
        break;
      case Range.M:
        start = DateTime(now.year, now.month, 1);
        end = DateTime(now.year, now.month + 1, 0);
        break;
      case Range.Y:
        start = DateTime(now.year, 1, 1);
        end = DateTime(now.year, 12, 31);
        break;
      // default:
      //   start = DateTime.now();
      //   end = DateTime.now();
    }

    state = ActivityFilter(
      range: newRange,
      startDate: start,
      endDate: end,
    );
  }
}
