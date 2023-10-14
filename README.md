# [Sourdoc](https://sourdoc.duddu.dev)
[![Release](https://github.com/duddu/sourdoc/actions/workflows/release.yml/badge.svg)](https://github.com/duddu/sourdoc/actions/workflows/release.yml)
[![Version](https://img.shields.io/github/v/tag/duddu/sourdoc?label=Version&logo=semver&color=6B41C8&labelColor=2b3238)](https://github.com/duddu/sourdoc/releases/latest)
[![License](https://badgen.net/github/license/duddu/sourdoc?color=009688&label=License&labelColor=2b3238)](https://github.com/duddu/sourdoc/blob/main/LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-yellow.svg?labelColor=2b3238)](https://github.com/duddu/sourdoc/compare)

Your ultimate companion for perfect sourdough - Calculate every variable from mixing to fermentation for the ideal sourdough baking experience. Try it now:

[![Launch web app](https://img.shields.io/badge/Launch_web_app-red?logo=googlechrome&logoColor=white)](https://sourdoc.duddu.dev)
[![Download macOS app](https://img.shields.io/badge/Download_macOS_app-blue?logo=apple)](https://github.com/duddu/sourdoc/releases/download/v1.4.6/sourdoc.app.tgz)

## How it works

The user provides ambient temperature, final bread desired weight, hydration and salt levels, and gets in return all the relevant data automatically calculated: all the ingredients quantities, the recommended inoculation level and how much should the dough rise during fermentation.

![Sourdoc sample screenshot 1](https://raw.githubusercontent.com/duddu/sourdoc/main/docs/assets/web-home-screenshot_1.png)&emsp;
![Sourdoc sample screenshot 2](https://raw.githubusercontent.com/duddu/sourdoc/main/docs/assets/web-home-screenshot_2.png)

## CLI

The repository contains two simple dart scripts useful for updating maintainance files:

```bash
dart run cli/update_sitemap.dart
# Updates the lastmod field in the web sitemap.xml to the current datetime

dart run cli/bump_version.dart --increment patch
# Updates the VERSION file using semantic versioning. Supported increment values: patch|minor|major.
```

## Tech 

Made with Dart and Flutter.  
Built as native app for iOS and Android as well, but not published to the stores yet.

## Contribution

Feel free to raise an issue if you have any question or suggestions, or open a PR if you want to propose any change.

## License

Mozilla Public License 2.0  
© Davide Doronzo