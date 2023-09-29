import 'package:flutter/material.dart';

class FullWidthContainerWithLabelAndValue extends StatelessWidget {
  const FullWidthContainerWithLabelAndValue({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      decoration: BoxDecoration(
        // color: Colors.amber,
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
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
