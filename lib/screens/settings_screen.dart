import 'package:fina_points_calculator/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _onOpen(LinkableElement link) async {
    if (!await launchUrl(Uri.parse(link.url))) {
      throw Exception('Could not launch ${link.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double dialogWidth = MediaQuery.of(context).size.width < 800
        ? MediaQuery.of(context).size.width * 0.8
        : 600;

    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode();

    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: const Text('Language'),
              subtitle: const Text('English'),
              leading: const Icon(Icons.language_outlined),
              onTap: () {},
              enabled: false,
            ),
            ListTile(
              title: const Text('Dark Theme'),
              leading: const Icon(Icons.color_lens_outlined),
              trailing: Switch(
                value: isDarkMode,
                onChanged: (bool value) {
                  setState(() {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                    isDarkMode = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('About app'),
              leading: const Icon(Icons.info_outline),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      alignment: Alignment.topCenter,
                      insetPadding: const EdgeInsets.only(top: 48),
                      child: SizedBox(
                        width: dialogWidth, // 80% of screen width
                        height: 400, // 50% of screen height
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    const Icon(Icons.info_outline),
                                    const SizedBox(width: 12),
                                    const Expanded(
                                      child: Text(
                                        'About app',
                                        style: TextStyle(
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
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: SelectionArea(
                                  child: Column(
                                    children: [
                                      const Text(
                                          'Unofficial app for calculating Aqua Points (previously named FINA points). This app is not affiliated with World Aquatics and it is project of one interested person. '),
                                      const SizedBox(height: 12),
                                      const Text(
                                          'App is written in Flutter and Dart. It is available as web app (on www.finapoints.com) and in the future hopefully as mobile app (Google Play Store and Apple App Store).'),
                                      const SizedBox(height: 12),
                                      SelectableLinkify(
                                        onOpen: _onOpen,
                                        text:
                                            'If you have any questions or suggestions, feel free to contact me at: vojtanetrh@gmail.com. Or if you want to check the source code (or download .apk file for you android) visit the GitHub repository: -adding later-.',
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
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
