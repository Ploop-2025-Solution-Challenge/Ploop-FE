import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    ProviderScope(
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
    print('Error passing API keys to iOS: $e');
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
          textTheme: TextTheme(
            // App Title
            displayLarge: TextStyle(
              fontSize: 34.sp,
              fontFamily: 'SF-Pro-Display',
              fontWeight: FontWeight.w700,
              height: 1.21,
              letterSpacing: 0.40,
            ),
            // Picked litter display
            /* copy this theme for total challenge status */
            displayMedium: TextStyle(
              fontSize: 60.sp,
              fontFamily: 'FugazOne',
              // default fontweight
              height: 0.82,
              letterSpacing: 0.40,
            ),
            // Data value display
            displaySmall: TextStyle(
                fontSize: 22.sp,
                fontFamily: 'SF-Pro-Display',
                fontWeight: FontWeight.w700,
                height: 1.27,
                letterSpacing: -0.45),
            // Page title
            headlineLarge: TextStyle(
              fontSize: 21.sp,
              fontFamily: 'SF-Pro-Display',
              fontWeight: FontWeight.w600,
              height: 1.25,
              letterSpacing: -0.15,
            ),
            // Page title 2
            headlineMedium: TextStyle(
              fontSize: 20.sp,
              fontFamily: 'SF-Pro',
              fontWeight: FontWeight.w400,
              height: 1.25,
              letterSpacing: -0.45,
            ),

            // Section Title
            titleLarge: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'SF-Pro-Display',
              fontWeight: FontWeight.w600,
              height: 1.33,
              letterSpacing: 0.12,
            ),
            // Section title 2
            titleMedium: TextStyle(
              fontSize: 15.sp,
              fontFamily: 'SF-Pro',
              fontWeight: FontWeight.w400,
              height: 1.33,
              letterSpacing: -0.23,
            ),
            // Button1, Data unit display
            labelLarge: TextStyle(
              fontSize: 18.sp,
              fontFamily: 'SF-Pro-Display',
              fontWeight: FontWeight.w600,
              height: 1.29,
              letterSpacing: -0.08,
            ),
            // Button2
            labelMedium: TextStyle(
              fontSize: 15.sp,
              fontFamily: 'SF-Pro-Display',
              fontWeight: FontWeight.w600,
              height: 1.33,
              letterSpacing: 0.06,
            ),
            // Navigation bar
            labelSmall: TextStyle(
              fontSize: 11.sp,
              fontFamily: 'SF-Pro',
              fontWeight: FontWeight.w400,
              height: 1.18,
              letterSpacing: 0.06,
            ),
            // Content
            /* copy this theme for filter buttons on map */
            bodyLarge: TextStyle(
              fontSize: 17.sp,
              fontFamily: 'SF-Pro',
              fontWeight: FontWeight.w400,
              height: 1.29,
              letterSpacing: -0.43,
            ),

            // Personal challenge status
            bodyMedium: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'SF-Pro-Display',
              fontWeight: FontWeight.w600,
              height: 1.31,
              letterSpacing: -0.31,
            ),
            // Challenge profile name
            /* copy this theme for activity details */
            bodySmall: TextStyle(
              fontSize: 13.sp,
              fontFamily: 'SF-Pro',
              fontWeight: FontWeight.w400,
              height: 1.38,
              letterSpacing: -0.08,
            ),
          ),
        ),
        home: const OnboardingPage(),
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
    MapPage(),
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
                  color: isSelected
                      ? const Color(0xFF000000)
                      : const Color.from(
                          alpha: 0.349, red: 0, green: 0, blue: 0));
            },
          ),
          height: 65,
          backgroundColor: Colors.white,
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
