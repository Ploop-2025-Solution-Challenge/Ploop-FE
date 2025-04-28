import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ploop_fe/screen/home/ploop_appbar.dart';
import 'package:ploop_fe/theme.dart';

class PloggingResult extends StatelessWidget {
  const PloggingResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GrayScale.white,
      child: SafeArea(
        child: Container(
          // color: Colors.green,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 34.h,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset('assets/icons/navigate-back-icon.png'),
                  )
                ],
              ),
              Positioned(
                top: 108.h,
                child: Center(
                  child: Column(
                    spacing: 40.h,
                    children: [
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      Text(
                        "${DateFormat('dd. MM. y - hh:mm a').format(DateTime.now())}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: GrayScale.gray_300),
                      ),
                      Column(
                        spacing: 8.h,
                        children: [
                          Text(
                            "0*",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            'Trash collected',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 41.w,
                        children: [
                          Column(
                            spacing: 2.h,
                            children: [
                              Text('0.0',
                                  style:
                                      Theme.of(context).textTheme.displaySmall),
                              Text(
                                'Miles',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: GrayScale.gray_300,
                                    ),
                              ),
                            ],
                          ),
                          // stopwatch

                          Column(
                            spacing: 2.h,
                            children: [
                              Text('0:00',
                                  style:
                                      Theme.of(context).textTheme.displaySmall),
                              Text(
                                'Time',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: GrayScale.gray_300,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
