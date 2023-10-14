import 'dart:io';
import 'package:args/args.dart';
import 'package:git/git.dart';
import 'package:version/version.dart';

const String versionPath = 'VERSION';
const List<String> updateableFilesPaths = [
  versionPath,
  'web/index.html',
  'web/download-release-asset.html',
];

String getIncrementArgument(List<String> arguments) {
  final parser = ArgParser()
    ..addOption('increment',
        abbr: 'i', mandatory: true, allowed: ['patch', 'minor', 'major']);
  ArgResults argResults = parser.parse(arguments);
  return argResults['increment'];
}

Future<Version> getCurrentVersion() async {
  final File versionFile = File(versionPath);
  final String versionFileContent = await versionFile.readAsString();
  return Version.parse(versionFileContent);
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
  final Version currentVersion = await getCurrentVersion();
  final Version newVersion = getNewVersion(currentVersion, increment);
  for (var filePath in updateableFilesPaths) {
    final File file = File(filePath);
    final String fileContent = await file.readAsString();
    await file.writeAsString(fileContent.replaceAll(
        currentVersion.toString(), newVersion.toString()));
  }
  stdout.writeln(
      '✔️ Updated version from ${currentVersion.toString()} to ${newVersion.toString()}');
}

Future<void> main(List<String> arguments) async {
  try {
    final increment = getIncrementArgument(arguments);
    await writeNewVersion(increment);
    await runGit(['stage', ...updateableFilesPaths]);
  } catch (e) {
    stderr.writeln('🛑 $e');
    exit(1);
  }
}
