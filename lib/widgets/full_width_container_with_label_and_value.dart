import 'package:flutter/material.dart';

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
          Expanded(
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,
            ),
          ),
          if (additionalInfoText != null && additionalInfoText!.isNotEmpty)
            Expanded(
                flex: 0,
                child: InfoButton(
                  text: additionalInfoText!,
                )),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}

class InfoButton extends StatelessWidget {
  const InfoButton({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => {
        showModalBottomSheet<void>(
          context: context,
          showDragHandle: true,
          builder: (BuildContext context) {
            return SizedBox(
              height: 180,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                        child: Text(text)),
                  ],
                ),
              ),
            );
          },
        )
      },
      icon:
          Icon(Icons.info, color: Theme.of(context).colorScheme.inversePrimary),
    );
  }
}
