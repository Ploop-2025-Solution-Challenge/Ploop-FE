import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/theme.dart';

class VerifySuccess extends StatelessWidget {
  const VerifySuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GrayScale.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 24.h,
          children: [
            Image.asset('assets/icons/verify-success-3x.png', width: 82.w),
            Text('Challenge Completed',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: GrayScale.white)),
          ],
        ),
      ),
    );
  }
}

class VerifyFailed extends StatelessWidget {
  const VerifyFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GrayScale.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 24.h,
          children: [
            Image.asset('assets/icons/verify-failed-3x.png', width: 82.w),
            Text('Challenge Failed',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: GrayScale.white)),
          ],
        ),
      ),
    );
  }
}
