import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor/moor.dart';

part 'app_database.g.dart';

// Run `flutter packages pub run build_runner build --delete-conflicting-outputs` in project folder to recreate/update models.

@UseMoor(tables: [])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor queryExecutor) : super(queryExecutor);

  @override
  int get schemaVersion => 1;
}
