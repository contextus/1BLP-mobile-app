import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/views/views.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:one_bataan_league_pass_data/cache.dart';
import 'package:one_bataan_league_pass_data/database.dart';
import 'package:one_bataan_league_pass_web_service/web_services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  static final _i = GetIt.I;

  static void registerDependencies() {
    _registerWebServices();
    _registerData();
    _registerMappers();
    _registerManagers();
    _registerUiServices();
    _registerUi();
  }

  static void _registerWebServices() {
    _i
      ..registerFactory<HttpHandler>(() => HttpHandler());
  }

  static void _registerData() {
    _i
      ..registerLazySingleton<QueryExecutorProvider>(() => FlutterQueryExecutorProvider())
      ..registerLazySingleton<AppDatabase>(() => AppDatabase(_i.get<QueryExecutorProvider>()));

    _i
      ..registerLazySingleton<SecureStorageService>(() => SecureStorageService())
      ..registerLazySingleton<SharedPrefsService>(() => SharedPrefsService());
  }

  static void _registerMappers() {

  }

  static void _registerManagers() {
  
  }

  static void _registerUiServices() {
    _i
      ..registerLazySingleton<AnalyticsService>(() => AnalyticsService())
      ..registerLazySingleton<NavigationService>(() => NavigationService())
      ..registerLazySingleton<DialogService>(() => DialogService());
  }

  static void _registerUi() {
    _i
      ..registerFactory<AppViewModel>(() => AppViewModel(_i.get<AnalyticsService>(), _i.get<NavigationService>()))
      ..registerFactory<MainTabViewModel>(() => MainTabViewModel())
      ..registerFactory<HomeTabViewModel>(() => HomeTabViewModel(_i.get<NavigationService>(), _i.get<DialogService>()))
      ..registerFactory<GamesTabViewModel>(() => GamesTabViewModel())
      ..registerFactory<StandingsTabViewModel>(() => StandingsTabViewModel())
      ..registerFactory<TeamsTabViewModel>(() => TeamsTabViewModel())
      ..registerFactory<PlayersTabViewModel>(() => PlayersTabViewModel());

    _i
      ..registerLazySingleton<AppView>(() => AppView(_i.get<AppViewModel>()))
      ..registerFactory<Widget>(() => HomeTabView(_i.get<HomeTabViewModel>()), instanceName: ViewNames.homeTabView)
      ..registerFactory<Widget>(() => GamesTabView(_i.get<GamesTabViewModel>()),
          instanceName: ViewNames.gamesTabView)
      ..registerFactory<Widget>(() => StandingsTabView(_i.get<StandingsTabViewModel>()),
          instanceName: ViewNames.standingsTabView)
      ..registerFactory<Widget>(() => TeamsTabView(_i.get<TeamsTabViewModel>()),
          instanceName: ViewNames.teamsTabView)
      ..registerFactory<Widget>(() => PlayersTabView(_i.get<PlayersTabViewModel>()),
          instanceName: ViewNames.playersTabView)
      ..registerFactory<Widget>(() {
        final tabs = [
          _i.get<Widget>(ViewNames.homeTabView),
          _i.get<Widget>(ViewNames.gamesTabView),
          _i.get<Widget>(ViewNames.standingsTabView),
          _i.get<Widget>(ViewNames.teamsTabView),
          _i.get<Widget>(ViewNames.playersTabView),
        ].cast<ModelBoundTabWidget>();
        return MainTabView(_i.get<MainTabViewModel>(), tabs);
      }, instanceName: ViewNames.mainTabView);
  }

  static T resolve<T>([String name]) {
    if (name?.isNotEmpty ?? false == true)
      return _i.get(name) as T;
    else
      return _i.get<T>();
  }
}
