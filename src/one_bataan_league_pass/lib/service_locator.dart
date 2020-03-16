import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/views/views.dart';
import 'package:one_bataan_league_pass_business/managers.dart';
import 'package:one_bataan_league_pass_business/mappers.dart';
import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:one_bataan_league_pass_data/cache.dart';
import 'package:one_bataan_league_pass_data/database.dart';
import 'package:one_bataan_league_pass_web_service/web_services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  static final _i = GetIt.I;

  T resolve<T>([String name]) {
    if (name?.isNotEmpty ?? false == true)
      return _i.get(instanceName: name) as T;
    else
      return _i.get<T>();
  }

  Future<void> registerDependencies() async {
    _i.registerSingleton<ServiceLocator>(this);
    await _registerData();
    _registerWebServices();
    _registerMappers();
    _registerManagers();
    _registerUiServices();
    _registerUi();
  }

  void _registerWebServices() {
    _i
      ..registerFactory<HttpHandler>(() => HttpHandler())
      ..registerFactory<TeamWebService>(() => TeamWebServiceImpl(_i.get<HttpHandler>()))
      ..registerFactory<PlayerWebService>(() => PlayerWebServiceImpl(_i.get<HttpHandler>()));
  }

  Future<void> _registerData() async {
    final queryExecutorProvider = FlutterQueryExecutorProvider();
    final queryExecutor = await queryExecutorProvider.createDatabase();
    final appDatabase = AppDatabase(queryExecutor);

    _i
      ..registerSingleton<AppDatabase>(appDatabase)
      ..registerLazySingleton<SecureStorageService>(() => SecureStorageService())
      ..registerLazySingleton<SharedPrefsService>(() => SharedPrefsService());
  }

  void _registerMappers() {
    _i
      ..registerLazySingleton<TeamMapper>(() => TeamMapper())
      ..registerLazySingleton<PlayerTeamMapper>(() => PlayerTeamMapper(_i.get<TeamMapper>()))
      ..registerLazySingleton<PlayerMapper>(() => PlayerMapper(_i.get<PlayerTeamMapper>()));
  }

  void _registerManagers() {
    _i
      ..registerLazySingleton<UserProfileManager>(() => UserProfileManager())
      ..registerLazySingleton<GameManager>(() => GameManager())
      ..registerLazySingleton<PlayerManager>(() => PlayerManager(_i.get<PlayerWebService>(), _i.get<PlayerMapper>()))
      ..registerLazySingleton<TeamManager>(() => TeamManager(_i.get<TeamWebService>(), _i.get<TeamMapper>()));
  }

  void _registerUiServices() {
    _i
      ..registerLazySingleton<AnalyticsService>(() => AnalyticsService())
      ..registerLazySingleton<NavigationService>(() => NavigationService(_i.get<ServiceLocator>()))
      ..registerLazySingleton<DialogService>(() => DialogService())
      ..registerLazySingleton<SharingService>(() => SharingService());
  }

  void _registerUi() {
    // Register view models
    _i
      ..registerFactory<UserProfileViewModel>(() => UserProfileViewModel(_i.get<UserProfileManager>()))
      ..registerFactory<MainTabViewModel>(() => MainTabViewModel(
            _i.get<NavigationService>(),
            _i.get<HomeTabViewModel>(),
            _i.get<GamesTabViewModel>(),
            _i.get<StandingsTabViewModel>(),
            _i.get<PlayersTabViewModel>(),
            _i.get<TeamsTabViewModel>(),
          ))
      ..registerFactory<HomeTabViewModel>(() => HomeTabViewModel(
            _i.get<NavigationService>(),
            _i.get<DialogService>(),
            _i.get<GameManager>(),
            _i.get<SharingService>(),
          ))
      ..registerFactory<GamesTabViewModel>(() => GamesTabViewModel(_i.get<NavigationService>(), _i.get<GameManager>()))
      ..registerFactory<StandingsTabViewModel>(() => StandingsTabViewModel())
      ..registerFactory<TeamsTabViewModel>(() => TeamsTabViewModel(_i.get<TeamManager>(), _i.get<NavigationService>()))
      ..registerFactory<PlayersTabViewModel>(
          () => PlayersTabViewModel(_i.get<PlayerManager>(), _i.get<NavigationService>()))
      ..registerFactory<WatchReplayViewModel>(() => WatchReplayViewModel())
      ..registerFactory<PlayerProfileViewModel>(() => PlayerProfileViewModel())
      ..registerFactory<TeamProfileViewModel>(() => TeamProfileViewModel())
      ..registerFactory<GameRecapViewModel>(() => GameRecapViewModel());

    // Register views
    _i
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
      )
      ..registerFactory<PlayerProfileView>(
        () => PlayerProfileView(_i.get<PlayerProfileViewModel>()),
        instanceName: ViewNames.playerProfileView,
      )
      ..registerFactory<TeamProfileView>(
        () => TeamProfileView(_i.get<TeamProfileViewModel>()),
        instanceName: ViewNames.teamProfileView,
      )
      ..registerFactory<GameRecapView>(
        () => GameRecapView(_i.get<GameRecapViewModel>()),
        instanceName: ViewNames.gameRecapView,
      );
  }
}
