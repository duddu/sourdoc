import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/constants/style.dart' as style;

class TextFieldWithAffixes extends StatelessWidget {
  const TextFieldWithAffixes({
    super.key,
    required this.controller,
    required this.prefixText,
    required this.suffixText,
    required this.tooltip,
    required this.maxValue,
    this.paddingTop = 5,
  });

  final TextEditingController controller;
  final String prefixText;
  final String suffixText;
  final String tooltip;
  final double maxValue;
  final double paddingTop;

  void _showErrorSnackBar(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
            child: SizedBox(
                width: style.contentMaxWidth,
                child: Semantics(
                    label: locale.a11yTextFieldErrorLabel,
                    child: Text(locale.getInputErrorMessage(maxValue),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.bodySmall!.fontSize,
                            color: Theme.of(context).colorScheme.error))))),
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
      ),
    );
  }

  void _onChanged(String text, BuildContext context) {
    if (text.isEmpty) {
      controller.text = '0';
    } else if (double.parse(text) > maxValue) {
      controller.text = '$maxValue';
      _showErrorSnackBar(context);
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
            padding: EdgeInsets.fromLTRB(0, paddingTop, 0, 5),
            child: Tooltip(
                message: tooltip,
                child: Semantics(
                    textField: true,
                    focusable: true,
                    label: tooltip,
                    value: '${controller.text} $suffixText',
                    hint: locale.a11yTextFieldHint,
                    child: TextField(
                      controller: controller,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        isDense: true,
                        prefixText: '$prefixText:',
                        prefixStyle: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.bodyLarge!.fontSize,
                            color: Colors.grey.shade800),
                        suffixText: suffixText,
                        suffixStyle: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.bodyLarge!.fontSize,
                            color: Colors.black),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                      ],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textAlign: TextAlign.end,
                      textInputAction: TextInputAction.done,
                      style: Theme.of(context).textTheme.bodyLarge,
                      onTap: _onTap,
                      onChanged: (text) {
                        _onChanged(text, context);
                      },
                    )))));
  }
}
