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
          iconUrl: 'assets/icons/counter-minus.png',
          onPressed: onDecrement,
          iconWidth: 20.w,
        ),
        Text(
          '$amount',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        CounterButton(
          iconUrl: 'assets/icons/counter-plus.png',
          onPressed: onIncrement,
          iconWidth: 29.w,
        ),
      ],
    );
  }
}

class CounterButton extends StatelessWidget {
  final void Function()? onPressed;
  final String iconUrl;
  final double iconWidth;

  const CounterButton(
      {super.key,
      required this.iconUrl,
      required this.onPressed,
      required this.iconWidth});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: 56.w,
        height: 56.h,
        decoration: ShapeDecoration(
          color: const Color(0x7FD9D9D9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.w),
          ),
        ),
        child: Image.asset(
          iconUrl,
          width: iconWidth,
        ),
      ),
    );
  }
}
