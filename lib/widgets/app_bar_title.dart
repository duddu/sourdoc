import 'package:flutter/material.dart';
import 'package:sourdoc/constants/style.dart' as style;

class AppBarTitle extends StatelessWidget {
  const AppBarTitle(
      {super.key, required this.titleWidgets, required this.actionWidget});

  final List<Widget> titleWidgets;
  final Widget actionWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(style.contentLateralPadding + 30, 0,
            style.contentLateralPadding - 13, 0),
        child: Row(children: [
          Expanded(
              child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: titleWidgets)
          ])),
          actionWidget,
        ]));
  }
}
