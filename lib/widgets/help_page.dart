import 'package:flutter/material.dart';
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/constants/style.dart' as style;
import 'package:sourdoc/widgets/app_bar_title.dart';
import 'package:sourdoc/widgets/version_info.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          automaticallyImplyLeading: false,
          centerTitle: true,
          titleSpacing: 0,
          title: AppBarTitle(
              titleWidgets: [
                Semantics(
                    label: locale.a11yAppBarHelpTitleLabel,
                    child: const Text(locale.helpPageTitle,
                        style: TextStyle(color: Colors.white)))
              ],
              actionWidget: Semantics(
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
                  )))),
      body: ListView(
        primary: true,
        padding: const EdgeInsets.all(style.contentLateralPadding),
        children: const <VersionInfo>[VersionInfo()],
      ),
    );
  }
}
