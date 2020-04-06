Before you read this part, it is important to read the following first:
- [`web_service`](../one_bataan_league_pass_web_service/readme.md)
- [`data`](../one_bataan_league_pass_data/readme.md)
- [`business`](../one_bataan_league_pass_business/readme.md)

#### `Models, Views, and View Models`

As a state management solution for this project, we will use the MVVM pattern so that we could implement a clean, loosely-coupled application that can be easy to maintain and test.

We will be using the package [`arch`](pub.dev/packages/arch) to help us implement the MVVM pattern.

##### Reactive style

Flutter heavily relies on a reactive style of building UIs, where the UI rebuilds whenever the state changes.

In our implementation, our states will be the models and view models.

##### Models

Models defines a single part of a whole state in a view model, like list items, and sometimes extends the `ChangeNotifier` class.

The `ListenableModel` class, from the [`arch`](pub.dev/packages/arch) package, extends the `ChangeNotifier` class.

By definition, `ChangeNotifier` notifies clients when the object has changed using the method `notifyListeners()`.

For our to-do example, this will be our `TodoModel` class:

```dart
class TodoModel extends ListenableModel {
  TodoModel({String name, String description})
      : _name = name,
        _description = description;

  String _name;
  String get name => _name;
  set name(String value) {
    if (_name != value) {
      _name = value;
      notifyListeners();
    }
  }

  String _description;
  String get description => _description;
  set description(String value) {
    if (_description != value) {
      _description = value;
      notifyListeners();
    }
  }
}
```
- We only call `notifyListeners()` when the new value of property does not match the current value.

##### `Views and View Models`

Describes the UI to be presented. Each view has a view model. There are no business logics here, we only assign callbacks and properties which are found in the view models.

Below is the view showing a list of to-dos:

```dart
class MyTodoView extends ViewBase<MyTodoViewModel> {
  MyTodoView({Key key}) : super(key: key);

  @override
  Widget buildView(BuildContext context, MyTodoViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(title: Text('To-dos')),
      body: viewModel.todos.isNotEmpty ? _buildTodoListView(viewModel.todos, viewModel) : _buildEmptyView(),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.showAddTodoDialog,
        tooltip: 'Add To-Do',
        child: viewModel.isBusy ? LoadingIndicator(size: 18, color: Colors.white) : Icon(Icons.add),
      ),
    );
  }

  Widget _buildTodoListView(List<TodoEntity> todos, MyTodoViewModel viewModel) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) => _buildTodoListItem(todos[index], viewModel),
    );
  }

  Widget _buildTodoListItem(TodoEntity todo, MyTodoViewModel viewModel) {
    return Dismissible(
      background: Container(
        padding: const EdgeInsets.only(left: 12),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.only(right: 12),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      onDismissed: (direction) => viewModel.onDeleteTodo(todo),
      child: ListTile(
        title: Text(todo.name),
        subtitle: Text(todo.description),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Text('No To-Dos found'),
    );
  }
}

```
- Extends from the class `ViewBase<TViewModel>`. The view model is automatically resolved.
- `buildView()` is called to rebuild the UI whenever the view model calls `notifyListeners`.

And here is our view model:

```dart
class MyTodoViewModel extends ViewModelBase {
  MyTodoViewModel(DialogService dialogService, this._todoManager) : super(dialogService: dialogService) {
    _todoStreamSubsc = _todoManager.todosStream.listen((t) {
      todos = t;
    });
  }

  final TodoManager _todoManager;
  StreamSubscription _todoStreamSubsc;

  List<TodoEntity> _todos = [];
  List<TodoEntity> get todos => _todos;
  set todos(List<TodoEntity> value) {
    if (_todos != value) {
      _todos = value;
      notifyListeners('todos');
    }
  }

  bool _isBusy = false;
  bool get isBusy => _isBusy;
  set isBusy(bool value) {
    if (_isBusy != value) {
      _isBusy = value;
      notifyListeners('isBusy');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _todoStreamSubsc.cancel();
  }

  @override
  Future<void> init([Map<String, Object> parameters]) async {
    print('Initialized');
  }

  Future<void> onDeleteTodo(TodoEntity todoToDelete) async {
    print('Deleting todo with id ${todoToDelete.id}...');

    try {
      todos.remove(todoToDelete);
      notifyListeners();
      await _todoManager.deleteTodo(todoToDelete);
    } on Exception catch (e) {
      print('Failed to delete todo', e);
      dialogService.alert('Failed to delete to-do.');
    }
  }

  Future<void> showAddTodoDialog() async {
    final result = await dialogService.showCustomDialog(ViewNames.addTodoDialog);

    if (result != null) {
      await _onCreateTodo(TodoEntity(
        name: result[NavigationParameterConstants.todoName],
        description: result[NavigationParameterConstants.todoDescription],
      ));
    }
  }

  Future<void> _onCreateTodo(TodoEntity todoToCreate) async {
    print('Creating todo...');

    try {
      isBusy = true;
      await _todoManager.createTodo(todoToCreate);
    } on Exception catch (e) {
      print('Failed to create todo', e);
      dialogService.alert('Failed to create to-do.');
    } finally {
      isBusy = false;
    }
  }
}
```
- `TodoManager.todoStream` allows us to listen to it. Everytime we create, delete, or update a to-do, this stream will emit the latest list of to-dos from our data layer.
- The view model contains `try-catch` block that handles exceptions from the other layer, and provide a meaningful message if such instances occur to the user.
- `init` is called whenever we navigate to our view using `NavigationService`.
- `dispose` is called whenever our view is removed from the widget tree.

##### Tying all layers together using IoC and Dependency Injection

All of our dependencies (views, view models, services, manager, web services, repositories, etc.) from each layer are registered in an IoC container.

The `AppInitializer` class registers all required dependencies. This class will be passed to our root widget `AppView`, which extends the class `Application`.

`AppInitializer.registerTypes` provides a `ServiceRegistry` in which we can use to register our dependencies, and resolve other dependencies in some registrations.

Optionally, you can resolve a registered dependency by using `Application.serviceLocator.resolve<T>()`.

It is important to note that reflection `dart:mirrors` is disabled in Flutter, and this is the reason why we are using the service locator pattern.