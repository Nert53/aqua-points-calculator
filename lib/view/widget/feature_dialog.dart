import 'package:fina_points_calculator/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeatureDialog extends StatelessWidget {
  const FeatureDialog(
      {super.key,
      required this.prefs,
      required this.limitLongPressFeatureCount});

  final SharedPreferences prefs;
  final int limitLongPressFeatureCount;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/party-popper.svg',
            height: 35,
            width: 35,
          ),
          SizedBox(width: 16),
          Text('${AppLocalizations.of(context)!.newFeature}!'),
        ],
      ),
      content: Text(AppLocalizations.of(context)!.newFeatureText),
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await prefs.setInt(
                'limitLongPressFeature', limitLongPressFeatureCount + 1);
          },
          child: Text(AppLocalizations.of(context)!.gotIt),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await prefs.setInt('limitLongPressFeature', 5);
          },
          child: Text(
            AppLocalizations.of(context)!.dontShowAgain,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ],
    );
  }
}
