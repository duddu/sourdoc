import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sourdoc/constants/environment.dart' as environment;
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:url_launcher/url_launcher.dart';

const String _releaseUrl =
    '${environment.repoUrl}/releases/tag/v${environment.version}';
const String _commitUrl =
    '${environment.repoUrl}/tree/${environment.commitSha}';
const String _actionsRunUrl =
    '${environment.repoUrl}/actions/runs/${environment.buildNumber}';
const String _openIssueUrl = '${environment.repoUrl}/issues/new/choose';

class VersionInfoItem extends StatelessWidget {
  const VersionInfoItem(
      {super.key,
      required this.linkUrl,
      required this.linkText,
      this.itemLabel});

  final String? itemLabel;
  final String linkUrl;
  final String linkText;

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_commitUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        if (itemLabel != null) TextSpan(text: itemLabel),
        TextSpan(
            text: linkText,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                _launchUrl(linkUrl);
              })
      ]),
      textAlign: TextAlign.center,
    );
  }
}

class VersionInfo extends StatelessWidget {
  const VersionInfo({super.key});

  static const Text _divider = Text(' - ');

  @override
  Widget build(BuildContext context) {
    return Wrap(alignment: WrapAlignment.center, children: [
      VersionInfoItem(
        itemLabel: '©${DateTime.now().year.toString()} ${locale.title} ',
        linkText: 'v${environment.version}',
        linkUrl: _releaseUrl,
      ),
      _divider,
      const VersionInfoItem(
        itemLabel: '${locale.labelBuildNumber}: ',
        linkText: environment.buildNumber,
        linkUrl: _actionsRunUrl,
      ),
      _divider,
      VersionInfoItem(
        itemLabel: '${locale.labelCommit}: ',
        linkText: environment.commitSha.length > 7
            ? environment.commitSha.substring(0, 7)
            : environment.commitSha,
        linkUrl: _commitUrl,
      ),
      _divider,
      const VersionInfoItem(
        linkText: locale.reportIssue,
        linkUrl: _openIssueUrl,
      )
    ]);
  }
}
