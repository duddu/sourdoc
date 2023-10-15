import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sourdoc/constants/environment.dart' as environment;
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:url_launcher/url_launcher.dart';

final Uri _commitUrl =
    Uri.parse('${environment.repoUrl}/tree/${environment.commitSha}');
final Uri _openIssueUrl = Uri.parse('${environment.repoUrl}/issues/new/choose');

class VersionInfo extends StatelessWidget {
  const VersionInfo({super.key});

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_commitUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Row>[
      Row(children: <Expanded>[
        Expanded(
            child: Text(
                '©${DateTime.now().year.toString()} ${locale.title} v${environment.version}',
                textAlign: TextAlign.center)),
      ]),
      Row(children: <Expanded>[
        Expanded(
            child: Text.rich(
          TextSpan(children: [
            const TextSpan(text: '${locale.labelCommit}: '),
            TextSpan(
                text: environment.commitSha.length > 7
                    ? environment.commitSha.substring(0, 7)
                    : environment.commitSha,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    _launchUrl(_commitUrl);
                  })
          ]),
          textAlign: TextAlign.center,
        ))
      ]),
      Row(children: <Expanded>[
        Expanded(
            child: Text.rich(
          TextSpan(
              text: locale.reportIssue,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  _launchUrl(_openIssueUrl);
                }),
          textAlign: TextAlign.center,
        ))
      ])
    ]);
  }
}
