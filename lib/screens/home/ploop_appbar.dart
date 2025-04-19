import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PloopAppBar extends StatefulWidget {
  PloopAppBar({super.key, required this.showUserInfo});

  bool showUserInfo = true;

  @override
  State<PloopAppBar> createState() => _PloopAppBarState();
}

class _PloopAppBarState extends State<PloopAppBar> {
  late bool _showUserInfo;
  @override
  void initState() {
    super.initState();
    _showUserInfo = widget.showUserInfo;
  }

  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
      width: MediaQuery.of(context).size.width,
      // height: 90.h,
      padding: EdgeInsets.fromLTRB(16.0.h, 10.0.h, 8.0.h, 8.0.h),
      child: Column(
        spacing: 24.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            style: TextStyle(
                fontFamily: 'PartialSansKR',
                fontSize: 15.sp,
                height: 0.5,
                letterSpacing: 0.015.sp,
                color: Colors.black),
            child: const Text('Ploop'),
          ),
          // profile area
          if (_showUserInfo)
            Row(
              spacing: 9.w,
              children: [
                // TODO: Remove const when connecting real profile info
                CircleAvatar(
                  // backgroundColor: Colors.green,
                  radius: 20.w,
                ),
                Text(
                  'Ethan',
                  style: Theme.of(context).textTheme.labelMedium,
                  // TODO: Remove const when connecting real profile info
                ),
              ],
            ),
        ],
      ),
    );
  }
}
