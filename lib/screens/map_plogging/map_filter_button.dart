import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                color: isActive ? Color(0xFF23BC37) : const Color(0xFFA1A1A1),
              ),
              borderRadius: BorderRadius.circular(30.w),
            ),
            shadows: [
              BoxShadow(
                color: const Color(0x3F000000),
                blurRadius: 2.w,
                offset: Offset(0.w, 2.h),
                spreadRadius: 0,
              )
            ],
            color: isActive ? Color(0xFFC0FFC8) : const Color(0xFFD2D2D2),
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
