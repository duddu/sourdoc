import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullWidthTextFieldWithAffixes extends StatelessWidget {
  const FullWidthTextFieldWithAffixes({
    super.key,
    required this.controller,
    required this.prefixText,
    required this.suffixText,
  });

  final TextEditingController controller;
  final String prefixText;
  final String suffixText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                prefixText: '$prefixText:',
                suffixText: suffixText,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.end,
              textInputAction: TextInputAction.done,
            )));
  }
}
