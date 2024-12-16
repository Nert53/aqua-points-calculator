import 'package:flutter/material.dart';

void showWarningSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12))),
    backgroundColor: Colors.yellow,
    content: Row(
      children: [
        Icon(Icons.warning_amber_rounded, color: Colors.grey[900]),
        const SizedBox(width: 8),
        Flexible(
            child: Text(
          message,
          style: TextStyle(color: Colors.grey[900]),
        )),
      ],
    ),
  ));
}
