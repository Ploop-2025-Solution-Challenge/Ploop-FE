import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ploop_fe/theme.dart';

class GraphField extends StatelessWidget {
  final (DateTime, DateTime) dateRange;

  const GraphField({super.key, required this.dateRange});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      padding: EdgeInsets.only(top: 8.h),
      width: 370.w,
      height: 266.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          DateRangeUnit(dateRange: dateRange),
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
