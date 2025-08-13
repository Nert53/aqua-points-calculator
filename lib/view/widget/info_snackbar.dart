import 'package:flutter/material.dart';

void showInfoSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: 9),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12))),
    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
    content: Row(
      children: [
        Icon(
          Icons.info_outline,
        ),
        const SizedBox(width: 8),
        Flexible(
            child: Text(
          message,
          style:
              TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
        )),
      ],
    ),
  ));
}
