#### `Entities`
Classes that represents the business/domain data. These can be just PODOs (Plain Old Dart Objects), or it can be classes that have business logics in them such as validations. Entities inherit from the class `EntityBase`, or `EquatableEntityBase` if you need to check for equality between two class instances.

##### PODO Entity

```dart
class TodoEntity extends EntityBase {
  TodoEntity({this.id, this.name, this.description});

  final int id;
  final String name;
  final String description;
}
```

##### Equatable Entity

```dart
class TodoEntity extends EquatableEntityBase {
  TodoEntity({this.id, this.name, this.description});

  final int id;
  final String name;
  final String description;

  @override
  List<Object> get props => [id, name, description];

  bool isValid() {
    return (name?.isNotEmpty == true) 
           && (description?.isNotEmpty == true);
  }
}
```
- `EquatableEntityBase` inherits from the `Equatable` class from the [`equatable`](http://pub.dev/packages/equatable) package. It provides built in equality check of an object of the same class by overriding the `props` property. We can pass any class properties which will be used for comparison. In this case, we are using `id`, `name`, and `description` to check if a `TodoEntity` instance is equal to another.
- We also add a method `isValid()` that returns a `bool` whether the entity's `name` and `description` are not empty. This can be used in the UI later on to validate input fields.

#### `Mappers`
Mappers are used to map the fields from one type to another. They are used if we want to transform a data from the domain layer down to the data layer, and vice-versa.

It is important to know how the data flows within our application:

```
                        Data flows in
---------------------------------------------------------------------->
[Data Layer]   <----->   [Business/Domain Layer]   <----->   [UI Layer]

- Local Data            - Mappers                          - Views
- Web Services          - Managers                         - View Models
                        - Entities                         - Models
<----------------------------------------------------------------------
                        Data flows out
```
- If you haven't read about the data layer, go to [`data`](../one_bataan_league_pass_data/readme.md) and [`web_service`](../one_bataan_league_pass_web_service/readme.md)
- Data flows only in two directions, in and out. The business/domain layer acts as the glue between where the data is retrieved, and how the data will be presented.
  
There are 6 kinds of mappers for domain and data layers which you can inherit from:
- `EntityMapper<TEntity, TSource>` - Maps a `TEntity` from `TSource`.
- `DataContractMapper<TDataContract, TSource>` - Maps a `TDataContract` from `TSource`.
- `DataObjectMapper<TDataObject, TSource>` - Maps a [TDataObject] from `TSource`.
- `EntityDataContractMapper<TEntity, TDataContract`> - Maps a [TEntity] from `TDataContract`, and vice-versa.
- `EntityDataObjectMapper<TEntity, TDataObject`> - Maps a [TEntity] from `TDataObject`, and vice-versa.
- `EntityDataContractObjectMapper<TEntity, TDataObject, TDataContract>` - Maps `TEntity` from `TDataContract` or `TDataObject`, and vice-versa.
- There will be no mapping between data objects and data contracts.

Mappers that are used between the domain and data layer implicitly needs to define which classes to map:
- `TEntity` should inherit from `EntityBase`.
- `TDataContract` should inherit from `DataContractBase`.
- `TDataObject` should inherit from `DataClass` from the package [moor](pub.dev/packages/moor).

If we are to create a mapper for our to-do, which will map to/from domain layer and data layer, this will be our class:

```dart
class TodoMapper implements EntityDataContractObjectMapper<TodoEntity, TodoDataContract, TodoDataObject> {
  @override
  TodoDataContract toDataContract(TodoEntity source) {
    return TodoDataContract(
      id: source.id,
      name: source.name,
      description: source.description,
    );
  }

  @override
  TodoDataObject toDataObject(TodoEntity source) {
    return TodoDataObject(
      id: source.id,
      name: source.name,
      description: source.description,
    );
  }

  @override
  TodoEntity toEntityFromDataContract(TodoDataContract source) {
    return TodoEntity(
      id: source.id,
      name: source.name,
      description: source.description,
    );
  }

  @override
  TodoEntity toEntityFromDataObject(TodoDataObject source) {
    return TodoEntity(
      id: source.id,
      name: source.name,
      description: source.description,
    );
  }
}
```

#### `Managers`

These are classes that contain the core business/domain logics such as how the data will flow, and different use cases.

Say we have these use cases:
- *"I want to create a to-do."*
- *"I want to delete a to-do."*
- *"I want to retrieve a list of to-dos."*

Our manager will look like this:

```dart
class TodoManager {
  TodoManager(this._mapper, this._repository, this._webService);

  final TodoMapper _mapper;
  final TodoRepository _repository;
  final TodoWebService _webService;

  Stream<List<TodoEntity>> get todosStream async* {
    await for (final todoDataObjects in _repository.watchItems())
      yield todoDataObjects.map((t) => _mapper.toEntityFromDataObject(t)).toList();
  }

  Future<void> createTodo(TodoEntity newTodo) async {
    final newTodoDataContract = _mapper.toDataContract(newTodo);
    final newTodoDataObject = _mapper.toDataObject(newTodo);

    await _webService.createTodo(newTodoDataContract);
    await _repository.insertItem(newTodoDataObject);
  }

  Future<void> deleteTodo(TodoEntity todoToDelete) async {
    final todoToDeleteDO = _mapper.toDataObject(todoToDelete);

    await _webService.deleteTodo(todoToDelete.id);
    await _repository.deleteItem(todoToDeleteDO);
  }
}

```
- First, our `TodoManager` requires 3 parameters in its constructor. The mapper, the repository, and the web service. Instead of creating these instances within the classes, we are rather providing these dependencies. This is called the *Inversion of Control*. We invert the control to the consumer of `TodoManager` by providing the required dependencies it needs. This builds a loosely-coupled architecture that is easy to test and maintain.
- *"I want to create a to-do."* - We can create a to-do by using the method `createTodo()`, the entity will be coming from our UI layer. We convert our `TodoEntity` to a data contract and data object. We create a to-do by first sending a HTTP request to our server using `TodoWebService` and save it, next we cache the created to-do to our database using `TodoRepository`.
- *"I want to delete a to-do."* -  The same with creating a to-do, but we only call the `TodoWebService.deleteTodo()` and `TodoRepository.deleteItem()`.
- *"I want to retrieve a list of to-dos."* -  We can retrieve the existing list of to-do by watching our local database. We will use `TodoRepository.watchItems()` and listent to the Stream it emits, and map the list of `TodoDataObject` to a list of `TodoEntity` using our `TodoMapper`.