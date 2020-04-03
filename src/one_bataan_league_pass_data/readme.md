#### `Database and Data Objects`

For the database, we use [moor](pub.dev/packages/moor) to generate our database classes. Data object classes represents these database tables.

##### Creating the Database and Data Objects

Let's say we have this to-dos table schema:

|`id`|`name`|`description`|
|----|---|---|
|1|To-do Name|First to-do|
|2|To-do Name|Second to-do|

- `id` is the `primary_key`, type `int`, and `auto_increment`.
- `name` is type `varchar`.
- `description` is `varchar`.

First, we define our database table class `Todo`. This will extend `Table` from the moor package:

```dart
@DataClassName('TodoDataObject')
class Todos extends Table {
  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get description => text()();
}
```
- We annotate the class with `@DataClassName` and pass the name of the data object class that will be generated later on.
- Override the `primaryKey` property and we pass the column that will be used as the `primary_key` of the table. Here we pass `id`.

Next, we create our database class:

```dart
...
part 'app_database.g.dart';

@UseMoor(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutorProvider databaseProvider) : super(databaseProvider.queryExecutor);

  @override
  int get schemaVersion => 1;
}
```
- We annotate the class `@UseMoor` and pass a list of database table class that will be created in the database. Here we use the `Todos` class.
- The `_$AppDatabase` class will be generated when we run the build runner from the moor package.
- `app_database.g.dart` will be generated and don't forget to put the `part 'app_database.g.dart'` on top.

Generate `app_database.g.dart` by running the command in the project (data) folder:

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```
- This will generate the needed file. Re-run this command of you have changes in your database or database table classes.

##### Query executor provider

The `AppDatabase` constructor takes a `QueryExecutorProvider` object.

`QueryExecutorProvider` is an abstract class, when extended, allows the inheriting class to define what type of `QueryExecutor` will be used. 

For this project we use the following class:

```dart
class FlutterQueryExecutorProvider implements QueryExecutorProvider {
  @override
  QueryExecutor get queryExecutor => FlutterQueryExecutor.inDatabaseFolder(path: 'db_app_name.sqlite');
}
```
- Provides a `QueryExecutor` for Flutter by passing the name of the database file that will be created in the platform we are running on.

#### `Repositories`
The abstract class `RepositoryBase<TTable, TDataObject`, where `TTable` is the database table class and `TDataObject` is the data object class, allows us to perform CRUD methods on a database table.

##### Creating a repository

If we want to access the table `Todo`, we can do so by creating a class:

```dart
class TodoRepository extends RepositoryBase<Todos, TodoDataObject> {
  TodoRepository(AppDatabase db) : super(db);
}
```
- `RepositoryBase` will provide all the methods for CRUD: `inserItem`, `selectAll`, `updateItem`, and `deleteItem`.
- You can also watch the repository by using `watchItems`, which emits a `Stream<List<TDataObject>>` whenever the database table changes (i.e. insert/update/delete).

#### `Cache`
