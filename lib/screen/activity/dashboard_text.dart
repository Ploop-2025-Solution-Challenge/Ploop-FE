import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ploop_fe/model/activity_response.dart';
import 'package:ploop_fe/provider/activity_filter_provider.dart';
import 'package:ploop_fe/provider/activity_data_provider.dart';
import 'package:ploop_fe/theme.dart';

class DashboardTextWidget extends ConsumerWidget {
  // now, now + range
  final (DateTime, DateTime) dateRange;

  const DashboardTextWidget({super.key, required this.dateRange});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(activityFilterNotifierProvider).range;
    final startDate = ref.watch(activityFilterNotifierProvider).startDate;
    final endDate = ref.watch(activityFilterNotifierProvider).endDate;
    final dataProvider =
        ref.watch(activityDataProvider(range, startDate, endDate));

    return dataProvider.when(
      data: (activity) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24.h,
          children: [
            _buildDateRange(context, startDate, endDate),
            _buildTrashCollected(context, activity),
            _buildRecords(context, activity),
          ],
        );
      },
      loading: () => const Text('Loading...'),
      error: (err, stack) => Text('error: $err'),
    );
  }

  Widget _buildDateRange(
      BuildContext context, DateTime startDate, DateTime endDate) {
    return Text(
      '${DateFormat('d. MM. y').format(startDate)} - ${DateFormat('d. MM. y').format(endDate)}',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: GrayScale.gray_300,
          ),
    );
  }

  Widget _buildTrashCollected(BuildContext context, ActivityResponse activity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Text(
          '${activity.totalTrash}',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Text(
          'Trash collected',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: GrayScale.gray_300,
              ),
        ),
      ],
    );
  }

  Widget _buildRecords(BuildContext context, ActivityResponse activity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 32.w,
      children: [
        _buildRecordColumn(context, 'Miles', '${activity.totalMiles}'),
        _buildRecordColumn(context, 'Hours', '${activity.totalHours}'),
        _buildRecordColumn(context, 'Challenges Completed',
            '${activity.challengeCompleted}/${activity.challengeGoal}'),
      ],
    );
  }

  Widget _buildRecordColumn(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2.h,
      children: [
        Text(value, style: Theme.of(context).textTheme.displaySmall),
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: GrayScale.gray_300,
              ),
        ),
      ],
    );
  }
}
