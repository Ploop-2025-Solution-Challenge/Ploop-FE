import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NextPageButton extends StatelessWidget {
  final String label;
  final Widget route;

  const NextPageButton({
    super.key,
    this.label = 'label',
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
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
      },
      clipBehavior: Clip.antiAlias,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
