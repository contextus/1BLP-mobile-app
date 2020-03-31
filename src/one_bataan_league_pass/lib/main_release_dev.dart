import 'package:one_bataan_league_pass/service_locator.dart';
import 'package:one_bataan_league_pass/views/views.dart';
import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:one_bataan_league_pass_common/common.dart';
import 'package:flutter/material.dart';

/// Configure for release of dev environment.
void main() {
  AppConfiguration.configure(serverAddress: ApiConstants.devServerAddress, isAnalyticsEnabled: true);
  ServiceLocator.registerDependencies();
  runApp(ServiceLocator.resolve<AppView>());
}
