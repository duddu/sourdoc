import 'package:flutter/material.dart';
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/constants/style.dart' as style;
import 'package:sourdoc/widgets/header.dart';

class VariableWithLabel extends StatelessWidget {
  const VariableWithLabel({
    super.key,
    required this.label,
    required this.value,
    this.additionalInfoText,
  });

  final String label;
  final String value;
  final String? additionalInfoText;

  bool _hasAdditionalInfo() =>
      additionalInfoText != null && additionalInfoText!.isNotEmpty;
  bool _isMobileDevice(BuildContext context) =>
      Theme.of(context).platform == TargetPlatform.android ||
      Theme.of(context).platform == TargetPlatform.iOS;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          height: _isMobileDevice(context) ? 46 : 44,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.inversePrimary,
                width: 2,
              ),
            ),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  '$label:',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.start,
                ),
                if (_hasAdditionalInfo())
                  Expanded(
                      flex: 0,
                      child: Semantics(
                          button: true,
                          focusable: true,
                          label: locale.a11yVariableInfoButtonLabel,
                          hint: locale.a11yVariableInfoButtonHint,
                          child: InfoButton(
                            title: label,
                            text: additionalInfoText!,
                          ))),
                Expanded(
                    child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.end,
                )),
              ],
            )
          ])),
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
      height: screenWidth > 430
          ? screenWidth > style.contentMaxWidth
              ? 260
              : 305
          : 405,
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
                      child: Text(text)))
            ])
          ]),
        ]),
      ),
    );
  }
}
