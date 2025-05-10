import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/model/activity_filter.dart';
import 'package:ploop_fe/theme.dart';

class DateRangePicker extends StatelessWidget {
  final List<Range> ranges;
  final Range selected;
  final ValueChanged<Range> onChanged;

  const DateRangePicker({
    super.key,
    required this.ranges,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.w),
        border: Border.all(
          width: 1.w,
          color: GrayScale.gray_200,
        ),
      ),
      child: Row(
        spacing: 8.w,
        children: ranges.map((label) {
          final isSelected = selected == label;

          return Expanded(
            child: DateRangeButton(
              label: label.name,
              isSelected: isSelected,
              onTap: () => onChanged(label),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class DateRangeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const DateRangeButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color selectedColor = theme().color_600;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 6.5.h),
        // width: 86.w,
        decoration: ShapeDecoration(
          color: isSelected ? selectedColor : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.w),
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? GrayScale.black : GrayScale.gray_500,
              ),
        ),
      ),
    );
  }
}
