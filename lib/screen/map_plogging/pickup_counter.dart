import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/theme.dart';

class PickupCounter extends StatelessWidget {
  final int amount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const PickupCounter({
    super.key,
    required this.amount,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 36.w,
      mainAxisSize: MainAxisSize.min,
      children: [
        CounterButton(
          label: '-',
          onPressed: onDecrement,
        ),
        Text(
          '$amount',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        CounterButton(
          label: '+',
          onPressed: onIncrement,
        ),
      ],
    );
  }
}

class CounterButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;

  const CounterButton(
      {super.key, required this.label, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.topCenter,
        width: 56.w,
        height: 56.h,
        decoration: ShapeDecoration(
          color: const Color(0x7FD9D9D9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.w),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: GrayScale.gray_300,
            // backgroundColor: Colors.blue,
            fontFamily: 'Pretendard',
            fontSize: 64.sp,
            height: 0.75,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.64,
          ),
        ),
      ),
    );
  }
}
