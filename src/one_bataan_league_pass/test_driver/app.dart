import 'dart:io';

import 'package:flutter_driver/driver_extension.dart';
import 'package:one_bataan_league_pass/main_debug_dev.dart' as app;

void main() {
  enableFlutterDriverExtension(handler: (message) async {
    switch (message) {
      case 'getDevicePlatform':
        return Platform.operatingSystem;

      default:
        return null;
    }
  });

  app.main();
}
