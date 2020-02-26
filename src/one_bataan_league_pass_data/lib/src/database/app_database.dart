import 'package:one_bataan_league_pass_data/src/database/query_executor_provider.dart';
import 'package:moor/moor.dart';

part 'app_database.g.dart';

// Run `flutter packages pub run build_runner build --delete-conflicting-outputs` in project folder to recreate/update models.

@UseMoor(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutorProvider databaseProvider) : super(databaseProvider.queryExecutor);

  @override
  int get schemaVersion => 1;
}

@DataClassName('TodoDataObject')
class Todos extends Table {
  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get description => text()();
}
