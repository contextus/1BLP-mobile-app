import 'package:one_bataan_league_pass_data/src/database/app_database.dart';
import 'package:one_bataan_league_pass_data/src/repositories/repository_base.dart';

class TodoRepository extends RepositoryBase<Todos, TodoDataObject> {
  TodoRepository(AppDatabase db) : super(db);
}
