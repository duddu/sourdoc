import 'package:flutter/material.dart';
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/constants/routes.dart';
import 'package:sourdoc/widgets/app_bar_with_actions.dart';
import 'package:sourdoc/widgets/centered_container.dart';
import 'package:sourdoc/widgets/header.dart';

class GlossaryPage extends StatelessWidget {
  const GlossaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWithTitle(
          context,
          AppBarTitleWithAction(
              backButton: true,
              backButtonTooltip: locale.appBarGlossaryBackButtonTooltip,
              title: Semantics(
                  label: locale.a11yAppBarGlossaryTitleLabel,
                  child: const Text(locale.glossaryPageTitle,
                      style: TextStyle(color: Colors.white))),
              action: Semantics(
                  button: true,
                  label: locale.a11yAppBarGlossaryActionButtonLabel,
                  hint: locale.a11yAppBarGlossaryActionButtonHint,
                  tooltip: locale.appBarGlossaryActionButtonTooltip,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      semanticLabel:
                          locale.a11yAppBarGlossaryActionButtonIconLabel,
                      color: Colors.white,
                    ),
                    color: Colors.white,
                    tooltip: locale.appBarGlossaryActionButtonTooltip,
                    onPressed: () => backToHomePage(context),
                  )))),
      body: ListView(
        primary: true,
        padding: const EdgeInsets.only(bottom: 25),
        children: <CenteredContainer>[
          CenteredContainer(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(children: <Row>[
                const Row(children: <Header>[
                  Header(text: locale.variableLabelInoculation, paddingTop: 16)
                ]),
                const Row(children: <Expanded>[
                  Expanded(
                      child: Text(
                    locale.additionalInfoInoculation,
                  ))
                ]),
                const Row(children: <Header>[
                  Header(text: locale.variableLabelDoughRise)
                ]),
                const Row(children: <Expanded>[
                  Expanded(
                      child: Text(
                    locale.additionalInfoDoughRise,
                  ))
                ]),
                Row(children: <Expanded>[
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: TextButton(
                            onPressed: () => backToHomePage(context),
                            style: const ButtonStyle(
                                alignment: Alignment.centerLeft,
                                padding:
                                    MaterialStatePropertyAll(EdgeInsets.zero)),
                            child: const Text('< ${locale.backToHome}'),
                          )))
                ]),
              ]))
        ],
      ),
    );
  }
}