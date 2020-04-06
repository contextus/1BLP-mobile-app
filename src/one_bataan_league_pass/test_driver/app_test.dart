import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;
  String screenshotDir;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
    final platform = await driver.requestData('getDevicePlatform');
    screenshotDir = 'test_driver_screenshots/$platform';
    await Directory(screenshotDir).create(recursive: true);
  });

  tearDownAll(() async => await driver.close());

  Future<void> screenshot(String fileName) async {
    print('Taking screenshot...');
    final bytes = await driver.screenshot();
    final file = File('$screenshotDir/$fileName.png');
    await file.writeAsBytes(bytes);
  }

  group('Initialization', () {
    test('Check flutter driver health', () async {
      // Act
      final health = await driver.checkHealth();
      
      await screenshot('initialized');

      // Assert
      expect(health.status, HealthStatus.ok);
    });
  });
}
