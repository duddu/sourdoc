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
  const VersionInfoItem({super.key, this.label, required this.value, this.url});

  final String? label;
  final String value;
  final String? url;

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
        if (label != null) TextSpan(text: label),
        TextSpan(
            text: value,
            style: url != null
                ? TextStyle(color: Theme.of(context).colorScheme.primary)
                : null,
            recognizer: url != null
                ? (TapGestureRecognizer()
                  ..onTap = () async {
                    _launchUrl(url!);
                  })
                : null)
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
        label: '©${DateTime.now().year.toString()} ${locale.title} ',
        value: 'v${environment.version}',
        url: _releaseUrl,
      ),
      _divider,
      const VersionInfoItem(
        label: '${locale.labelBuildNumber}: ',
        value: environment.buildNumber,
      ),
      _divider,
      VersionInfoItem(
        label: '${locale.labelCommit}: ',
        value: environment.commitSha.length > 7
            ? environment.commitSha.substring(0, 7)
            : environment.commitSha,
        url: _commitUrl,
      ),
      _divider,
      const VersionInfoItem(
        value: locale.reportIssue,
        url: _openIssueUrl,
      )
    ]);
  }
}
