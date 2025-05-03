import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/model/activity_response.dart';
import 'package:ploop_fe/provider/month_data_provider.dart';
import 'package:ploop_fe/provider/week_data_provider.dart';
import 'package:ploop_fe/provider/year_data_provider.dart';
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

class RangeSelector {
  String mode = 'week';
  static List<Map<String, int>> data = [];

  static List<Map<String, int>> testWeekData = [
    {'Mon': 4},
    {'Tue': 6},
    {'Wed': 2},
    {'Thr': 14},
    {'Fri': 2},
    {'Sat': 6},
    {'Sun': 8}
  ];

  // static List<Map<String, int>> testWeekData = [
  //   {'Mon': 0},
  //   {'Tue': 0},
  //   {'Wed': 0},
  //   {'Thr': 0},
  //   {'Fri': 0},
  //   {'Sat': 0},
  //   {'Sun': 0}
  // ];
  static List<Map<String, int>> testMonthData = [
    {'1W': 40},
    {'2W': 60},
    {'3W': 21},
    {'4W': 120},
  ];

  static List<Map<String, int>> testYearData = [
    {'1': 40},
    {'2': 60},
    {'3': 21},
    {'4': 120},
    {'5': 21},
    {'6': 160},
    {'7': 80},
    {'8': 80},
    {'9': 80},
    {'10': 80},
    {'11': 80},
    {'12': 80},
  ];

  static List<Map<String, int>> setView(mode) {
    if (mode == 'W') {
      data = testWeekData;
    } else if (mode == 'M') {
      data = testMonthData;
    } else if (mode == 'Y') {
      data = testYearData;
    }

    return data;
  }
}

class GraphContainer extends ConsumerWidget {
  final String viewMode;

  const GraphContainer({super.key, required this.viewMode});

  double setWidth(int width, int spacing, int barCount) {
    // debugPrint("$width, $spacing, $barCount");
    return (width - spacing * (barCount - 1)) / barCount;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekDataProvider = ref.read(weekDataNotifierProvider);
    final monthDataProvider = ref.read(monthDataNotifierProvider);
    final yearDataProvider = ref.read(yearDataNotifierProvider);

    final viewData = RangeSelector.setView(viewMode);
    final singleBarWidth = setWidth(348, 16, viewData.length);
    final int maxVal = viewData
        .map((e) => e.values)
        .expand((e) => e)
        .toList()
        .reduce((curr, next) => curr > next ? curr : next);

    // final maxVal = weekDataProvider.maxVal ?? 0;

    final double maxHeight = 206.h; // 228 - text area 22

    int graphMaxVal = maxVal % 5 == 0 ? maxVal : maxVal + (5 - (maxVal % 5));
    // debugPrint(constraints.toString());

    return Container(
      // color: Colors.green,
      width: 348.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        spacing: 16.w,
        children: [
          ...viewData.map(
            (e) {
              String day = e.keys.first;
              int value = e[day]!;
              debugPrint(
                  '${e.values} / $graphMaxVal * $maxHeight = ${value / graphMaxVal * maxHeight}');

              final double barHeight =
                  maxVal != 0 ? value / graphMaxVal * maxHeight : 0;
              debugPrint('$barHeight');
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
  }
}

class GraphField extends ConsumerStatefulWidget {
  final String viewMode;
  final (DateTime, DateTime) dateRange;
  // final List<int> lineLabels;

  GraphField({
    super.key,
    required this.dateRange,
    required this.viewMode,
    // required this.lineLabels
  });

  @override
  ConsumerState<GraphField> createState() => _GraphFieldState();
}

class _GraphFieldState extends ConsumerState<GraphField> {
  List<String> lineLabels = ['', '', '', '', '', ''];

  void initState() {}

  @override
  Widget build(BuildContext context) {
    final viewData = RangeSelector.setView(widget.viewMode);
    // TEST
    final weekDataNotifier = ref.watch(weekDataNotifierProvider.notifier);
    final monthDataNotifier = ref.watch(monthDataNotifierProvider.notifier);
    final yearDataNotifier = ref.watch(yearDataNotifierProvider.notifier);

    List<int> values = viewData.map((e) => e.values).expand((e) => e).toList();
    debugPrint(values.toString());

    // initialized
    int maxVal = (values.reduce(
        (curr, next) => curr > next ? curr : next)); // max value of data

    if (maxVal == 0) {
      setState(() {
        lineLabels = ['10', '8', '6', '4', '2', '0'];
      });
    } else {
      int graphMaxVal = maxVal % 5 == 0 ? maxVal : maxVal + (5 - (maxVal % 5));
      debugPrint('maxHeight: $graphMaxVal, max: $maxVal');

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

    return Container(
      // color: Colors.yellow,
      // padding: EdgeInsets.only(top: 18.h),
      // width: 370.w,
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
                bottom: 18.h,
                child: Container(
                  // color: const Color.fromRGBO(255, 172, 64, 0.311),
                  width: 348.w,
                  height: 228.h,
                  child: GraphContainer(viewMode: widget.viewMode),
                ),
              ),
            ],
          ),
          // DateRangeUnit(dateRange: dateRange),
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

// TODO; seperate days by given range
class DateRangeUnit extends StatelessWidget {
  final (DateTime, DateTime) dateRange;
  const DateRangeUnit({super.key, required this.dateRange});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 36.w,
      children: [
        Text('${dateRange.$2.difference(dateRange.$1).inDays + 1}'),
      ],
    );
  }
}
