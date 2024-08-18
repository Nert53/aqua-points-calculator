import 'package:fina_points_calculator/screens/main_page.dart';
import 'package:fina_points_calculator/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MainApp(),
  ));
}

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aqua Points Calculator',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const MainPage(),
    );
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
}
