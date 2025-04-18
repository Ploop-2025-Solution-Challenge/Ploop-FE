import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class GraphField extends StatelessWidget {
  final (DateTime, DateTime) dateRange;

  const GraphField({super.key, required this.dateRange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.h),
      width: 370.w,
      height: 226.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 40.h,
        children: [
          GraphLine(),
          GraphLine(),
          GraphLine(),
          GraphLine(),
          GraphLine(),
          GraphLine(),
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
    return DottedLine(
      lineLength: 348.w,
      dashLength: 2.0.w,
      dashGapLength: 2.0.w,
      dashColor: Color(0xFFC0C0C0),
    );
  }
}

// TODO; seperate days by given range
class DateRangeUnit extends StatelessWidget {
  const DateRangeUnit({super.key, required (DateTime, DateTime) dateRange});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        spacing: 36.w,
        children: [
          Text('${DateFormat('E')}'),
        ],
      ),
    );
  }
}
