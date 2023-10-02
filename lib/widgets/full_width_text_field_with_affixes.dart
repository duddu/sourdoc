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

  void _onChanged(String text) {
    if (text.isEmpty) {
      controller.text = '0';
    }
  }

  void _onTap() {
    controller.selection = TextSelection(
        baseOffset: 0, extentOffset: controller.value.text.length);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                isDense: true,
                prefixText: '$prefixText:',
                prefixStyle:
                    TextStyle(fontSize: 16, color: Colors.grey.shade800),
                suffixText: suffixText,
                suffixStyle: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
              ],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.end,
              textInputAction: TextInputAction.done,
              onTap: _onTap,
              onChanged: _onChanged,
            )));
  }
}
