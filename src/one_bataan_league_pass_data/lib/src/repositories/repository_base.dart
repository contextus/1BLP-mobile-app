import 'package:one_bataan_league_pass_data/src/database/app_database.dart';
import 'package:moor/moor.dart';
import 'package:meta/meta.dart';

abstract class RepositoryBase<TTable extends Table, TDataObject extends DataClass>
    extends DatabaseAccessor<AppDatabase> {
  RepositoryBase(AppDatabase db) : super(db);

  Future<List<TDataObject>> selectAll() => select(table).get();

  Future<void> deleteAll() => delete(table).go();

  Future<TDataObject> selectSingle() => select(table).getSingle();

  Future<void> deleteItem(TDataObject dataObject) => delete(table).delete(dataObject as Insertable);

  Future<void> insertItem(TDataObject dataObject) => into(table).insert(dataObject as Insertable);

  Future<void> insertItems(List<TDataObject> dataObject) =>
      db.batch((b) => b.insertAll(table, dataObject as List<Insertable>));

  Stream<List<TDataObject>> watchItems() => select(table).watch();

  Future<void> updateItem(TDataObject dataObject) => update(table).replace(dataObject as Insertable);

  @protected
  TableInfo<TTable, TDataObject> get table => db.allTables.firstWhere((t) => t is TableInfo<TTable, TDataObject>);
}
