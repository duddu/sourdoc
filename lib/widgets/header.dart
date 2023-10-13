import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.text,
    this.small = false,
    this.paddingTop = 20,
  });

  final String text;
  final bool small;
  final double paddingTop;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.fromLTRB(0, paddingTop, 0, 5),
      child: Semantics(
          header: true,
          child: Text(
            text,
            style: TextStyle(
                fontSize: small ? 16 : 20,
                color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.start,
          )),
    ));
  }
}
