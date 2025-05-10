import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/theme.dart';

class StartPloggingButton extends StatelessWidget {
  final Function()? onPressed;

  const StartPloggingButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Colors.black,
        padding: EdgeInsets.all(0.w),
      ),
      child: Container(
        width: 168.w,
        height: 48.h,
        // padding: EdgeInsets.symmetric(horizontal: 26.5.w, vertical: 12.h),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.w),
          ),
          shadows: [
            BoxShadow(
              color: GrayScale.shadowColor,
              blurRadius: 2.h,
              offset: Offset(0, 2.h),
              spreadRadius: 0,
            )
          ],
        ),
        child: Center(
          child: Text(
            'Start Plogging',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: theme().color_600,
                  letterSpacing: 0.06,
                ),
          ),
        ),
      ),
    );
  }
}
