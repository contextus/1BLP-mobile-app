import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeView extends ModelBoundWidget<HomeViewModel> {
  HomeView(HomeViewModel viewModel) : super(viewModel, key: HomeViewKeys.view);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ModelBoundState<HomeView, HomeViewModel> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<HomeViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<HomeViewModel>(
        builder: (context, child, viewModel) {
          return Scaffold(
            appBar: AppBar(title: Text('Home View')),
            body: viewModel.todos.isNotEmpty ? _buildTodoListView(viewModel.todos) : _buildEmptyView(),
            floatingActionButton: FloatingActionButton(
              key: HomeViewKeys.addTodoBtn,
              onPressed: () {
                if (viewModel.isBusy) return;
                _showAddTodoDialog();
              },
              tooltip: 'Add To-Do',
              child: viewModel.isBusy ? LoadingIndicator(size: 18, color: Colors.white) : Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTodoListView(List<TodoEntity> todos) {
    return ListView.builder(
      itemCount: todos.length,
      key: HomeViewKeys.todoListView,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return Dismissible(
          key: Key(todo.id.toString()),
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
          onDismissed: (direction) => viewModel.deleteTodo(todo),
          child: ListTile(
            title: Text(todo.name),
            subtitle: Text(todo.description),
          ),
        );
      },
    );
  }

  Widget _buildEmptyView() {
    return Center(
      key: HomeViewKeys.emptyTodoListView,
      child: Text('No To-Dos found'),
    );
  }

  void _showAddTodoDialog() async {
    final nameCtrl = TextEditingController();
    final descriptionCtrl = TextEditingController();

    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        return AlertDialog(
          key: HomeViewKeys.addTodoDialog,
          title: Text('Add To-Do'),
          content: ExtendedColumn(
            spacing: 8.0,
            children: <Widget>[
              TextField(
                key: HomeViewKeys.addTodoDialogName,
                controller: nameCtrl,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              TextField(
                key: HomeViewKeys.addTodoDialogDesc,
                controller: descriptionCtrl,
                decoration: InputDecoration(hintText: 'Description'),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              key: HomeViewKeys.addTodoDialogCancelBtn,
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            FlatButton(
              key: HomeViewKeys.addTodoDialogAddBtn,
              child: Text('Add'),
              onPressed: () {
                viewModel.createTodo(nameCtrl.text, descriptionCtrl.text);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
