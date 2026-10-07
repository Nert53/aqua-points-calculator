import 'package:fina_points_calculator/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class MarkdownSimpleDialog extends StatelessWidget {
  const MarkdownSimpleDialog({
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
    return AlertDialog(
      title: Row(
        children: [
          Icon(mainIcon, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: dialogWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: MarkdownBody(
                  data: contentText,
                  selectable: true,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
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
          ],
        ),
      ),
    );
  }
}
