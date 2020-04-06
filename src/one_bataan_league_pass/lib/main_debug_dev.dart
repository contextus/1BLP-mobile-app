import 'package:flutter/services.dart';
import 'package:one_bataan_league_pass/app_initializer.dart';
import 'package:one_bataan_league_pass/views/views.dart';
import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:one_bataan_league_pass_common/common.dart';
import 'package:flutter/material.dart';

/// Configure for debugging of dev environment.
void main() {
  AppConfiguration.configure(serverAddress: ApiConstants.devServerAddress);
  runApp(AppView(AppInitializer()));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
