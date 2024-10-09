import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimeField extends StatelessWidget {
  final TextEditingController controller;
  final Function functionOnChanged;
  final String labelText;
  final int maxValue;

  const TimeField(
      {super.key,
      required this.controller,
      required this.functionOnChanged,
      required this.labelText,
      required this.maxValue});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          functionOnChanged(true);
        },
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(2),
          FilteringTextInputFormatter.digitsOnly,
          MaxValueInputFormatter(maxValue, context)
        ],
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

class MaxValueInputFormatter extends TextInputFormatter {
  final int maxValue;
  final BuildContext context;

  MaxValueInputFormatter(this.maxValue, this.context);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    int value = int.tryParse(newValue.text) ?? 0;
    if (value > maxValue) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          content: Text('Maximal value in this field is $maxValue')));
      return oldValue;
    }

    return newValue;
  }
}
