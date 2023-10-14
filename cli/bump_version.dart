import 'dart:io';
import 'package:args/args.dart';
import 'package:git/git.dart';
import 'package:version/version.dart';

const String versionPath = 'VERSION';
const String downloadReleaseAssetPath = 'web/download-release-asset.html';

String getIncrementArgument(List<String> arguments) {
  final parser = ArgParser()
    ..addOption('increment',
        abbr: 'i', mandatory: true, allowed: ['patch', 'minor', 'major']);
  ArgResults argResults = parser.parse(arguments);
  return argResults['increment'];
}

Version getNewVersion(Version currentVersion, String increment) {
  switch (increment) {
    case 'patch':
      return currentVersion.incrementPatch();
    case 'minor':
      return currentVersion.incrementMinor();
    case 'major':
      return currentVersion.incrementMajor();
    default:
      throw Exception('No matching version increment method');
  }
}

Future<void> writeNewVersion(String increment) async {
  final File versionFile = File(versionPath);
  final File downloadFile = File(downloadReleaseAssetPath);
  final String versionFileContent = await versionFile.readAsString();
  final String downloadFileContent = await downloadFile.readAsString();
  final Version currentVersion = Version.parse(versionFileContent);
  final Version newVersion = getNewVersion(currentVersion, increment);
  await versionFile.writeAsString(newVersion.toString());
  await downloadFile.writeAsString(downloadFileContent.replaceAll(
      currentVersion.toString(), newVersion.toString()));
  stdout.writeln(
      '✔️ Updated version from ${currentVersion.toString()} to ${newVersion.toString()}');
}

Future<void> main(List<String> arguments) async {
  try {
    final increment = getIncrementArgument(arguments);
    await writeNewVersion(increment);
    await runGit(['stage', versionPath, downloadReleaseAssetPath]);
  } catch (e) {
    stderr.writeln('🛑 $e');
    exit(1);
  }
}
