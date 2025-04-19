import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/theme.dart';

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

  @override
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
                    color: GrayScale.gray_300,
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
                  color: GrayScale.gray_300,
                ),
          )
        ],
      ),
    );
  }
}
