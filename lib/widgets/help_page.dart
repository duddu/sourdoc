import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/constants/routes.dart';
import 'package:sourdoc/widgets/app_bar_with_actions.dart';
import 'package:sourdoc/widgets/centered_container.dart';
import 'package:sourdoc/widgets/header.dart';
import 'package:sourdoc/widgets/version_info.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWithTitle(
          context,
          AppBarTitleWithAction(
              backButton: true,
              backButtonTooltip: locale.appBarHelpBackButtonTooltip,
              title: Semantics(
                  label: locale.a11yAppBarHelpTitleLabel,
                  child: const Text(locale.helpPageTitle,
                      style: TextStyle(color: Colors.white))),
              action: Semantics(
                  button: true,
                  label: locale.a11yAppBarHelpActionButtonLabel,
                  hint: locale.a11yAppBarHelpActionButtonHint,
                  tooltip: locale.appBarHelpActionButtonTooltip,
                  child: IconButton(
                    icon: const Icon(
                      Icons.menu_book_rounded,
                      semanticLabel: locale.a11yAppBarHelpActionButtonIconLabel,
                      color: Colors.white,
                    ),
                    color: Colors.white,
                    tooltip: locale.appBarHelpActionButtonTooltip,
                    onPressed: () {
                      Navigator.pushNamed(context, glossaryPagePath);
                    },
                  )))),
      body: ListView(
        primary: true,
        padding: const EdgeInsets.only(bottom: 25),
        children: <CenteredContainer>[
          CenteredContainer(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.grey.shade300)),
              ),
              child: Column(children: <Row>[
                Row(children: <Expanded>[
                  Expanded(
                      child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: locale.title,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              backToHomePage(context);
                            }),
                      const TextSpan(text: ' '),
                      const TextSpan(text: locale.appendixHowItWorksFragment1),
                      const TextSpan(text: ' '),
                      TextSpan(
                          text: locale.glossaryPageTitle,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, glossaryPagePath);
                            }),
                      const TextSpan(text: locale.appendixHowItWorksFragment2),
                    ]),
                  ))
                ]),
                const Row(children: <Expanded>[
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            locale.appendixHowItWorksFormula,
                            semanticsLabel:
                                locale.a11yAppendixHowItWorksFormula,
                            style: TextStyle(fontStyle: FontStyle.italic),
                          )))
                ]),
                const Row(children: <Header>[
                  Header(
                    text: locale.headerBakerFormulaDifference,
                    paddingTop: 14,
                  )
                ]),
                const Row(children: <Expanded>[
                  Expanded(
                      child: Text(
                    locale.appendixBakerFormulaDifference,
                  ))
                ]),
                Row(children: <Expanded>[
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: TextButton(
                            onPressed: () => backToHomePage(context),
                            style: const ButtonStyle(
                                alignment: Alignment.centerLeft,
                                padding:
                                    MaterialStatePropertyAll(EdgeInsets.zero)),
                            child: const Text('< ${locale.backToHome}'),
                          )))
                ]),
              ])),
          const CenteredContainer(
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.only(top: 20),
              child: VersionInfo())
        ],
      ),
    );
  }
}
