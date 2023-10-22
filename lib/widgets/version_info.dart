import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sourdoc/constants/environment.dart' as environment;
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/widgets/centered_container.dart';
import 'package:url_launcher/url_launcher.dart';

const String _releaseUrl =
    '${environment.repoUrl}/releases/tag/v${environment.version}';
const String _commitUrl =
    '${environment.repoUrl}/tree/${environment.commitSha}';
const String _openIssueUrl = '${environment.repoUrl}/issues/new/choose';

class VersionInfoItem extends StatelessWidget {
  const VersionInfoItem({super.key, this.label, required this.value, this.url});

  final String? label;
  final String value;
  final String? url;

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch the url: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      style: Theme.of(context).textTheme.bodySmall,
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

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 9,
        runSpacing: 2,
        alignment: WrapAlignment.center,
        children: [
          VersionInfoItem(
            label: '©${DateTime.now().year.toString()} ${locale.title} ',
            value: 'v${environment.version}',
            url: _releaseUrl,
          ),
          const VersionInfoItem(
            label: '${locale.labelBuildNumber}: ',
            value: environment.buildNumber,
          ),
          VersionInfoItem(
            label: '${locale.labelCommit}: ',
            value: environment.commitSha.length > 7
                ? environment.commitSha.substring(0, 7)
                : environment.commitSha,
            url: _commitUrl,
          ),
          const VersionInfoItem(
            value: locale.reportIssue,
            url: _openIssueUrl,
          )
        ]);
  }
}

CenteredContainer getVersionInfoContainer(BuildContext context) =>
    CenteredContainer(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary.withAlpha(170),
          border:
              Border(top: BorderSide(width: 1, color: Colors.grey.shade300)),
        ),
        padding: EdgeInsets.fromLTRB(0, 18, 0,
            Theme.of(context).platform == TargetPlatform.iOS ? 25 : 18),
        child: const VersionInfo());
