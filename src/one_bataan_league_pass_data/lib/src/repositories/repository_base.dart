import 'package:one_bataan_league_pass_common/common.dart';
import 'package:one_bataan_league_pass_data/src/database/app_database.dart';
import 'package:moor/moor.dart';

/// Provides CRUD methods for database table [TTable].
abstract class RepositoryBase<TTable extends Table, TDataObject extends DataClass>
    extends DatabaseAccessor<AppDatabase> {
  RepositoryBase(AppDatabase db) : super(db);

  /// Selects all items in [TTable] and returns a list of [TDataObject].
  Future<List<TDataObject>> selectAll() => select(table).get();

  /// Deletes all items in [TTable].
  Future<void> deleteAll() => delete(table).go();

  /// Similar to [selectAll], but returns one item.
  ///
  /// If multiple rows are in [TTable], this method will throw an exception.
  Future<TDataObject> selectSingle() => select(table).getSingle();

  /// Deletes [dataObject] from [TTable].
  Future<void> deleteItem(TDataObject dataObject) => delete(table).delete(dataObject as Insertable);

  /// Inserts [dataObject] to [TTable].
  ///
  /// Throws an exception if there is an existing row in [TTable] with the same
  /// primary key as [dataObject].
  Future<void> insertItem(TDataObject dataObject) => into(table).insert(dataObject as Insertable);

  /// Inserts a list of [TDataObject] to [TTable].
  ///
  /// Throws an exception if there is an existing row in [TTable] with the same
  /// primary key with any item in [dataObjects].
  Future<void> insertItems(List<TDataObject> dataObjects) =>
      db.batch((b) => b.insertAll(table, dataObjects as List<Insertable>));

  /// Creates an auto-updating stream of the result that emits new items whenever
  /// any table used in this statement changes.
  Stream<List<TDataObject>> watchItems() => select(table).watch();

  /// Updates an existing row that matches [dataObject] with new fields.
  Future<void> updateItem(TDataObject dataObject) => update(table).replace(dataObject as Insertable);

  /// Gets the table info from the database.
  /// 
  /// Used in running different statements.
  @nonVirtual
  @protected
  TableInfo<TTable, TDataObject> get table => db.allTables.firstWhere((t) => t is TableInfo<TTable, TDataObject>);
}
