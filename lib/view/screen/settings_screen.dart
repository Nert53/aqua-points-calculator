import 'package:fina_points_calculator/theme/theme_provider.dart';
import 'package:fina_points_calculator/utils/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fina_points_calculator/main.dart';

enum Language {
  en('English', 'en'),
  cs('Čeština', 'cs'),
  de('Deutsch', 'de');

  const Language(this.value, this.code);
  final String value;
  final String code;
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double containerHeight = 50.0 * Language.values.length;

  Future<void> _onOpen(LinkableElement link) async {
    if (!await launchUrl(Uri.parse(link.url))) {
      throw Exception('Could not launch ${link.url}');
    }
  }

  Future<void> _onImageClick(String link) async {
    if (!await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch $link');
    }
  }

  @override
  Widget build(BuildContext context) {
    double dialogWidth = MediaQuery.of(context).size.width < 800
        ? MediaQuery.of(context).size.width * 0.8
        : 600;

    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode();
    bool isSystemColorMode =
        Provider.of<ThemeProvider>(context, listen: false).isSystemColorMode;

    String currentLanguageCode = Localizations.localeOf(context).languageCode;
    String currentLanguage = Language.values
        .firstWhere((element) => element.code == currentLanguageCode)
        .value;

    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(AppLocalizations.of(context)!.language),
              subtitle: Text(currentLanguage),
              leading: const Icon(Icons.language_outlined),
              onTap: () {
                openLanguageDialog(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.colorTheme),
              leading: const Icon(Icons.color_lens_outlined),
              trailing: DropdownMenu<String>(
                menuStyle: MenuStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.primaryContainer),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  isDense: true,
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.primaryContainer,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  constraints: BoxConstraints.tight(
                    const Size.fromHeight(42),
                  ),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                ),
                initialSelection: isSystemColorMode
                    ? 'system'
                    : isDarkMode
                        ? 'dark'
                        : 'light',
                onSelected: (String? value) {
                  if (value == 'system') {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .setSystemColorMode(true);
                  } else {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .setSystemColorMode(false);
                    Provider.of<ThemeProvider>(context, listen: false)
                        .setDarkMode(value == 'dark');
                  }
                },
                dropdownMenuEntries: [
                  DropdownMenuEntry(
                      value: 'system',
                      label: AppLocalizations.of(context)!.system),
                  DropdownMenuEntry(
                    value: 'light',
                    label: AppLocalizations.of(context)!.light,
                  ),
                  DropdownMenuEntry(
                    value: 'dark',
                    label: AppLocalizations.of(context)!.dark,
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.limits),
              leading: const Icon(Icons.help_outline_outlined),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        alignment: Alignment.topCenter,
                        insetPadding: const EdgeInsets.only(top: 50),
                        child: SizedBox(
                          width: dialogWidth,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.help_outline),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context)!.limits,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.redAccent,
                                          )),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, bottom: 12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        RichText(
                                            text: TextSpan(
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .color,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '1) Worlds and Olympics: ',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  height: 2),
                                            ),
                                            TextSpan(text: '\n'),
                                            TextSpan(
                                                text:
                                                    'Limits are taken from the official World Aquatics website. For some countries may be different (usually harder).',
                                                style: TextStyle(height: 1.5)),
                                          ],
                                        )),
                                        const SizedBox(height: 16),
                                        SelectableText.rich(TextSpan(
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .color,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '2) Europeans and Universiade: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  height: 2),
                                            ),
                                            TextSpan(text: '\n'),
                                            TextSpan(
                                                text:
                                                    'Limits are valid for Czech Aquatics and for any other federation it will be different. Czech limits are based on 16th or 8th place on the best of last 3 European Championships or one last Universiade.',
                                                style: TextStyle(height: 1.5)),
                                          ],
                                        )),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.aboutApp),
              leading: const Icon(Icons.info_outline),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      alignment: Alignment.topCenter,
                      insetPadding: const EdgeInsets.only(top: 56),
                      child: SizedBox(
                        width: dialogWidth, // 80% of screen width
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    const Icon(Icons.info_outline),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!.aboutApp,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.redAccent,
                                        )),
                                  ],
                                ),
                              ),
                              const Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: SelectionArea(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Unofficial app for calculating Aqua Points (previously FINA points). This app is not affiliated with World Aquatics. ',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(height: 10),
                                      SelectableLinkify(
                                        onOpen: _onOpen,
                                        style: const TextStyle(fontSize: 14),
                                        text:
                                            'If you have any questions or suggestions contact us directly through email umimplavat@gmail.com or visit our website. ',
                                      ),
                                      const SizedBox(height: 10),
                                      RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .color,
                                              fontSize: 14,
                                              height: 1.5),
                                          children: [
                                            const TextSpan(
                                                text:
                                                    'App is also available in the web browser ('),
                                            TextSpan(
                                              text: 'finapoints.com',
                                              style: TextStyle(
                                                  color: Colors.blue[700],
                                                  decoration:
                                                      TextDecoration.underline),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () => _onImageClick(
                                                    'https://finapoints.com/'),
                                            ),
                                            const TextSpan(
                                                text:
                                                    ') and as mobile app for Android and iOS. It is written in Flutter and Dart and is open source (visit the '),
                                            TextSpan(
                                              text: 'GitHub',
                                              style: TextStyle(
                                                  color: Colors.blue[700],
                                                  decoration:
                                                      TextDecoration.underline),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () => _onImageClick(
                                                    'https://github.com/Nert53/aqua-points-calculator'),
                                            ),
                                            const TextSpan(text: ').'),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 32),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () =>
                                                _onImageClick(instagramUrl),
                                            child: SvgPicture.asset(
                                              'assets/icons/instagram_black.svg', // On click should redirect to an URL
                                              width: 32,
                                              height: 32,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .color,
                                            ),
                                          ),
                                          const SizedBox(width: 24),
                                          GestureDetector(
                                            onTap: () =>
                                                _onImageClick(facebookUrl),
                                            child: Image.asset(
                                              'assets/icons/facebook_secondary.png', // On click should redirect to an URL
                                              width: 32,
                                              height: 32,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .color,
                                            ),
                                          ),
                                          const SizedBox(width: 24),
                                          GestureDetector(
                                            onTap: () =>
                                                _onImageClick(websiteUrl),
                                            child: Icon(
                                              Icons
                                                  .web_outlined, // On click should redirect to an URL
                                              size: 32,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .color,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 32),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text('Author:'),
                                          Image.asset(
                                            'assets/um_logo_long.png',
                                            width: 125,
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        'Creator: Vojtech Netrh',
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Version: $appVersion',
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> openLanguageDialog(BuildContext context) {
    String currentLanguageCode = Localizations.localeOf(context).languageCode;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.language),
            content: SizedBox(
              width: 300,
              height: containerHeight,
              child: ListView.builder(
                  itemCount: Language.values.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(Language.values[index].value),
                      trailing:
                          Language.values[index].code == currentLanguageCode
                              ? Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              : null,
                      onTap: () {
                        setState(() {
                          MainApp.setLocale(
                              context, Locale(Language.values[index].code));
                          Navigator.of(context).pop();
                        });
                      },
                    );
                  }),
            ),
          );
        });
  }
}
