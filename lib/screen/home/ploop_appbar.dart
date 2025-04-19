import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_model.dart';
import '../../service/user_service.dart';

class PloopAppBar extends StatefulWidget {
  PloopAppBar({
    super.key,
  });

  @override
  State<PloopAppBar> createState() => _PloopAppBarState();
}

class _PloopAppBarState extends State<PloopAppBar> {
  final Image defaultProfilePic =
      Image.asset('assets/images/default-user-icon.png');
  late UserResponse userProfile =
      UserResponse(id: -1, nickname: '', role: '', profileImageUrl: null);

  Future<UserResponse?> _getUserProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');
    if (jwt != null) {
      final profile = await UserService.getUserProfile(jwt);
      if (profile != null) {
        setState(() {
          userProfile = profile;
        });
      }
    } else {
      print('error: jwt is null');
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  @override
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
          Row(
            spacing: 9.w,
            children: [
              CircleAvatar(
                backgroundImage:
                    const AssetImage('assets/images/default-user-icon.png'),
                foregroundImage: userProfile.profileImageUrl != null
                    ? NetworkImage(userProfile.profileImageUrl!)
                    : null,
                radius: 20.w,
              ),
              Text(
                // TODO: get saved nickname from server
                userProfile.nickname ?? 'User',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PloopTitleBar extends StatelessWidget {
  const PloopTitleBar({super.key});

  @override
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
        ],
      ),
    );
  }
}
