import 'dart:io';
import 'package:args/args.dart';
import 'package:version/version.dart';

const String versionPath = 'VERSION';

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
  final String versionFileContent = await versionFile.readAsString();
  final Version currentVersion = Version.parse(versionFileContent);
  final Version newVersion = getNewVersion(currentVersion, increment);
  await versionFile.writeAsString(newVersion.toString());
  stdout.writeln(
      '✔️ Updated version from ${currentVersion.toString()} to ${newVersion.toString()}');
}

Future<void> main(List<String> arguments) async {
  try {
    final increment = getIncrementArgument(arguments);
    return await writeNewVersion(increment);
  } catch (e) {
    stderr.writeln('🛑 $e');
    exit(1);
  }
}
