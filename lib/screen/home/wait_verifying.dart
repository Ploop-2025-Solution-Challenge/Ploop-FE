import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ploop_fe/provider/country_list_provider.dart';
import 'package:ploop_fe/provider/jwt_provider.dart';
import 'package:ploop_fe/screen/signup/set_country.dart';
import 'package:ploop_fe/service/verify_service.dart';
import 'package:ploop_fe/theme.dart';

class VerifyingScreen extends ConsumerWidget {
  final String imagePath;
  final int id;

  const VerifyingScreen({super.key, required this.imagePath, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final jwt = ref.read(jwtNotifierProvider).jwt;

      if (jwt != null) {
        final image = XFile(imagePath);
        final result = await VerifyService.postVerification(id, jwt, image);
        debugPrint('**Result: $result');
        if (context.mounted) {
          Navigator.pop(context, result);
        }
      } else {
        if (context.mounted) {
          Navigator.pop(context, false);
        }
      }
    });

    return PopScope(
      canPop: false,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: GrayScale.black,
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 24.h,
              children: [
                SizedBox(
                  width: 85.w,
                  height: 85.h,
                  child: CupertinoActivityIndicator(
                    color: GrayScale.white,
                    radius: 42.5.w,
                  ),
                ),
                Text(
                  'Verifying in progress...',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: GrayScale.white),
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
