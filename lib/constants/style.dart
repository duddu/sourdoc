import 'package:flutter/material.dart';

const double contentLateralPadding = 25;
const double contentMaxWidth = 590;
const double mobileMaxScreenWidth = 480;

bool isMobileScreenWidth(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  return screenWidth <= mobileMaxScreenWidth;
}
