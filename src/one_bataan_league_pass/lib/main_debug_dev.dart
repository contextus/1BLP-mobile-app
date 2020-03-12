import 'package:one_bataan_league_pass/service_locator.dart';
import 'package:one_bataan_league_pass/view_models/app_view_model.dart';
import 'package:one_bataan_league_pass/views/views.dart';
import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:one_bataan_league_pass_common/runtime.dart';
import 'package:flutter/material.dart';

/// Configure for debugging of dev environment.
void main() {
  AppConfiguration.configure(serverAddress: ApiConstants.devServerAddress);
  runApp(AppView(AppViewModel(ServiceLocator())));
}
