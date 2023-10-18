import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/constants/style.dart' as style;
import 'package:sourdoc/constants/routes.dart';
import 'package:sourdoc/widgets/app_bar_with_actions.dart';
import 'package:sourdoc/widgets/centered_container.dart';
import 'package:sourdoc/widgets/header.dart';
import 'package:sourdoc/widgets/secondary_page.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SecondaryPage(
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
                        semanticLabel:
                            locale.a11yAppBarHelpActionButtonIconLabel,
                        color: Colors.white,
                      ),
                      color: Colors.white,
                      tooltip: locale.appBarHelpActionButtonTooltip,
                      onPressed: () {
                        Navigator.pushNamed(context, glossaryPagePath);
                      },
                    )))),
        listViewChildren: <CenteredContainer>[
          CenteredContainer(
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(children: <Row>[
                Row(children: <Expanded>[
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: Text.rich(
                            style: Theme.of(context).textTheme.bodyMedium,
                            TextSpan(children: [
                              TextSpan(
                                  text: locale.title,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      backToHomePage(context);
                                    }),
                              const TextSpan(text: ' '),
                              const TextSpan(
                                  text: locale.appendixHowItWorksFragment1),
                              const TextSpan(text: ' '),
                              TextSpan(
                                  text: locale.glossaryPageTitle,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, glossaryPagePath);
                                    }),
                              const TextSpan(
                                  text: locale.appendixHowItWorksFragment2),
                            ]),
                          )))
                ]),
                Row(children: <Expanded>[
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth > style.contentMaxWidth
                                  ? 80
                                  : 50),
                          child: Text(
                            locale.appendixHowItWorksFormula,
                            semanticsLabel:
                                locale.a11yAppendixHowItWorksFormula,
                            style: TextStyle(
                              fontFamily: 'serif',
                              fontStyle: FontStyle.italic,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .fontSize,
                              color: Colors.grey.shade800,
                            ),
                            textAlign: TextAlign.center,
                          )))
                ]),
                const Row(children: <Header>[
                  Header(
                    text: locale.headerBakerFormulaDifference,
                    paddingTop: 15,
                  )
                ]),
                Row(children: <Expanded>[
                  Expanded(
                      child: Text(
                    locale.appendixBakerFormulaDifference,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ))
                ]),
              ])),
        ]);
  }
}
