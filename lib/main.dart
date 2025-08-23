import 'dart:developer';
import 'package:fina_points_calculator/firebase_options.dart';
import 'package:fina_points_calculator/l10n/app_localizations.dart';
import 'package:fina_points_calculator/view/screen/calculator_screen.dart';
import 'package:fina_points_calculator/view/screen/limits_screen.dart';
import 'package:fina_points_calculator/view/screen/main_page.dart';
import 'package:fina_points_calculator/theme/theme_provider.dart';
import 'package:fina_points_calculator/view/screen/records_screen.dart';
import 'package:fina_points_calculator/view/screen/settings_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    analytics.setAnalyticsCollectionEnabled(true);
  } catch (e) {
    log("Failed to initialize Firebase: $e", time: DateTime.now());
  }

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MainApp(),
  ));
}

final _rootKey = GlobalKey<NavigatorState>();
final _router =
    GoRouter(navigatorKey: _rootKey, initialLocation: '/calculator', routes: [
  StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainPage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(routes: <RouteBase>[
          GoRoute(
            path: '/calculator',
            builder: (BuildContext context, GoRouterState state) {
              return const CalculatorScreen();
            },
          ),
        ]),
        StatefulShellBranch(routes: <RouteBase>[
          GoRoute(
            path: '/records',
            builder: (BuildContext context, GoRouterState state) {
              return const RecordsScreen();
            },
          )
        ]),
        StatefulShellBranch(routes: <RouteBase>[
          GoRoute(
            path: '/limits',
            builder: (BuildContext context, GoRouterState state) {
              return const LimitsScreen();
            },
          ),
        ]),
        StatefulShellBranch(routes: <RouteBase>[
          GoRoute(
            path: '/settings',
            builder: (BuildContext context, GoRouterState state) {
              return SettingsScreen();
            },
          ),
        ])
      ]),
]);

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MainAppState? state = context.findAncestorStateOfType<_MainAppState>();
    state?.setLocale(newLocale);
  }
}

class _MainAppState extends State<MainApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    saveLanguage(locale);
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    loadLanguage();
  }

  void loadLanguage() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode');

    if (languageCode != null) {
      _locale = Locale(languageCode);
    }
  }

  void saveLanguage(Locale locale) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Aqua Points Calculator',
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'root',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      theme: Provider.of<ThemeProvider>(context).themeData,
      routerConfig: _router,
    );
  }
}
