import 'package:one_bataan_league_pass/models/listenable_model.dart';
import 'package:one_bataan_league_pass/services/services.dart';
import 'package:flutter/foundation.dart';

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

abstract class TabViewModelBase extends ViewModelBase {
  TabViewModelBase([NavigationService navigationService, DialogService dialogService])
      : super(navigationService, dialogService);

  final _onTabSelectedCallbacks = Set<void Function(Map<String, Object>)>();
  final _onTabUnselectedCallbacks = Set<VoidCallback>();
  final _onNavigatedFromCallbacks = Set<VoidCallback>();

  void addOnTabSelected(void Function(Map<String, Object>) callback) => _onTabSelectedCallbacks.add(callback);

  void addOnTabUnselected(VoidCallback callback) => _onTabUnselectedCallbacks.add(callback);

  void addOnNavigatedFrom(VoidCallback callback) => _onNavigatedFromCallbacks.add(callback);

  @mustCallSuper
  void onTabSelected([Map<String, Object> parameters]) {
    _onTabSelectedCallbacks.forEach((c) => c(parameters));
  }

  @mustCallSuper
  void onTabUnselected() {
    _onTabUnselectedCallbacks.forEach((c) => c());
  }

  @mustCallSuper
  void onNavigatedFrom() {
    _onNavigatedFromCallbacks.forEach((c) => c());
  }

  @override
  void dispose() {
    _onTabUnselectedCallbacks.clear();
    _onNavigatedFromCallbacks.clear();
    super.dispose();
  }
}
