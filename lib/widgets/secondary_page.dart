import 'package:flutter/material.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final CenteredContainer versionInfoContainer =
        getVersionInfoContainer(context);

    return Scaffold(
        backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
            ? Theme.of(context).colorScheme.inversePrimary
            : null,
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
                  if (screenWidth <= style.mobileMaxScreenWidth)
                    versionInfoContainer
                ],
              )),
              if (screenWidth > style.mobileMaxScreenWidth) versionInfoContainer
            ]));
  }
}
