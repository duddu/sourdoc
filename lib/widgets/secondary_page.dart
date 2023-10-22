import 'package:flutter/material.dart';
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/constants/routes.dart';
import 'package:sourdoc/constants/style.dart' as style;
import 'package:sourdoc/widgets/centered_container.dart';
import 'package:sourdoc/widgets/version_info.dart';

class SecondaryPage extends StatelessWidget {
  const SecondaryPage(
      {super.key, required this.appBar, required this.listViewChildren});

  final AppBar appBar;
  final List<CenteredContainer> listViewChildren;

  final int maxHeightFixedVersionInfo = 600;

  @override
  Widget build(BuildContext context) {
    final CenteredContainer versionInfoContainer =
        getVersionInfoContainer(context);

    return Scaffold(
        appBar: appBar,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: ListView(
                primary: true,
                padding: EdgeInsets.zero,
                children: <CenteredContainer>[
                  ...listViewChildren,
                  const CenteredContainer(
                      padding: EdgeInsets.fromLTRB(0, 13, 0, 26),
                      child: Column(children: <Row>[
                        Row(children: <BackToHomePageTextButton>[
                          BackToHomePageTextButton()
                        ])
                      ])),
                  if (style.isMobileScreenWidth(context) ||
                      MediaQuery.of(context).size.height <=
                          maxHeightFixedVersionInfo)
                    versionInfoContainer
                ],
              )),
              if (!style.isMobileScreenWidth(context) &&
                  MediaQuery.of(context).size.height >
                      maxHeightFixedVersionInfo)
                versionInfoContainer
            ]));
  }
}

class BackToHomePageTextButton extends StatelessWidget {
  const BackToHomePageTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
        button: true,
        label: locale.backToHome,
        hint: locale.a11yAppBarBackToHomePageButtonHint,
        child: TextButton(
          isSemanticButton: true,
          onPressed: () => backToHomePage(context),
          style: ButtonStyle(
              alignment: Alignment.centerLeft,
              textStyle: MaterialStateProperty.all(
                  Theme.of(context).textTheme.bodyMedium),
              padding: const MaterialStatePropertyAll(EdgeInsets.zero)),
          child: Row(children: [
            Icon(
              Icons.arrow_back_rounded,
              size: Theme.of(context).textTheme.bodyMedium?.fontSize,
            ),
            const Text(' ${locale.backToHome}')
          ]),
        ));
  }
}
