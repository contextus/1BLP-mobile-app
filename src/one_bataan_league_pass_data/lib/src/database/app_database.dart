import 'package:one_bataan_league_pass_data/src/database/query_executor_provider.dart';
import 'package:moor/moor.dart';

part 'app_database.g.dart';

// Run `flutter packages pub run build_runner build --delete-conflicting-outputs` in project folder to recreate/update models.

@UseMoor(tables: [])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutorProvider databaseProvider) : super(databaseProvider.queryExecutor);

  @override
  int get schemaVersion => 1;
}