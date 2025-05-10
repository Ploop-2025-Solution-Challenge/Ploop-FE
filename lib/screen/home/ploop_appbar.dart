import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ploop_fe/provider/jwt_provider.dart';
import 'package:ploop_fe/provider/user_info_provider.dart';

import '../../model/user_response.dart';
import '../../service/user_service.dart';

class PloopAppBar extends ConsumerStatefulWidget {
  const PloopAppBar({
    super.key,
  });

  @override
  ConsumerState<PloopAppBar> createState() => _PloopAppBarState();
}

class _PloopAppBarState extends ConsumerState<PloopAppBar> {
  final Image defaultProfilePic =
      Image.asset('assets/icons/default-user-icon.png');
  late UserResponse userProfile = UserResponse(
      id: -1,
      nickname: null,
      role: null,
      picture: null,
      email: '',
      age: null,
      gender: null,
      country: null,
      region: null);

  void _getUserProfile() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String? jwt = prefs.getString('jwt');

    final jwt = ref.read(jwtNotifierProvider).jwt;
    if (jwt != null) {
      final profile = await UserService.getUserProfile(jwt);
      if (profile != null) {
        setState(() {
          userProfile = profile;
          // set profile to provider state
          final profileProvider = ref.watch(userInfoNotifierProvider.notifier);
          profileProvider.setId(userProfile.id);
          if (userProfile.nickname != null) {
            profileProvider.setNickname(userProfile.nickname!);
          }
          if (userProfile.picture != null) {
            profileProvider.setPictureUrl(userProfile.picture!);
          }
        });
      }
    } else {
      debugPrint('error: jwt is null');
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: Platform.isAndroid
        ? '226017564204-qk2q8le5ttafdt4ai88tpuj1i46hno5r.apps.googleusercontent.com'
        : null,
    // scopes: scopes,
  );

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
                    const AssetImage('assets/icons/default-user-icon.png'),
                foregroundImage: userProfile.picture != null
                    ? NetworkImage(userProfile.picture!)
                    : null,
                radius: 20.w,
              ),
              Text(
                userProfile.nickname ?? 'Loading...',
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
