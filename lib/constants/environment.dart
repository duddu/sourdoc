const String version = String.fromEnvironment('VERSION', defaultValue: 'N/A');
const String buildNumber =
    String.fromEnvironment('BUILD_NUMBER', defaultValue: 'N/A');
const String commitSha =
    String.fromEnvironment('COMMIT_SHA', defaultValue: 'N/A');
const String repoUrl = String.fromEnvironment('REPO_URL');
