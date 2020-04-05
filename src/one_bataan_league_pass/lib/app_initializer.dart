import 'package:arch/arch.dart';
import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/views/views.dart';
import 'package:one_bataan_league_pass_business/managers.dart';
import 'package:one_bataan_league_pass_business/mappers.dart';
import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:one_bataan_league_pass_common/logging.dart';
import 'package:one_bataan_league_pass_data/cache.dart';
import 'package:one_bataan_league_pass_data/database.dart';
import 'package:one_bataan_league_pass_web_service/web_services.dart';

class AppInitializer implements Initializer {
  @override
  void registerTypes(ServiceRegistry registry) {
    _registerData(registry);
    _registerWebServices(registry);
    _registerMappers(registry);
    _registerManagers(registry);
    _registerUiServices(registry);
    _registerUi(registry);
  }

  void _registerWebServices(ServiceRegistry registry) {
    registry
      ..registerFactory<HttpHandler>(() => HttpHandlerImpl())
      ..registerFactory<TeamWebService>(() => TeamWebServiceImpl(registry.resolve<HttpHandler>()))
      ..registerFactory<PlayerWebService>(() => PlayerWebServiceImpl(registry.resolve<HttpHandler>()));
  }

  void _registerData(ServiceRegistry registry) async {
    registry
      ..registerSingleton<QueryExecutorProvider>(FlutterQueryExecutorProvider())
      ..registerSingleton<AppDatabase>(AppDatabase(registry.resolve<QueryExecutorProvider>()))
      ..registerLazySingleton<SecureStorageService>(() => FlutterSecureStorageService())
      ..registerLazySingleton<SharedPrefsService>(() => FlutterSharedPrefsService());
  }

  void _registerMappers(ServiceRegistry registry) {
    registry
      ..registerLazySingleton<TeamMapper>(() => TeamMapperImpl())
      ..registerLazySingleton<PlayerTeamMapper>(() => PlayerTeamMapperImpl(registry.resolve<TeamMapper>()))
      ..registerLazySingleton<PlayerMapper>(() => PlayerMapperImpl(registry.resolve<PlayerTeamMapper>()));
  }

  void _registerManagers(ServiceRegistry registry) {
    registry
      ..registerLazySingleton<UserProfileManager>(() => UserProfileManagerImpl())
      ..registerLazySingleton<GameManager>(() => GameManagerImpl())
      ..registerLazySingleton<PlayerManager>(
          () => PlayerManagerImpl(registry.resolve<PlayerWebService>(), registry.resolve<PlayerMapper>()))
      ..registerLazySingleton<TeamManager>(
          () => TeamManagerImpl(registry.resolve<TeamWebService>(), registry.resolve<TeamMapper>()));
  }

  void _registerUiServices(ServiceRegistry registry) {
    // No need to register [NavigationService] and [DialogService].
    // These are automatically registered in package:arch/arch.dart.

    registry
      ..registerLazySingleton<AnalyticsService>(() => AppCenterAnalytics())
      ..registerLazySingleton<TabNavigationService>(() => TabNavigationServiceImpl())
      ..registerLazySingleton<SharingService>(() => FlutterSharingService());
  }

  void _registerUi(ServiceRegistry registry) {
    // Register view models
    registry
      ..registerForNavigation(
        view: () => MainTabView(),
        viewModel: () => MainTabViewModel(
          registry.resolve<NavigationService>(),
          registry.resolve<HomeTabViewModel>(),
          registry.resolve<GamesTabViewModel>(),
          registry.resolve<StandingsTabViewModel>(),
          registry.resolve<PlayersTabViewModel>(),
          registry.resolve<TeamsTabViewModel>(),
        ),
        viewName: ViewNames.mainTabView,
      )
      ..registerForNavigation(
        view: () => UserProfileView(),
        viewModel: () => UserProfileViewModel(registry.resolve<UserProfileManager>()),
        viewName: ViewNames.userProfileView,
      )
      ..registerForNavigation(
        view: () => WatchReplayView(),
        viewModel: () => WatchReplayViewModel(),
        viewName: ViewNames.watchReplayView,
      )
      ..registerForNavigation(
        view: () => PlayerProfileView(),
        viewModel: () => PlayerProfileViewModel(),
        viewName: ViewNames.playerProfileView,
      )
      ..registerForNavigation(
        view: () => TeamProfileView(),
        viewModel: () => TeamProfileViewModel(registry.resolve<NavigationService>(), registry.resolve<PlayerManager>()),
        viewName: ViewNames.teamProfileView,
      )
      ..registerForNavigation(
        view: () => GameRecapView(),
        viewModel: () => GameRecapViewModel(),
        viewName: ViewNames.gameRecapView,
      );

    registry
      ..registerLazySingleton<AppViewModel>(
        () => AppViewModel(
          registry.resolve<AnalyticsService>(),
          registry.resolve<NavigationService>(),
        ),
      )
      ..registerFactory<HomeTabViewModel>(() => HomeTabViewModel(
            registry.resolve<GameManager>(),
            registry.resolve<SharingService>(),
          ))
      ..registerFactory<GamesTabViewModel>(
        () => GamesTabViewModel(
          registry.resolve<NavigationService>(),
          registry.resolve<TabNavigationService>(),
          registry.resolve<GameManager>(),
        ),
      )
      ..registerFactory<StandingsTabViewModel>(() => StandingsTabViewModel())
      ..registerFactory<TeamsTabViewModel>(
        () => TeamsTabViewModel(
          registry.resolve<NavigationService>(),
          registry.resolve<TeamManager>(),
        ),
      )
      ..registerFactory<PlayersTabViewModel>(
        () => PlayersTabViewModel(
          registry.resolve<NavigationService>(),
          registry.resolve<PlayerManager>(),
          registry.resolve<TeamManager>(),
        ),
      );
  }
}
