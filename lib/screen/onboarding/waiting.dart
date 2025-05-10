import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/provider/country_list_provider.dart';
import 'package:ploop_fe/screen/signup/set_country.dart';
import 'package:ploop_fe/theme.dart';

class WaitingScreen extends ConsumerStatefulWidget {
  const WaitingScreen({super.key});

  @override
  ConsumerState<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends ConsumerState<WaitingScreen> {
  bool _navigating = false;

  @override
  Widget build(BuildContext context) {
    final countryListState = ref.watch(countryListProvider);

    if (countryListState is AsyncData && !_navigating) {
      final countries = countryListState.value;
      if (countries != null) {
        _navigating = true;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SetRegionPage(countries: countries),
            ),
          );
        });
      }
    }

    return PopScope(
      canPop: false,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: GrayScale.white,
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 64.h,
              children: [
                Text('Welcome!',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                if (countryListState is AsyncLoading)
                  SizedBox(
                    width: 128.w,
                    child: const LinearProgressIndicator(
                      trackGap: 0,
                      color: GrayScale.black,
                      backgroundColor: GrayScale.gray_100,
                    ),
                  )
                else if (countryListState is AsyncError)
                  Text(
                      '${countryListState.error}: ${countryListState.stackTrace}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
