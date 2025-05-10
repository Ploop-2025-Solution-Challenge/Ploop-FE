import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ploop_fe/model/mission.dart';
import 'package:ploop_fe/model/mission_response.dart';
import 'package:ploop_fe/provider/jwt_provider.dart';
import 'package:ploop_fe/provider/mission_provider.dart';
import 'package:ploop_fe/provider/user_info_provider.dart';
import 'package:ploop_fe/screen/home/verify_result.dart';
import 'package:ploop_fe/screen/home/wait_verifying.dart';
import 'package:ploop_fe/screen/onboarding/waiting.dart';
import 'package:ploop_fe/service/verify_service.dart';
import 'package:ploop_fe/theme.dart';

class ChallengeProgressCard extends ConsumerWidget {
  const ChallengeProgressCard({super.key});

  // multiply this factor to colored width of graph
  // final int totalChallengeCount = 3;
  // final int myProgress = 1;
  // final int otherProgress = 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myProfile = ref.watch(userInfoNotifierProvider);
    final AsyncValue<MissionResponse> missionsAsync =
        ref.watch(missionDataProvider);

    return missionsAsync.when(data: (missionResponse) {
      final int totalChallengeCount = missionResponse.myMissions.length +
          missionResponse.partnerMissions.length;

      final int myProgress = missionResponse.myMissions
          .where((mission) => mission.verified)
          .length;
      final int partnerProgress = missionResponse.partnerMissions
          .where((mission) => mission.verified)
          .length;

      final double totalPercentage =
          (myProgress + partnerProgress) / totalChallengeCount;
      return Container(
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black,
        ),
        padding: EdgeInsets.fromLTRB(15.w, 14.h, 15.w, 16.h),
        width: 370.w,
        height: 214.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  '${(totalPercentage * 100).round()}%',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 22.sp,
                        height: 1.27,
                        letterSpacing: -0.26,
                        color: Colors.white,
                      ),
                ),

                // graph
                Stack(
                  children: [
                    // background
                    Container(
                      decoration: BoxDecoration(
                          color: GrayScale.gray_500,
                          borderRadius: BorderRadius.circular(5.w)),
                      width: 340.w,
                      height: 24.h,
                    ),
                    Container(
                      width: 340.w * totalPercentage,
                      height: 24.h,
                      decoration: BoxDecoration(
                          color: theme().color_600,
                          borderRadius: (totalPercentage == 1.00
                              ? BorderRadius.all(Radius.circular(5.w))
                              : BorderRadius.only(
                                  topLeft: Radius.circular(5.w),
                                  bottomLeft: Radius.circular(5.w)))),
                    )
                  ],
                ),
              ],
            ),

            // progress percentage
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  'Your challenge partners',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
                Text(
                  'You and ${missionResponse.partnerName} are in a challenge together',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: GrayScale.gray_400),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  spacing: 8.w,
                  children: [
                    ChallengeUserCard(
                      username: myProfile.nickname!,
                      verifiedChallengeCount: myProgress,
                      totalChallengeCount: totalChallengeCount,
                      profileImageUrl: myProfile.pictureUrl!,
                    ),
                    ChallengeUserCard(
                      username: missionResponse.partnerName,
                      verifiedChallengeCount: partnerProgress,
                      totalChallengeCount: totalChallengeCount,
                      profileImageUrl: missionResponse.partnerImageUrl,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }, error: (error, stackTrace) {
      return SizedBox(
        height: 388.h,
        child: Image.asset(
          'assets/images/mission_error.png',
          width: 370.w,
          height: 388.h,
        ),
      );
    }, loading: () {
      return SizedBox(
        height: 388.h,
        child: Image.asset(
          'assets/images/mission_loading.png',
          width: 370.w,
          height: 388.h,
        ),
      );
    });
  }
}

class ChallengeUserCard extends StatelessWidget {
  const ChallengeUserCard(
      {super.key,
      required this.username,
      required this.verifiedChallengeCount,
      required this.totalChallengeCount,
      required this.profileImageUrl});

  // get data with user id?
  final String username;
  final int totalChallengeCount;
  final int verifiedChallengeCount;
  final String profileImageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h),
      // alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.w)),
          color: Colors.white),
      width: 166.w,
      height: 57.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // spacing: 24.w,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8.w,
            children: [
              CircleAvatar(
                backgroundImage:
                    const AssetImage('assets/icons/default-user-icon.png'),
                foregroundImage: NetworkImage(profileImageUrl),
                radius: 20.w,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 56.w),
                child: Text(
                  textWidthBasis: TextWidthBasis.parent,
                  // softWrap: true,
                  username,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            ],
          ),
          Text(
            '$verifiedChallengeCount/${(totalChallengeCount / 2).toInt()}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class ChallengeCard extends ConsumerStatefulWidget {
  const ChallengeCard(
      {super.key,
      required this.title,
      required this.isVerified,
      required this.id});

  final String title;
  final bool isVerified;
  final int id;

  @override
  ConsumerState<ChallengeCard> createState() => ChallengeCardState();
}

class ChallengeCardState extends ConsumerState<ChallengeCard> {
  late bool _isVerified;
  String imagePath = "";

  @override
  void initState() {
    super.initState();
    _isVerified = widget.isVerified;
  }

  Future getImage(ImageSource imageSource) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    // final id = widget.id;
    if (pickedFile != null) {
      imagePath = pickedFile.path;

      if (mounted) {
        // Navigate to the VerifyingScreen and wait for result
        final bool verifyResult = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) =>
                VerifyingScreen(imagePath: imagePath, id: widget.id),
          ),
        );

        if (verifyResult && mounted) {
          // Show success screen
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => const VerifySuccess()));

          setState(() {
            _isVerified = true;
          });
          ref.refresh(missionDataProvider);

          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              Navigator.of(context).pop();
            }
          });
        } else if (!verifyResult && mounted) {
          // Show failed screen
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => const VerifyFailed()));

          // Return to main screen after 2 seconds
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              Navigator.of(context).pop();
            }
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final missionDataAsync = ref.watch(missionDataProvider);

    return Container(
      width: 131.w,
      height: 147.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          color: _isVerified ? GrayScale.gray_100 : theme().color_600),
      child: Stack(
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          // verify button

          Positioned(
            bottom: 1.h,
            right: 0.w,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.w),
                  color: _isVerified ? GrayScale.gray_300 : Colors.black),
              // alignment: Alignment.center,
              width: 53.w,
              height: 25.h,
              child: TextButton(
                onPressed: () {
                  if (!_isVerified) {
                    getImage(ImageSource.camera)
                        .then((_) => {ref.watch(missionDataProvider)});
                  }
                },
                child: Text(
                  'Verify',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
