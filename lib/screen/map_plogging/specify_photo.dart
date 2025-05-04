import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ploop_fe/model/bin_request.dart';
import 'package:ploop_fe/model/trashspot_request.dart';
import 'package:ploop_fe/service/bin_service.dart';
import 'package:ploop_fe/service/trashspot_service.dart';
import 'package:ploop_fe/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpecifyPhoto extends StatefulWidget {
  final String imagePath;
  final double latitude;
  final double longitude;

  const SpecifyPhoto(
      {super.key,
      required this.imagePath,
      required this.latitude,
      required this.longitude});

  @override
  State<StatefulWidget> createState() => _SpecifyPhotoState();
}

enum ImageType { bin, area }

class _SpecifyPhotoState extends State<SpecifyPhoto> {
  ImageType? selectedType;

  Future sendImageByType(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');
    final image = XFile(widget.imagePath);

    try {
      if (jwt == null) {
        debugPrint('jwt is null');
        return;
      }

      // case bin
      if (selectedType == ImageType.bin) {
        final bin = BinRequest(
          latitude: widget.latitude,
          longitude: widget.longitude,
        );

        debugPrint('trying to send bin');
        final response =
            await BinService.postBinPositionToServer(bin, jwt, image);

        if (response) {
          Navigator.pop(context, 'success');
        } else {
          Navigator.pop(context, 'fail');
        }
      }
      // case area
      else if (selectedType == ImageType.area) {
        final trashspot = TrashspotRequest(
            latitude: widget.latitude, longitude: widget.longitude);

        debugPrint('trying to send area');
        final response = await TrashspotService.postTrashspotPositionToServer(
            trashspot, jwt, image);

        if (response) {
          Navigator.pop(context, 'success');
        } else {
          Navigator.pop(context, 'fail');
        }
      } else {
        if (Platform.isIOS) {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('Hold on!'),
              content:
                  const Text('You need to select a type before uploading.'),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Color.fromARGB(255, 0, 122, 255)),
                  ),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Hold on!'),
              content:
                  const Text('You need to select a type before uploading.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Color.fromARGB(255, 0, 122, 255)),
                  ),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      Navigator.pop(context, 'fail');
    }
  }
  // case: area

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 34.h, 16.w, 0),
        color: GrayScale.black,
        child: Column(
          spacing: 42.h,
          // photo
          children: [
            SizedBox(
              width: 402.w,
              height: 508.h,
              child: Image.file(
                File(widget.imagePath),
                fit: BoxFit.cover,
              ),
            ),
            Column(
              spacing: 28.h,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Please specify what you found.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: GrayScale.white),
                ),
                // buttons row
                Row(
                  spacing: 16.w,
                  children: [
                    Expanded(
                      child: TypeSelectButton(
                          onPressed: () {
                            setState(() {
                              selectedType = ImageType.bin;
                            });
                          },
                          label: 'Bin',
                          isSelected: selectedType == ImageType.bin),
                    ),
                    Expanded(
                      child: TypeSelectButton(
                        onPressed: () {
                          setState(() {
                            selectedType = ImageType.area;
                          });
                        },
                        label: 'Litter Area',
                        isSelected: selectedType == ImageType.area,
                      ),
                    ),
                  ],
                ),

                // upload button
                UploadButton(
                  onPressed: () =>
                      {debugPrint('pressed'), sendImageByType(context)},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UploadButton extends StatelessWidget {
  final VoidCallback onPressed;

  const UploadButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        elevation: 0,
        animationDuration: Duration.zero,
        splashFactory: NoSplash.splashFactory,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.w)),
        backgroundColor: theme().color_600,
        padding: EdgeInsets.all(0.w),
      ),
      onPressed: onPressed,
      child: Container(
        width: 370.w,
        height: 48.h,
        alignment: Alignment.center,
        child: Text(
          'Upload',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}

class TypeSelectButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final bool isSelected;
  const TypeSelectButton(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0.w),
        elevation: 0,
        splashFactory: NoSplash.splashFactory,
        animationDuration: Duration.zero,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isSelected ? theme().color_600 : GrayScale.gray_500,
          ),
          borderRadius: BorderRadius.circular(16.w),
        ),
      ),
      child: SizedBox(
        height: 48.h,
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: isSelected ? theme().color_600 : GrayScale.gray_500,
                ),
          ),
        ),
      ),
    );
  }
}
