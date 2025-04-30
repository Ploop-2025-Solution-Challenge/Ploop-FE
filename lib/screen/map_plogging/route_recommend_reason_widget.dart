import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/model/route_model_test.dart';
import 'package:ploop_fe/screen/world/route_preview_static_map.dart';
import 'package:ploop_fe/theme.dart';

class RouteRecommendReasonWidget extends StatelessWidget {
  final VoidCallback onClosePressed;
  final RouteModel recommendedRoute;

  const RouteRecommendReasonWidget({
    super.key,
    required this.onClosePressed,
    required this.recommendedRoute,
  });

  @override
  Widget build(BuildContext context) {
    // preview window UI
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 215.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          color: GrayScale.transparentBlack,
        ),
        child: Column(
          spacing: 8.h,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 160.w),
                // close button
                GestureDetector(
                  onTap: onClosePressed,
                  child: Image.asset(
                    'assets/icons/close-route-icon.png',
                    width: 18.w,
                  ),
                ),
              ],
            ),
            Text(
                'Enjoy a refreshing walk surrounded by greenery and fresh air.',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: GrayScale.white)),
          ],
        ),
      ),
    );
  }
}
