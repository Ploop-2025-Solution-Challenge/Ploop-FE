import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/screens/signup/option_button_set.dart';

import '../home/ploop_appbar.dart';
import 'next_button.dart';
import 'set_difficulty.dart';
import 'signup.dart';

class SetUserNickname extends StatelessWidget {
  SetUserNickname({super.key});

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
                  route: SetDifficulty(),
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
                      Text('Create your nickname',
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
                                'Nickname',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              NicknameInputField(),
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

class NicknameInputField extends StatefulWidget {
  const NicknameInputField(
      {super.key, this.userNickname, this.maxNicknameLength = 20});
  final String? userNickname;
  final int maxNicknameLength;

  @override
  State<NicknameInputField> createState() => _NicknameInputFieldState();
}

class _NicknameInputFieldState extends State<NicknameInputField> {
  late TextEditingController _textController;
  int nicknameLength = 0;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      width: 370.w,
      height: 47.h,
      alignment: Alignment.centerLeft,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: CupertinoTextField(
              placeholder: 'Enter your nickname',
              placeholderStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFFA1A1A1),
                  ),
              decoration: null,
              inputFormatters: [
                LengthLimitingTextInputFormatter(widget.maxNicknameLength),
              ],
              onTapOutside: ((event) {
                FocusScope.of(context).unfocus();
              }),
              onChanged: (value) {
                setState(() {
                  nicknameLength = value.length;
                  // TODO: send request with this nickname after finish_setup
                });
              },
            ),
          ),
          Text(
            '$nicknameLength/${widget.maxNicknameLength}',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: const Color(0xFFA1A1A1),
                ),
          )
        ],
      ),
    );
  }
}
