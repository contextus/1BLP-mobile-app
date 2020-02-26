import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:flutter/material.dart';

class AppViewKeys {
  static final view = Key(AppViewKeyValues.view);
  static final splashWidget = Key(AppViewKeyValues.splashWidget);
  static final navigator = GlobalKey<NavigatorState>();
}

class HomeViewKeys {
  static final view = Key(HomeViewKeyValues.view);
  static final addTodoBtn = Key(HomeViewKeyValues.addTodoBtn);
  static final todoListViewLoader = Key(HomeViewKeyValues.todoListViewLoader);
  static final todoListView = Key(HomeViewKeyValues.todoListView);
  static final emptyTodoListView = Key(HomeViewKeyValues.emptyTodoListView);

  static const addTodoDialog = Key(HomeViewKeyValues.addTodoDialog);
  static const addTodoDialogName = Key(HomeViewKeyValues.addTodoDialogName);
  static const addTodoDialogDesc = Key(HomeViewKeyValues.addTodoDialogDesc);
  static const addTodoDialogAddBtn = Key(HomeViewKeyValues.addTodoDialogAddBtn);
  static const addTodoDialogCancelBtn = Key(HomeViewKeyValues.addTodoDialogCancelBtn);
}
