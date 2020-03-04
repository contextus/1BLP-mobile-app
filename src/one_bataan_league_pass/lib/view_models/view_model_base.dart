import 'package:one_bataan_league_pass/models/listenable_model.dart';
import 'package:flutter/foundation.dart';
import 'package:one_bataan_league_pass/services/services.dart';

abstract class ViewModelBase extends ListenableModel {
  ViewModelBase([this.navigationService, this.dialogService]);

  @protected
  final NavigationService navigationService;

  @protected
  final DialogService dialogService;

  Future<void> init([Map<String, Object> parameters]) => Future<void>.value();

  @mustCallSuper
  void dispose() {
    removeAllOnModelChanged();
  }
}