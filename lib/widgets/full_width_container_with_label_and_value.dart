import 'package:flutter/material.dart';
import 'package:sourdoc/constants/style.dart' as style;
import 'package:sourdoc/widgets/full_width_header_with_padding.dart';

class FullWidthContainerWithLabelAndValue extends StatelessWidget {
  const FullWidthContainerWithLabelAndValue({
    super.key,
    required this.label,
    required this.value,
    this.additionalInfoText,
  });

  final String label;
  final String value;
  final String? additionalInfoText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.inversePrimary,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Text(
            '$label:',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.start,
          ),
          if (additionalInfoText != null && additionalInfoText!.isNotEmpty)
            Expanded(
                flex: 0,
                child: InfoButton(
                  title: label,
                  text: additionalInfoText!,
                )),
          Expanded(
              child: Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.end,
          )),
        ],
      ),
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
        icon: Icon(Icons.info,
            color: Theme.of(context).colorScheme.inversePrimary),
        onPressed: () => {
              showModalBottomSheet<void>(
                context: context,
                showDragHandle: true,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          style.viewLateralPadding,
                          0,
                          style.viewLateralPadding,
                          20),
                      child: ListView(children: <Widget>[
                        Row(children: [
                          FullWidthHeaderWithPadding(
                            text: title,
                            paddingTop: 0,
                          )
                        ]),
                        Row(children: [
                          Expanded(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 20),
                                  child: Text(text)))
                        ]),
                      ]),
                    ),
                  );
                },
              )
            });
  }
}
