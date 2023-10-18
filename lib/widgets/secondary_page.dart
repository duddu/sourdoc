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
                  CenteredContainer(
                      padding: const EdgeInsets.fromLTRB(0, 13, 0, 26),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(children: <Row>[
                        Row(children: <TextButton>[
                          TextButton(
                            onPressed: () => backToHomePage(context),
                            style: ButtonStyle(
                                alignment: Alignment.centerLeft,
                                textStyle: MaterialStateProperty.all(
                                    Theme.of(context).textTheme.bodyMedium),
                                padding: const MaterialStatePropertyAll(
                                    EdgeInsets.zero)),
                            child: const Text('< ${locale.backToHome}'),
                          )
                        ])
                      ])),
                  if (style.isMobileScreenWidth(context)) versionInfoContainer
                ],
              )),
              if (!style.isMobileScreenWidth(context)) versionInfoContainer
            ]));
  }
}
