import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateRangePicker extends StatefulWidget {
  final List<String> ranges;

  const DateRangePicker({
    super.key,
    required this.ranges,
  });

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  String? selectedOption; // for single select

  @override
  void initState() {
    super.initState();
    selectedOption = 'W';
  }

  void handleTap(String label) {
    print(label);
    setState(() {
      selectedOption = label;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.w),
        border: Border.all(
          width: 1.w,
          color: Color(0xFFC0C0C0),
        ),
      ),
      child: Row(
        spacing: 8.w,
        children: widget.ranges.map((label) {
          final isSelected = selectedOption == label;

          return DateRangeButton(
            label: label,
            isSelected: isSelected,
            onTap: () => handleTap(label),
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
    const selectedColor = Color(0xFF7EF18D);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 6.5.h),
        width: 86.w,
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
                color: isSelected ? Colors.black : const Color(0xFF7E7D7D),
              ),
        ),
      ),
    );
  }
}
