import 'dart:io';
import 'package:git/git.dart';

const String sitemapPath = 'web/sitemap.xml';

String getNewDate() {
  return '${DateTime.now().toIso8601String().substring(0, 19)}+00:00';
}

Future<void> writeNewSitemap(String newDate) async {
  final File sitemapFile = File(sitemapPath);
  final String sitemapFileContent = await sitemapFile.readAsString();
  final String newSitemapFileContent = sitemapFileContent
      .replaceAllMapped(RegExp(r'<lastmod>.+</lastmod>'), (match) {
    return '<lastmod>$newDate</lastmod>';
  });
  await sitemapFile.writeAsString(newSitemapFileContent);
  stdout.writeln('✔️ Updated lastmod to $newDate');
}

Future<void> main(List<String> arguments) async {
  try {
    final newDate = getNewDate();
    await writeNewSitemap(newDate);
    await runGit(['stage', sitemapPath]);
  } catch (e) {
    stderr.writeln('🛑 $e');
    exit(1);
  }
}
