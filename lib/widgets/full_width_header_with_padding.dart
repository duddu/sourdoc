import 'package:flutter/material.dart';

class FullWidthHeaderWithPadding extends StatelessWidget {
  const FullWidthHeaderWithPadding({
    super.key,
    required this.text,
    this.paddingTop = 35,
  });

  final String text;
  final double paddingTop;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.fromLTRB(0, paddingTop, 0, 15),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 20, color: Theme.of(context).colorScheme.primary),
        textAlign: TextAlign.center,
      ),
    ));
  }
}
