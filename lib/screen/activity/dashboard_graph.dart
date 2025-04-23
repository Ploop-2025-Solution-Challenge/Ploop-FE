import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/theme.dart';

class SingleBar {
  static Widget makeBar(
      double x, double y, String? label, TextStyle? labelStyle) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
      ),
    );
  }
}

class GraphContainer extends StatelessWidget {
  const GraphContainer({super.key});

  double setWidth(int width, int spacing, int barCount) {
    return width - spacing * (barCount - 1);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, double>> testData = [
      {'Mon': 40},
      {'Tue': 60},
      {'Wed': 21},
      {'Thr': 120},
      {'Fri': 21},
      {'Sat': 160},
      {'Sun': 80}
    ];
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16.w,
        children: [
          ...testData.map(
            (e) {
              String day = e.keys.first;
              double value = e[day]!;
              return SingleBar.makeBar(
                  setWidth(348, 16, testData.length),
                  value,
                  day,
                  Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w600));
            },
          ),
        ],
      ),
    );
  }
}

class GraphField extends StatelessWidget {
  final (DateTime, DateTime) dateRange;

  const GraphField({super.key, required this.dateRange});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      padding: EdgeInsets.only(top: 8.h),
      width: 370.w,
      height: 226.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  color: Colors.orangeAccent,
                  width: 348.w,
                  height: 200.h,
                  child:

                      // child: BarChart(
                      //   BarChartData(
                      //     maxY: 160.h,
                      //     minY: 0,
                      //     gridData:
                      //         FlGridData(show: true, horizontalInterval: 200.h / 5),
                      //     titlesData: FlTitlesData(
                      //       show: false,
                      //     ),
                      //     barGroups: test.barData
                      //         .map(
                      //           (data) => BarChartGroupData(
                      //             x: data.x,
                      //             barRods: [
                      //               BarChartRodData(
                      //                 toY: data.y,
                      //                 color: theme().color_600,
                      //                 width: 36.w,
                      //                 borderRadius: BorderRadius.only(
                      //                   topLeft: Radius.circular(5.w),
                      //                   topRight: Radius.circular(5.w),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         )
                      //         .toList(),
                      //   ),
                      // ),
                      GraphContainer(),
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
      children: [
        DottedLine(
          lineLength: 348.w,
          dashLength: 2.0.w,
          dashGapLength: 2.0.w,
          dashColor: GrayScale.gray_200,
        ),
        Text(
          '800',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(height: 0.01),
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
