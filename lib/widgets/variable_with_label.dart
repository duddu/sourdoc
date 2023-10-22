import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/constants/style.dart' as style;
import 'package:sourdoc/widgets/header.dart';

class VariableWithLabel extends StatelessWidget {
  const VariableWithLabel({
    super.key,
    required this.label,
    required this.value,
    this.additionalInfoText,
    this.noMarginLeft = false,
  });

  final String label;
  final Consumer value;
  final String? additionalInfoText;
  final bool noMarginLeft;

  bool _hasAdditionalInfo() =>
      additionalInfoText != null && additionalInfoText!.isNotEmpty;
  bool _isMobileDevice(BuildContext context) =>
      Theme.of(context).platform == TargetPlatform.android ||
      Theme.of(context).platform == TargetPlatform.iOS;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
          semanticContainer: true,
          margin: EdgeInsets.fromLTRB(noMarginLeft ? 0 : 11, 5, 0, 3),
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                  _hasAdditionalInfo() ? 19 : 2,
                  _hasAdditionalInfo() && _isMobileDevice(context) ? 9 : 12,
                  _hasAdditionalInfo() ? 4 : 2,
                  _hasAdditionalInfo() && _isMobileDevice(context) ? 8 : 11),
              child: Row(children: [
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            label,
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .fontSize,
                                color: Colors.grey.shade800,
                                height: 1.45),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Semantics(
                              label: locale.getA11yVariableValueLabel(label),
                              child: value)
                        ],
                      )
                    ])),
                if (_hasAdditionalInfo())
                  Semantics(
                      button: true,
                      focusable: true,
                      label: locale.a11yVariableInfoButtonLabel,
                      hint: locale.a11yVariableInfoButtonHint,
                      child: InfoButton(
                        title: label,
                        text: additionalInfoText!,
                      )),
              ]))),
    );
  }
}

class VariableWithLabelValue extends StatelessWidget {
  const VariableWithLabelValue({
    super.key,
    required this.value,
    required this.fractionDigits,
    required this.unit,
  });

  final double value;
  final int fractionDigits;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${value.toStringAsFixed(fractionDigits)}$unit',
      style: TextStyle(
          fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
          height: 1.35),
    );
  }
}

class InfoButton extends StatelessWidget {
  const InfoButton({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(Icons.info,
            color: Theme.of(context).colorScheme.inversePrimary),
        tooltip: locale.a11yVariableInfoButtonLabel,
        onPressed: () => {
              showModalBottomSheet<void>(
                context: context,
                showDragHandle: true,
                builder: (BuildContext context) {
                  return InfoBottomSheet(title: title, text: text);
                },
              )
            });
  }
}

class InfoBottomSheet extends StatelessWidget {
  const InfoBottomSheet({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: style.contentMaxWidth,
      height: screenWidth > 430 ? 340 : 400,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            style.contentLateralPadding, 0, style.contentLateralPadding, 20),
        child: ListView(children: [
          Column(children: [
            Row(children: [
              Header(
                text: title,
                paddingTop: 0,
              )
            ]),
            Row(children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                      child: Text(text,
                          style: Theme.of(context).textTheme.bodyMedium)))
            ])
          ]),
        ]),
      ),
    );
  }
}
