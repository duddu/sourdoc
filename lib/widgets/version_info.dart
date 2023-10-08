import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sourdoc/constants/environment.dart' as environment;
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:url_launcher/url_launcher.dart';

final Uri _commitUrl =
    Uri.parse('${environment.repoUrl}/tree/${environment.commitSha}');

class VersionInfo extends StatelessWidget {
  const VersionInfo({super.key});

  Future<void> _launchCommitUrl() async {
    if (!await launchUrl(_commitUrl, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_commitUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Row>[
      const Row(children: <Expanded>[
        Expanded(
            child: Text('${locale.labelVersion}: ${environment.version}',
                textAlign: TextAlign.center))
      ]),
      Row(children: <Expanded>[
        Expanded(
            child: Text.rich(
          TextSpan(children: [
            const TextSpan(text: '${locale.labelCommit}: '),
            TextSpan(
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: Theme.of(context).colorScheme.primary),
                text: environment.commitSha.length > 7
                    ? environment.commitSha.substring(0, 7)
                    : environment.commitSha,
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    _launchCommitUrl();
                  })
          ]),
          textAlign: TextAlign.center,
        ))
      ])
    ]);
  }
}
