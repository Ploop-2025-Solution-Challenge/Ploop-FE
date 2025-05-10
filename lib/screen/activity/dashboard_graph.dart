import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/model/activity_filter.dart';
import 'package:ploop_fe/provider/activity_filter_provider.dart';
import 'package:ploop_fe/provider/activity_data_provider.dart';
import 'package:ploop_fe/theme.dart';

class SingleBar {
  static Widget makeBar(
      double x, double y, String? label, TextStyle? labelStyle) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme().color_600,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.w),
              topRight: Radius.circular(5.w),
            ),
          ),
          width: x,
          height: y,
        ),
        Text(label ?? '', style: labelStyle),
      ],
    );
  }
}

class GraphContainer extends ConsumerWidget {
  final Range viewMode;
  final int maxVal;

  const GraphContainer(
      {super.key, required this.viewMode, required this.maxVal});

  double setWidth(int width, int spacing, int barCount) {
    // debugPrint("$width, $spacing, $barCount");
    return (width - spacing * (barCount - 1)) / barCount;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(activityFilterNotifierProvider).range;
    final startDate = ref.watch(activityFilterNotifierProvider).startDate;
    final endDate = ref.watch(activityFilterNotifierProvider).endDate;
    final dataProvider =
        ref.watch(activityDataProvider(range, startDate, endDate));

    return dataProvider.when(
      data: (activity) {
        final singleBarWidth = setWidth(326, 16, activity.graphData.length);

        final double maxHeight = 206.h; // 228 - text area 22

        int graphMaxVal =
            maxVal % 5 == 0 ? maxVal : maxVal + (5 - (maxVal % 5));

        return SizedBox(
          // color: Colors.green,
          width: 326.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            spacing: 16.w,
            children: [
              ...activity.graphData.map(
                (e) {
                  String day = e.label;
                  int value = e.trashCount;

                  final double barHeight =
                      maxVal != 0 ? value / graphMaxVal * maxHeight : 0;
                  return Column(
                    spacing: 4.h,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: singleBarWidth,
                        height: barHeight,
                        decoration: BoxDecoration(
                          color: theme().color_600,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.w),
                            topRight: Radius.circular(5.w),
                          ),
                        ),
                      ),
                      Text(
                        day,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
      loading: () => Container(),
      error: (err, stack) => Text('error'),
    );
  }
}

class GraphField extends ConsumerStatefulWidget {
  final Range viewMode;
  final (DateTime, DateTime) dateRange;

  const GraphField({
    super.key,
    required this.dateRange,
    required this.viewMode,
  });

  @override
  ConsumerState<GraphField> createState() => _GraphFieldState();
}

class _GraphFieldState extends ConsumerState<GraphField> {
  List<String> lineLabels = ['', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    final range = ref.watch(activityFilterNotifierProvider).range;

    final startDate = ref.watch(activityFilterNotifierProvider).startDate;
    final endDate = ref.watch(activityFilterNotifierProvider).endDate;

    final dataProvider =
        ref.watch(activityDataProvider(range, startDate, endDate));

    final values = dataProvider
            .whenData(
              (e) => e.graphData.map((g) => g.trashCount).toList(),
            )
            .value ??
        [];

    // debugPrint(values.toString());

    // initialized
    int maxVal = 0;
    if (values.isNotEmpty) {
      maxVal = values.reduce((curr, next) => curr > next ? curr : next);
      debugPrint('max: $maxVal');
    }

    if (maxVal == 0) {
      setState(() {
        lineLabels = ['10', '8', '6', '4', '2', '0'];
      });
    } else {
      int graphMaxVal = maxVal % 5 == 0 ? maxVal : maxVal + (5 - (maxVal % 5));

      final double valueGap = graphMaxVal / 5;
      lineLabels = List.generate(6, (i) {
        return ((graphMaxVal - valueGap * i) < 0
                ? 0
                : graphMaxVal - valueGap * i)
            .round()
            .toString();
      });
    }
    // adjust

    return SizedBox(
      height: 270.h,
      child: Column(
        children: [
          Container(
            height: 18.h,
          ),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomLeft,
            children: [
              Column(
                spacing: 40.h,
                children: [
                  ...lineLabels.map((e) => GraphLine(
                        lineLabel: e,
                      )),
                  const SizedBox(), // extra gap
                ],
              ),
              Positioned(
                bottom: 20.h,
                child: SizedBox(
                  width: 348.w,
                  height: 228.h,
                  child:
                      GraphContainer(viewMode: widget.viewMode, maxVal: maxVal),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GraphLine extends StatelessWidget {
  final String lineLabel;
  const GraphLine({super.key, required this.lineLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 3.w,
      children: [
        DottedLine(
          lineLength: 348.w,
          dashLength: 2.0.w,
          dashGapLength: 2.0.w,
          dashColor: GrayScale.gray_200,
        ),
        Text(
          lineLabel,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(height: 0.01, color: GrayScale.gray_200),
        ),
      ],
    );
  }
}
