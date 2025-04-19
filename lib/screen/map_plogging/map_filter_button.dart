import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/theme.dart';

class MapFilterButton extends StatefulWidget {
  const MapFilterButton({super.key, required this.label});

  final String label;

  @override
  State<StatefulWidget> createState() => MapFilterState();
}

class MapFilterState extends State<MapFilterButton> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => {
        setState(() {
          isActive = !isActive;
        }),
      },
      style:
          TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 0.w)),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(minWidth: 66.w, minHeight: 38.h, maxHeight: 42.h),
        child: Container(
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.w,
                color: isActive ? theme().color_500 : GrayScale.gray_300,
              ),
              borderRadius: BorderRadius.circular(30.w),
            ),
            shadows: [
              BoxShadow(
                color: GrayScale.shadowColor,
                blurRadius: 2.w,
                offset: Offset(0.w, 2.h),
                spreadRadius: 0,
              )
            ],
            color: isActive ? theme().color_400 : GrayScale.gray_100,
          ),
          padding: EdgeInsets.symmetric(vertical: 12.5.h, horizontal: 16.w),
          child: Text(
            widget.label,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
