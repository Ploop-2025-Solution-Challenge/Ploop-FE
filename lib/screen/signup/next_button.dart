import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NextPageButton extends StatelessWidget {
  final Widget route;

  const NextPageButton({
    super.key,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.black,
        padding: EdgeInsets.all(0.w),
        fixedSize: Size(160.w, 54.h),
      ),
      // if label == 'Continue': send user profile to server
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
      },
      clipBehavior: Clip.antiAlias,
      child: Text(
        'Next',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  final Widget route;

  const ContinueButton({
    super.key,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.black,
        padding: EdgeInsets.all(0.w),
        fixedSize: Size(160.w, 54.h),
      ),
      // if label == 'Continue': send user profile to server
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
        // TODO: send saved user info to server
      },
      clipBehavior: Clip.antiAlias,
      child: Text(
        'Continue',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
