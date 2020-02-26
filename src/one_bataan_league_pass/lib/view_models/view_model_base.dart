import 'package:one_bataan_league_pass/models/listenable_model.dart';
import 'package:flutter/foundation.dart';

abstract class ViewModelBase extends ListenableModel {
  Future<void> init([Map<String, Object> parameters]) => Future<void>.value();

  @mustCallSuper
  void dispose() {
    removeAllOnModelChanged();
  }
}
