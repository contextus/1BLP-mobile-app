import 'package:moor_flutter/moor_flutter.dart';

abstract class QueryExecutorProvider {
  QueryExecutor get queryExecutor;
}

class FlutterQueryExecutorProvider implements QueryExecutorProvider {
  @override
  QueryExecutor get queryExecutor => FlutterQueryExecutor.inDatabaseFolder(path: 'db_one_bataan_league_pass.sqlite');
}
