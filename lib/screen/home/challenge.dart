import 'package:flutter/material.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// maybe consumer widget?
class ChallengeProgressCard extends StatelessWidget {
  ChallengeProgressCard({super.key});

  // multiply this factor to colored width of graph
  final int totalChallengeCount = 3;
  final int myProgress = 1;
  final int otherProgress = 3;

  final String username = 'Ethan';
  final String otherUsername = 'Olivia';

  @override
  Widget build(BuildContext context) {
    final double totalPercentage =
        (myProgress + otherProgress) / (totalChallengeCount * 2);

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
                        color: const Color.fromRGBO(126, 125, 125, 1),
                        borderRadius: BorderRadius.circular(5.w)),
                    width: 340.w,
                    height: 24.h,
                  ),
                  Container(
                    width: 340.w * totalPercentage,
                    height: 24.h,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(126, 241, 141, 1),
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
                'You and $otherUsername are in a challenge together',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: const Color.fromRGBO(165, 165, 165, 1)),
              ),
              SizedBox(
                height: 6.h,
              ),
              Row(
                spacing: 8.w,
                children: [
                  ChallengeUserCard(
                    username: 'Ethan',
                    verifiedChallengeCount: myProgress,
                    totalChallengeCount: totalChallengeCount,
                  ),
                  ChallengeUserCard(
                    username: 'Olivia',
                    verifiedChallengeCount: otherProgress,
                    totalChallengeCount: totalChallengeCount,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChallengeUserCard extends StatelessWidget {
  const ChallengeUserCard(
      {super.key,
      required this.username,
      required this.verifiedChallengeCount,
      required this.totalChallengeCount});

  // get data with user id?
  final String username;
  final int totalChallengeCount;
  final int verifiedChallengeCount;

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
        spacing: 24.w,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8.w,
            children: [
              CircleAvatar(
                backgroundImage:
                    const AssetImage('assets/images/default-user-icon.png'),
                // foregroundImage: userProfile.profileImageUrl != null
                //     ? NetworkImage(userProfile.profileImageUrl!)
                //     : null,
                radius: 20.w,
              ),
              Text(
                username,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Text(
            '$verifiedChallengeCount/$totalChallengeCount',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

// TODO: convert to consumer widget when connecting to database
class ChallengeCard extends StatefulWidget {
  const ChallengeCard(
      {super.key, required this.title, required this.isVerified});

  final String title;
  final bool isVerified;

  @override
  State<StatefulWidget> createState() => ChallengeCardState();
}

class ChallengeCardState extends State<ChallengeCard> {
  late bool _isVerified;

  @override
  void initState() {
    super.initState();
    _isVerified = widget.isVerified;
  }

  void _toggleVerify() {
    setState(() {
      _isVerified = !_isVerified;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 131.w,
      height: 147.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          color:
              _isVerified ? const Color(0xFFD2D2D2) : const Color(0xFF7EF18D)),
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
                  color: _isVerified ? const Color(0xFFA1A1A1) : Colors.black),
              // alignment: Alignment.center,
              width: 53.w,
              height: 25.h,
              child: TextButton(
                onPressed: _toggleVerify,
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
