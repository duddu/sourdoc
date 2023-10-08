import 'package:flutter/material.dart';
import 'package:sourdoc/constants/environment.dart' as environment;
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/constants/style.dart' as style;

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        title: Padding(
            padding:
                const EdgeInsets.only(left: style.contentLateralPadding + 44),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Semantics(
                  label: locale.a11yAppBarHelpTitleLabel,
                  child: const Text(locale.helpPageTitle,
                      style: TextStyle(color: Colors.white))),
            ])),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: style.contentLateralPadding),
            child: Semantics(
                button: true,
                label: locale.a11yAppBarHelpCloseButtonLabel,
                hint: locale.a11yAppBarHelpCloseButtonHint,
                tooltip: locale.appBarHelpCloseButtonTooltip,
                child: IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    semanticLabel: locale.a11yAppBarHelpCloseButtonIconLabel,
                    color: Colors.white,
                  ),
                  color: Colors.white,
                  tooltip: locale.appBarHelpCloseButtonTooltip,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
          )
        ],
      ),
      body: ListView(
        primary: true,
        padding: const EdgeInsets.all(style.contentLateralPadding),
        children: const <Column>[
          Column(children: <Row>[
            Row(children: [
              Expanded(
                  child: Text('${locale.labelVersion}: ${environment.version}',
                      textAlign: TextAlign.center))
            ]),
            Row(children: [
              Expanded(
                  child: Text('${locale.labelCommit}: ${environment.commitSha}',
                      textAlign: TextAlign.center)),
            ])
          ])
        ],
      ),
    );
  }
}
