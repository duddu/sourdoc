import 'package:flutter/material.dart';
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/constants/style.dart' as style;

AppBar getAppBarWithTitle(BuildContext context, AppBarTitleWithAction title) {
  return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      automaticallyImplyLeading: false,
      centerTitle: true,
      titleSpacing: 0,
      title: title);
}

class AppBarTitleWithAction extends StatelessWidget {
  const AppBarTitleWithAction(
      {super.key,
      required this.title,
      this.logo = false,
      required this.action,
      this.backButton = false,
      this.backButtonTooltip});

  final Semantics title;
  final bool logo;
  final Semantics action;
  final bool backButton;
  final String? backButtonTooltip;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(
            style.contentLateralPadding + (backButton ? -15 : 29),
            0,
            style.contentLateralPadding - 15,
            0),
        child: Row(children: [
          if (backButton == true)
            Semantics(
                button: true,
                label: locale.a11yAppBarBackButtonLabel,
                hint: locale.a11yAppBarBackButtonHint,
                tooltip: backButtonTooltip,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    semanticLabel: locale.a11yAppBarBackButtonIconLabel,
                    color: Colors.white,
                  ),
                  color: Colors.white,
                  tooltip: backButtonTooltip,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
          Expanded(
              child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: logo
                    ? [
                        title,
                        const Padding(
                            padding: EdgeInsets.fromLTRB(6, 0, 0, 1),
                            child: Image(
                                image: AssetImage('assets/logo/logo.png'),
                                height: 34,
                                semanticLabel:
                                    locale.a11yAppBarHomeTitleLogoLabel)),
                      ]
                    : [title])
          ])),
          action,
        ]));
  }
}
