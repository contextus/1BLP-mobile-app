import 'package:one_bataan_league_pass/models/listenable_model.dart';
import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass_common/logging.dart';
import 'package:flutter/foundation.dart';

abstract class ViewModelBase extends ListenableModel {
  ViewModelBase({this.analyticsService, this.navigationService, this.dialogService});

  @protected
  final AnalyticsService analyticsService;

  @protected
  final NavigationService navigationService;

  @protected
  final DialogService dialogService;

  Future<void> init([Map<String, Object> parameters]) => Future<void>.value();
}

abstract class TabViewModelBase extends ViewModelBase {
  TabViewModelBase([NavigationService navigationService, DialogService dialogService])
      : super(navigationService: navigationService, dialogService: dialogService);

  void onTabNavigatedTo([Map<String, Object> parameters]) {}

  void onTabNavigatedFrom() {}
}

abstract class DialogModelBase extends ListenableModel {
  DialogModelBase(this._dialogService);

  final DialogService _dialogService;

  Future<void> init([Map<String, Object> parameters]) => Future<void>.value();

  void pop([Map<String, Object> result]) => _dialogService.pop(result);
}
