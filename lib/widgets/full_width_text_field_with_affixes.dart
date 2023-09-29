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
        child: TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        prefixText: '$prefixText:',
        suffixText: suffixText,
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      textAlign: TextAlign.end,
      textInputAction: TextInputAction.done,
    ));
  }
}
