import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:ploop_fe/theme.dart';

class RouteRecommendReasonWidget extends StatelessWidget {
  final VoidCallback onClosePressed;
  final List<LatLng> recommendedRoute;
  final String motivation;

  const RouteRecommendReasonWidget({
    super.key,
    required this.onClosePressed,
    required this.recommendedRoute,
    required this.motivation,
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
            DefaultTextStyle(
              style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: GrayScale.white) ??
                  const TextStyle(color: GrayScale.white),
              child: AnimatedTextKit(
                repeatForever: false,
                totalRepeatCount: 1,
                animatedTexts: [
                  TyperAnimatedText(
                    motivation != ""
                        ? motivation
                        : 'Recommendation is not available right now.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
