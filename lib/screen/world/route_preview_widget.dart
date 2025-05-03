import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/model/route_model_test.dart';
import 'package:ploop_fe/screen/world/route_preview_static_map.dart';
import 'package:ploop_fe/theme.dart';

class RoutePreviewWidget extends StatelessWidget {
  final RouteModel selectedRouteModel;
  final VoidCallback onClosePressed;
  final VoidCallback onRoutePressed;
  const RoutePreviewWidget({
    super.key,
    required this.selectedRouteModel,
    required this.onClosePressed,
    required this.onRoutePressed,
  });

  @override
  Widget build(BuildContext context) {
    // preview window UI
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        color: GrayScale.black,
      ),
      child: Column(
        spacing: 8.h,
        mainAxisSize: MainAxisSize.min,
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

          Container(
            // additional padding
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.w),

              // route preview image
              child: SizedBox(
                width: 178.w,
                height: 157.h,
                child: RoutePreviewStaticMap(
                    routeModel: selectedRouteModel), // ***
              ),
            ),
          ),

          // createAt attr
          Text(
            'Updated ${selectedRouteModel.fUpdateDateTime()}',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600, color: GrayScale.gray_100),
          ),

          // Show route on map
          Container(
            width: 178.w,
            height: 28.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.w),
              color: theme().color_600,
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                elevation: 0,
                splashFactory: NoSplash.splashFactory,
              ),
              onPressed:
                  onRoutePressed, // TODO: connect to drawpolyline, zoom in by zoomByBound attribute
              child: Text(
                "Route",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
