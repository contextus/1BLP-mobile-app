import 'dart:io';

import 'package:one_bataan_league_pass_common/constants.dart';
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

      // Assert
      expect(health.status, HealthStatus.ok);
    });
  });

  group('HomeView', () {
    test('Verify empty state', () async {
      // Act
      await driver.waitFor(find.byValueKey(HomeViewKeyValues.emptyTodoListView));

      await screenshot('todo_empty_list');
    });

    test('Verify To-Do added using dialog', () async {
      for (var i = 1; i < 9; i++) {
        // Act
        await driver.waitFor(find.byValueKey(HomeViewKeyValues.addTodoBtn));
        await driver.tap(find.byValueKey(HomeViewKeyValues.addTodoBtn));

        await driver.tap(find.byValueKey(HomeViewKeyValues.addTodoDialogName));
        await driver.enterText('Test Name $i');

        await driver.tap(find.byValueKey(HomeViewKeyValues.addTodoDialogDesc));
        await driver.enterText('Test Description $i');

        await driver.tap(find.byValueKey(HomeViewKeyValues.addTodoDialogAddBtn));
        await driver.waitFor(find.byValueKey(HomeViewKeyValues.todoListView));

        await screenshot('todo_list$i');
      }
    }, timeout: Timeout(Duration(minutes: 1)));
  });
}
