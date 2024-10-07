import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimeField extends StatelessWidget {
  final TextEditingController controller;
  final Function functionOnChanged;
  final String labelText;

  const TimeField(
      {super.key,
      required this.controller,
      required this.functionOnChanged,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          functionOnChanged(true);
        },
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            contentPadding: const EdgeInsets.all(16),
            isDense: true));
  }
}
