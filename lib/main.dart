import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/screen/map_plogging/specify_photo.dart';
import 'package:ploop_fe/screen/splash/flutter_splash.dart';
import 'package:ploop_fe/theme.dart';
import 'screen/activity/activity.dart';
import 'screen/home/home.dart';
import 'screen/map_plogging/map.dart';
import 'screen/onboarding/onboarding.dart';
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
}

Future<void> _passAllApiKeysToIOS() async {
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
        home: MainScaffold(),
      ),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MainPage(),
    const MapPage(),
    const WorldPage(),
    const ActivityPage(),
  ];

  final List<String> _iconPaths = [
    'assets/images/Bar_Home.png',
    'assets/images/Bar_Plogging.png',
    'assets/images/Bar_World.png',
    'assets/images/Bar_Activity.png',
  ];

  final List<double> _iconHeights = [24, 26, 31, 24];
  final List<String> _labels = ['Home', 'Plogging', 'World', 'Activity'];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateTextStyle.resolveWith(
            (states) {
              final baseStyle = Theme.of(context).textTheme.labelSmall!;
              final isSelected = states.contains(WidgetState.selected);
              return baseStyle.copyWith(
                  color:
                      isSelected ? GrayScale.black : const Color(0x58000000));
            },
          ),
          height: 65,
          backgroundColor: GrayScale.white,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          elevation: 0,
          indicatorColor: Colors.transparent,
        ),
        child: NavigationBar(
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
    );
  }
}
