import 'package:fina_points_calculator/l10n/app_localizations.dart';
import 'package:fina_points_calculator/utils/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FeatureDialog extends StatelessWidget {
  const FeatureDialog({super.key, required this.juniorModeFeatureCount});

  final int juniorModeFeatureCount;

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
            PreferencesService.setNewFeatureCount(
                'juniorModeFeatureCount', juniorModeFeatureCount + 1);
          },
          child: Text(AppLocalizations.of(context)!.gotIt),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            PreferencesService.setNewFeatureCount('juniorModeFeatureCount', 5);
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
