import 'package:flutter/material.dart';
import 'package:sourdoc/constants/style.dart' as style;

class AppBarTitle extends StatelessWidget {
  const AppBarTitle(
      {super.key, required this.title, this.icon, required this.action});

  final Semantics title;
  final Icon? icon;
  final Semantics action;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(style.contentLateralPadding + 30, 0,
            style.contentLateralPadding - 15, 0),
        child: Row(children: [
          Expanded(
              child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: icon != null
                    ? [
                        title,
                        Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: icon!)
                      ]
                    : [title])
          ])),
          action,
        ]));
  }
}
