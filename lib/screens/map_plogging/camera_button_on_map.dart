import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 44.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.w),
        boxShadow: [
          BoxShadow(
            color: const Color(0x3F000000),
            blurRadius: 4.w,
            offset: Offset(0, 4.h),
            spreadRadius: 0,
          )
        ],
        color: Colors.black,
      ),
      child: IconButton(
        onPressed: (() {}),
        iconSize: 44.w,
        icon: Image.asset(
          'assets/images/camera-icon.png',
          width: 20.w,
        ),
      ),
    );
  }
}
