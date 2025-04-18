import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StopPloggingButton extends StatelessWidget {
  final Function()? onPressed;

  const StopPloggingButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0.w),
      ),
      child: Container(
        // width: 142.w,
        // height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 20.5.w, vertical: 10.h),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Color(0xFFFF5F5F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.w),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Text(
              'Stop Plogging',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    letterSpacing: 0.06,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
