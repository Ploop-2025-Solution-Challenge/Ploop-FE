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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24.h,
      children: [
        // date range
        Text(
          '${DateFormat('d. MM. y').format(startDate)} - ${DateFormat('d. MM. y').format(endDate)}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: GrayScale.gray_300,
              ),
        ),
        // collected trash amount
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.h,
          children: [
            Text(
              dataProvider.when(
                data: (activity) => '${activity.totalTrash}',
                loading: () => '0',
                error: (err, stack) => '0',
              ),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              'Trash collected',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: GrayScale.gray_300,
                  ),
            ),
          ],
        ),
        // records
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 32.w,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2.h,
              children: [
                Text(
                    dataProvider.when(
                      data: (activity) => '${activity.totalMiles}',
                      loading: () => '0.0',
                      error: (err, stack) => '0.0',
                    ),
                    style: Theme.of(context).textTheme.displaySmall),
                Text(
                  'Miles',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: GrayScale.gray_300,
                      ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2.h,
              children: [
                Text(
                    dataProvider.when(
                      data: (activity) => '${activity.totalMiles}',
                      loading: () => '0.0',
                      error: (err, stack) => '0.0',
                    ),
                    style: Theme.of(context).textTheme.displaySmall),
                Text(
                  'Hours',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: GrayScale.gray_300,
                      ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2.h,
              children: [
                Text(
                  dataProvider.when(
                    data: (activity) =>
                        '${activity.challengeCompleted}/${activity.challengeGoal}',
                    loading: () => '0/12',
                    error: (err, stack) => '0/144',
                  ),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  'Challenges Completed',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: GrayScale.gray_300,
                      ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
