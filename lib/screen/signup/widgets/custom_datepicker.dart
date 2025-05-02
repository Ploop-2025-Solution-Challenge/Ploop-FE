import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/theme.dart';

class UserBirthDatePicker extends StatelessWidget {
  const UserBirthDatePicker({
    super.key,
    required this.date,
    required this.onDateChanged,
  });

  final DateTime? date;
  final ValueChanged<DateTime> onDateChanged;

  void _showDialog(BuildContext context, Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216.h,
        padding: const EdgeInsets.only(top: 6.0),
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(top: false, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDialog(
        context,
        CupertinoDatePicker(
          maximumDate: DateTime.now(),
          dateOrder: DatePickerDateOrder.dmy,
          mode: CupertinoDatePickerMode.date,
          initialDateTime:
              date ?? DateTime.now().subtract(const Duration(seconds: 1)),
          onDateTimeChanged: onDateChanged,
        ),
      ),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        width: 370,
        height: 47,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: (date == null)
            ? Text(
                'DD / MM / YYYY',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: GrayScale.gray_300,
                    ),
              )
            : Text(
                '${date!.day} / ${date!.month} / ${date!.year}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: GrayScale.black,
                    ),
              ),
      ),
    );
  }
}
