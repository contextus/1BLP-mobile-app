import 'package:one_bataan_league_pass/models/listenable_model.dart';
import 'package:one_bataan_league_pass/services/services.dart';
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

  @mustCallSuper
  void dispose() => removeAllOnModelChanged();
}

abstract class TabViewModelBase extends ViewModelBase {
  TabViewModelBase([NavigationService navigationService, DialogService dialogService])
      : super(navigationService: navigationService, dialogService: dialogService);

  void onTabNavigatedTo() {}

  void onTabNavigatedFrom() {}
}
