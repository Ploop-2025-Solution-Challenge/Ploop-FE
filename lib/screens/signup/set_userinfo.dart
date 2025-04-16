import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/screens/signup/option_button_set.dart';

import '../home/ploop_appbar.dart';
import 'next_button.dart';
import 'set_nickname.dart';
import 'signup.dart';

class SetUserInfo extends StatelessWidget {
  SetUserInfo({super.key});

  final List<String> labelList = ['Female', 'Male', 'Prefer not to say'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 874.h,
      color: Colors.white,
      child: SafeArea(
        child: Stack(
          // page alignment
          children: [
            Positioned.fill(
              bottom: 60.h,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: NextPageButton(
                  route: SetUserNickname(),
                ),
              ),
            ),
            Column(
              spacing: 12.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                PloopAppBar(
                  showUserInfo: false,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset('assets/images/navigate-back-icon.png'),
                ),
                // body
                Container(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Select your date of birth and gender',
                          style: Theme.of(context).textTheme.headlineMedium),

                      SizedBox(height: 60.h),
                      // dropdown options
                      Column(
                        spacing: 82.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // option 1
                          Column(
                            spacing: 8.h,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date of Birth',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              // select from calender popup? or typeing input?
                              UserBirthDatePicker(),
                            ],
                          ),
                          Column(
                            spacing: 8.h,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gender',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              OptionButtonSet(
                                options: [
                                  ...labelList,
                                ],
                                isMultiSelect: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserBirthDatePicker extends StatefulWidget {
  const UserBirthDatePicker({super.key});

  @override
  State<UserBirthDatePicker> createState() => _UserBirthDatePickerState();
}

class _UserBirthDatePickerState extends State<UserBirthDatePicker> {
  DateTime? date;

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216.h,
        padding: const EdgeInsets.only(top: 6.0),
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(top: false, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDialog(
        CupertinoDatePicker(
            maximumDate: DateTime.now(),
            dateOrder: DatePickerDateOrder.dmy,
            mode: CupertinoDatePickerMode.date,
            initialDateTime:
                date ?? DateTime.now().subtract(const Duration(seconds: 1)),
            onDateTimeChanged: (DateTime newDate) {
              setState(() => date = newDate);
            }),
      ),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        width: 370,
        height: 47,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: (date == null)
            ? Text(
                'DD / MM / YYYY',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFFA1A1A1),
                    ),
              )
            : Text(
                '${date!.day} / ${date!.month} / ${date!.year}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF000000),
                    ),
              ),
      ),
    );
  }
}
