import 'dart:io';

import 'package:moor_flutter/moor_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

abstract class QueryExecutorProvider {
  QueryExecutor get queryExecutor;

  Future<void> createDatabase();
}

class FlutterQueryExecutorProvider implements QueryExecutorProvider {
  QueryExecutor _queryExecutor;
  @override
  QueryExecutor get queryExecutor => _queryExecutor;

  @override
  Future<void> createDatabase() async {
    final dbName = 'db_one_bataan_league_pass.sqlite';
    final dbFolder = await getTemporaryDirectory();
    final dbFile = File(join(dbFolder.path, dbName));
    final dbFileExists = await dbFile.exists();

    if (!dbFileExists) await dbFile.create(recursive: true);

    _queryExecutor = FlutterQueryExecutor(path: dbFile.path);
  }
}
