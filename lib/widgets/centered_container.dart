import 'package:flutter/material.dart';
import 'package:sourdoc/constants/style.dart' as style;

class CenteredContainer extends StatelessWidget {
  const CenteredContainer({
    super.key,
    required this.child,
    this.decoration,
    this.padding,
  });

  final Widget child;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: decoration,
        padding: padding,
        child: Center(
            child: SizedBox(
                width: style.contentMaxWidth,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: style.contentLateralPadding),
                    child: child))));
  }
}
