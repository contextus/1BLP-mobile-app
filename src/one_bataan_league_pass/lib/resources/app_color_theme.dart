import 'dart:ui';

import 'package:flutter/material.dart';

// Class that holds custom app colors.
// Update this class if necessary.
class AppColorTheme {
  AppColorTheme({
    this.activeIconColor,
    this.inactiveIconColor,
    this.primaryTextColor,
    this.secondaryTextColor,
    this.tertiaryTextColor,
    this.shimmerBaseColor,
    this.shimmerHighLightColor,
  });

  final Color activeIconColor;
  final Color inactiveIconColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color tertiaryTextColor;
  final Color shimmerBaseColor;
  final Color shimmerHighLightColor;
}
