import 'package:flutter/material.dart';

const String homePagePath = '/';
const String helpPagePath = '/help';
const String glossaryPagePath = '/help/glossary';

void backToHomePage(BuildContext context) {
  Navigator.popUntil(context, (route) => route.settings.name == homePagePath);
}
