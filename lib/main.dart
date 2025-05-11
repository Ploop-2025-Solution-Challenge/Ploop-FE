import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/provider/plogging_state_provider.dart';
import 'package:ploop_fe/screen/splash/flutter_splash.dart';
import 'package:ploop_fe/theme.dart';
import 'screen/activity/activity.dart';
import 'screen/home/home.dart';
import 'screen/map_plogging/map.dart';
import 'screen/world/world.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await ScreenUtil.ensureScreenSize();
  await _passAllApiKeysToIOS();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );

  // set home indicator background transparent
  if (Platform.isAndroid) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }
}

Future<void> _passAllApiKeysToIOS() async {
  if (Platform.isIOS) {
    const platform = MethodChannel('com.example.ploopFe/env');

    try {
      final String mapsApiKey = dotenv.env['GMS_API_KEY'] ?? '';
      if (mapsApiKey.isNotEmpty) {
        await platform.invokeMethod('setGoogleMapsApiKey', {
          'gmsApiKey': mapsApiKey,
        });
      }
    } catch (e) {
      debugPrint('Error passing API keys to iOS: $e');
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      builder: (context, child) => MaterialApp(
        title: 'Ploop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          useMaterial3: true,
          // overriding default texttheme
          textTheme: ploopTextTheme(),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

class MainScaffold extends ConsumerStatefulWidget {
  const MainScaffold({super.key});
  @override
  ConsumerState<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends ConsumerState<MainScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MainPage(),
    const MapPage(),
    const WorldPage(),
    const ActivityPage(),
  ];

  final List<String> _iconPaths = [
    'assets/icons/Bar_Home.png',
    'assets/icons/Bar_Plogging.png',
    'assets/icons/Bar_World.png',
    'assets/icons/Bar_Activity.png',
  ];

  final List<double> _iconHeights = [40.h, 39.3.h, 42.h, 40.h];
  final List<String> _labels = ['Home', 'Plogging', 'World', 'Activity'];
  bool ploggingState = false;

  void _onTap(int index) {
    if (!ploggingState) {
      setState(() {
        _selectedIndex = index;
      });
    } else {
      if (Platform.isIOS) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Your progress will be lost if you exit now.'),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: false,
                onPressed: () {
                  ref
                      .watch(ploggingStateNotifierProvider.notifier)
                      .setPloggingState(false);
                  setState(() {
                    _selectedIndex = index;
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Go to page',
                  style: TextStyle(color: Color.fromARGB(255, 0, 122, 255)),
                ),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
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
            title: Text(
              'Are you sure?',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                height: 1.33.h,
                letterSpacing: 0,
              ),
            ),
            content: Text(
              'Your progress will be lost if you exit now.',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.43.h,
                letterSpacing: 0.25,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  ref
                      .watch(ploggingStateNotifierProvider.notifier)
                      .setPloggingState(false);
                  setState(() {
                    _selectedIndex = index;
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  'Go to page',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14.sp,
                      height: 1.43.h,
                      color: GrayScale.black),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14.sp,
                      height: 1.43.h,
                      color: GrayScale.black),
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ploggingState = ref.watch(ploggingStateNotifierProvider).isActive;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 1.h, color: GrayScale.gray_100),
            NavigationBarTheme(
              data: NavigationBarThemeData(
                labelTextStyle: WidgetStateTextStyle.resolveWith(
                  (states) {
                    final baseStyle = Theme.of(context).textTheme.labelSmall!;
                    final isSelected = states.contains(WidgetState.selected);
                    return baseStyle.copyWith(
                        color: isSelected
                            ? GrayScale.black
                            : const Color(0x58000000));
                  },
                ),
                height: 65.h,
                backgroundColor: GrayScale.white,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                elevation: 0,
                indicatorColor: Colors.transparent,
              ),
              child: NavigationBar(
                labelBehavior: null,
                shadowColor: null,
                selectedIndex: _selectedIndex,
                onDestinationSelected: _onTap,
                destinations: [
                  ...List.generate(
                    4,
                    (index) {
                      final isSelected = _selectedIndex == index;
                      final double opacity = isSelected ? 1.0 : 0.4;

                      return NavigationDestination(
                        icon: Opacity(
                          opacity: opacity,
                          child: Image.asset(
                            _iconPaths[index],
                            height: _iconHeights[index],
                          ),
                        ),
                        label: _labels[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
