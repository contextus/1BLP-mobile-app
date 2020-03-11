import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/views/views.dart';
import 'package:one_bataan_league_pass_business/managers.dart';
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
    _i..registerFactory<HttpHandler>(() => HttpHandler());
  }

  static void _registerData() {
    _i
      ..registerLazySingleton<QueryExecutorProvider>(() => FlutterQueryExecutorProvider())
      ..registerLazySingleton<AppDatabase>(() => AppDatabase(_i.get<QueryExecutorProvider>()));

    _i
      ..registerLazySingleton<SecureStorageService>(() => SecureStorageService())
      ..registerLazySingleton<SharedPrefsService>(() => SharedPrefsService());
  }

  static void _registerMappers() {}

  static void _registerManagers() {
    _i
      ..registerLazySingleton<UserProfileManager>(() => UserProfileManager())
      ..registerLazySingleton<GameManager>(() => GameManager())
      ..registerLazySingleton<PlayerManager>(() => PlayerManager())
      ..registerLazySingleton<TeamManager>(() => TeamManager());
  }

  static void _registerUiServices() {
    _i
      ..registerLazySingleton<AnalyticsService>(() => AnalyticsService())
      ..registerLazySingleton<NavigationService>(() => NavigationService())
      ..registerLazySingleton<DialogService>(() => DialogService())
      ..registerLazySingleton<SharingService>(() => SharingService());
  }

  static void _registerUi() {
    // Register view models
    _i
      ..registerFactory<AppViewModel>(() => AppViewModel(_i.get<AnalyticsService>(), _i.get<NavigationService>()))
      ..registerFactory<UserProfileViewModel>(() => UserProfileViewModel(_i.get<UserProfileManager>()))
      ..registerFactory<MainTabViewModel>(() => MainTabViewModel(_i.get<NavigationService>()))
      ..registerFactory<HomeTabViewModel>(() => HomeTabViewModel(
            _i.get<NavigationService>(),
            _i.get<DialogService>(),
            _i.get<GameManager>(),
            _i.get<SharingService>(),
          ))
      ..registerFactory<GamesTabViewModel>(() => GamesTabViewModel(_i.get<NavigationService>(), _i.get<GameManager>()))
      ..registerFactory<StandingsTabViewModel>(() => StandingsTabViewModel())
      ..registerFactory<TeamsTabViewModel>(() => TeamsTabViewModel(_i.get<TeamManager>()))
      ..registerFactory<PlayersTabViewModel>(() => PlayersTabViewModel(_i.get<PlayerManager>()))
      ..registerFactory<WatchReplayViewModel>(() => WatchReplayViewModel());

    // Register views
    _i
      ..registerLazySingleton<AppView>(() => AppView(_i.get<AppViewModel>()))
      ..registerFactory<Widget>(
        () => MainTabView(_i.get<MainTabViewModel>()),
        instanceName: ViewNames.mainTabView,
      )
      ..registerFactory<UserProfileView>(
        () => UserProfileView(_i.get<UserProfileViewModel>()),
        instanceName: ViewNames.userProfileView,
      )
      ..registerFactory<WatchReplayView>(
        () => WatchReplayView(_i.get<WatchReplayViewModel>()),
        instanceName: ViewNames.watchReplayView,
      );
  }

  static T resolve<T>([String name]) {
    if (name?.isNotEmpty ?? false == true)
      return _i.get(name) as T;
    else
      return _i.get<T>();
  }
}
