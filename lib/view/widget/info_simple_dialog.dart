import 'package:fina_points_calculator/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class InfoSimpleDialog extends StatelessWidget {
  const InfoSimpleDialog({
    super.key,
    required this.dialogWidth,
    required this.mainIcon,
    required this.title,
    required this.contentText,
  });

  final double dialogWidth;
  final IconData mainIcon;
  final String title;
  final String contentText;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      alignment: Alignment.topCenter,
      insetPadding: const EdgeInsets.only(top: 50),
      constraints: BoxConstraints(maxWidth: dialogWidth),
      title: Column(
        children: [
          Icon(mainIcon, size: 28),
          SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(),
            Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SelectableText.rich(TextSpan(
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                        children: [
                          TextSpan(
                            text: contentText,
                          ),
                        ])),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(AppLocalizations.of(context)!.close),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
