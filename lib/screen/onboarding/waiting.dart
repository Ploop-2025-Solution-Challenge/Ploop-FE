import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as ref;
import 'package:ploop_fe/provider/country_list_provider.dart';
import 'package:ploop_fe/screen/signup/set_country.dart';
import 'package:ploop_fe/theme.dart';

class WaitingScreen extends ConsumerWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: GrayScale.white,
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Welcome!'),
              ref.watch(countryListProvider).when(
                    data: (data) => SetRegionPage(countries: data),
                    loading: () => LinearProgressIndicator(),
                    error: (err, stack) => Text('$err: $stack'),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
