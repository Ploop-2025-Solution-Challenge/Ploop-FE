import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const selectedColor = Color(0xFF000000);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2.w,
              color: isSelected ? selectedColor : const Color(0xFFA1A1A1),
            ),
            borderRadius: BorderRadius.circular(20.w),
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: isSelected ? selectedColor : const Color(0xFFA1A1A1),
              ),
        ),
      ),
    );
  }
}
