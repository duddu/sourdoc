# [Sourdoc](https://sourdoc.duddu.dev)
[![Release](https://github.com/duddu/sourdoc/actions/workflows/release.yml/badge.svg)](https://github.com/duddu/sourdoc/actions/workflows/release.yml)
[![Version](https://img.shields.io/github/v/tag/duddu/sourdoc?label=Version&logo=semver&color=6B41C8&labelColor=2b3238)](https://github.com/duddu/sourdoc/releases/latest)
[![License](https://badgen.net/github/license/duddu/sourdoc?color=009688&label=License&labelColor=2b3238)](https://github.com/duddu/sourdoc/blob/main/LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-yellow.svg?labelColor=2b3238)](https://github.com/duddu/sourdoc/compare)

Your ultimate companion for perfect sourdough - Calculate every variable from mixing to fermentation for the ideal sourdough baking experience. Try it now:

[![Launch web app](https://img.shields.io/badge/Launch_web_app-red?logo=googlechrome&logoColor=white)](https://sourdoc.duddu.dev)
[![Download Android app](https://img.shields.io/badge/Download_Android_app-silver?logo=android&logoColor=white&color=008f62)](https://sourdoc.duddu.dev/download-release-asset.html?build=apk)
[![Download macOS app](https://img.shields.io/badge/Download_macOS_app-silver?logo=apple&logoColor=grey)](https://sourdoc.duddu.dev/download-release-asset.html?build=macos)
[![Download Windows app](https://img.shields.io/badge/Download_Windows_app-0061bb?logo=windows&logoColor=white)](https://sourdoc.duddu.dev/download-release-asset.html?build=windows)
[![Download Linux app](https://img.shields.io/badge/Download_Linux_app-grey?logo=linux&logoColor=white)](https://sourdoc.duddu.dev/download-release-asset.html?build=linux)

## How it works

The user provides ambient temperature, final bread desired weight, hydration and salt levels, and gets in return all the relevant data automatically calculated: all the ingredients quantities, the recommended inoculation level and how much should the dough rise during bulk fermentation.

<img alt="Sourdoc sample screenshot 1" src="https://raw.githubusercontent.com/duddu/sourdoc/main/docs/assets/web-home-screenshot_1.png" width=360>&emsp;
<img alt="Sourdoc sample screenshot 2" src="https://raw.githubusercontent.com/duddu/sourdoc/main/docs/assets/web-home-screenshot_2.png" width=360>

### Notes about the calculation

Sourdoc doesn't simply use the baker's formula to calculate the ingredients quantities, assince that doesn't take into account the ambient temperature; we use instead a more appropriate formula specific to sourdough baking: 

```go
b = f - f * h - f * i - f * s
// b: desired bread loaf weight
// f: flour weight
// h: hydration level (percentage of flour)
// s: salt level (percentage of flour)
```

For a detailed explanation, see [here](https://sourdoc.duddu.dev/help).

## CLI

The repository contains two simple dart scripts useful for updating maintainance files:

```bash
dart run cli/update_sitemap.dart
# Updates the lastmod field in the web sitemap.xml to the current datetime

dart run cli/bump_version.dart --increment patch
# Updates the VERSION file using semantic versioning. Supported increment values: patch|minor|major.
```

## Tech 

Made with Dart and Flutter, supporting multi-platform build. Will likely be released on the iOS and Android stores in the future. 

## Contribution

Feel free to raise an issue if you have any question or suggestions, or open a PR if you want to propose any change.