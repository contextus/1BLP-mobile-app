import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/resources/app_theme.dart';

import 'app_color_theme.dart';

extension CustomColorExtension on ThemeData {
  /// Gets the custom theme depending on [ThemeData.brightness].

  AppColorTheme customTheme() {
    switch (brightness) {
      case Brightness.light:
        return AppTheme.appLightColorTheme;

      case Brightness.dark:
        return AppTheme.appDarkColorTheme;

      default:
        throw UnimplementedError('Unhandled theme $brightness');
    }
  }
}
