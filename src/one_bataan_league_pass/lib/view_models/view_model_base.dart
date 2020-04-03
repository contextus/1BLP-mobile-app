import 'package:arch/arch.dart';
import 'package:flutter/foundation.dart';
import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass_common/logging.dart';

abstract class ViewModel extends ViewModelBase {
  ViewModel({
    NavigationService navigationService,
    DialogService dialogService,
    this.analyticsService,
    this.tabNavigationService,
  }) : super(navigationService: navigationService, dialogService: dialogService);

  @protected
  final AnalyticsService analyticsService;

  @protected
  final TabNavigationService tabNavigationService;
}

abstract class TabViewModelBase extends ViewModel {
  TabViewModelBase({
    NavigationService navigationService,
    DialogService dialogService,
    TabNavigationService tabNavigationService,
  }) : super(
          navigationService: navigationService,
          dialogService: dialogService,
          tabNavigationService: tabNavigationService,
        );

  void onTabNavigatedTo([Map<String, Object> parameters]) {}

  void onTabNavigatedFrom() {}
}
