import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    ;
  }
}

class RangeSelector {
  String mode = 'week';
  static List<Map<String, double>> data = [];

  static List<Map<String, double>> testWeekData = [
    {'Mon': 40},
    {'Tue': 60},
    {'Wed': 21},
    {'Thr': 120},
    {'Fri': 21},
    {'Sat': 160},
    {'Sun': 80}
  ];
  static List<Map<String, double>> testMonthData = [
    {'1W': 40},
    {'2W': 60},
    {'3W': 21},
    {'4W': 120},
  ];
  static List<Map<String, double>> testQuarterData = [
    {'1M': 40},
    {'2M': 60},
    {'3M': 21},
  ];
  static List<Map<String, double>> testYearData = [
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

  static List<Map<String, double>> setView(mode) {
    if (mode == 'W') {
      data = testWeekData;
    } else if (mode == 'M') {
      data = testMonthData;
    } else if (mode == '3M') {
      data = testQuarterData;
    } else if (mode == 'Y') {
      data = testYearData;
    }

    return data;
  }
}

class GraphContainer extends StatelessWidget {
  final String viewMode;

  const GraphContainer({super.key, required this.viewMode});

  double setWidth(int width, int spacing, int barCount) {
    debugPrint("$width, $spacing, $barCount");
    return (width - spacing * (barCount - 1)) / barCount;
  }

  @override
  Widget build(BuildContext context) {
    final viewData = RangeSelector.setView(viewMode);
    final singleBarWidth = setWidth(348, 16, viewData.length);

    return Container(
      // color: Colors.green,
      width: 348.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 16.w,
        children: [
          ...viewData.map(
            (e) {
              String day = e.keys.first;
              double value = e[day]!;
              return Column(
                spacing: 4.h,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: singleBarWidth,
                    height: value,
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

class GraphField extends StatelessWidget {
  final String viewMode;
  final (DateTime, DateTime) dateRange;

  const GraphField(
      {super.key, required this.dateRange, required this.viewMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.yellow,
      padding: EdgeInsets.only(top: 8.h),
      // width: 370.w,
      height: 260.h,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Column(
                spacing: 40.h,
                children: const [
                  GraphLine(),
                  GraphLine(),
                  GraphLine(),
                  GraphLine(),
                  GraphLine(),
                  GraphLine(),
                  SizedBox(),
                ],
              ),
              Positioned(
                bottom: 18.h,
                child: SizedBox(
                  // color: Colors.orangeAccent,
                  width: 348.w,
                  height: 200.h,
                  child: GraphContainer(viewMode: viewMode),
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
  const GraphLine({super.key});

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
          '800',
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
