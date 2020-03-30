import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:one_bataan_league_pass/views/views.dart';
import 'package:flutter/material.dart';

class AppViewKeys {
  static const view = Key(AppViewKeyValues.view);
  static const splashWidget = Key(AppViewKeyValues.splashWidget);
  static final navigator = GlobalKey<NavigatorState>();
}

class MainTabViewKeys {
  static final tabNavigator = GlobalKey<MainTabViewState>();
}
