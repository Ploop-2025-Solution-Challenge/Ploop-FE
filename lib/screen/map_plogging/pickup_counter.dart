import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickupCounter extends StatefulWidget {
  const PickupCounter({super.key});

  @override
  State<StatefulWidget> createState() => _PickUpCounterState();
}

class _PickUpCounterState extends State<PickupCounter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      debugPrint('+');
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      if (_counter == 0) return;
      debugPrint('-');
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 36.w,
      children: [
        // button
        CounterButton(
          label: '-',
          onPressed: _decrement,
        ),
        Text(
          '$_counter',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        CounterButton(
          label: '+',
          onPressed: _increment,
        ),
      ],
    );
  }
}

// TODO: refactor with notifier provider, consumer widget
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
          color: Color(0x7FD9D9D9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.w),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: const Color(0xFFA1A1A1),
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
