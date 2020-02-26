import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/views/views.dart';
import 'package:one_bataan_league_pass_business/managers.dart';
import 'package:one_bataan_league_pass_business/mappers.dart';
import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:one_bataan_league_pass_data/database.dart';
import 'package:one_bataan_league_pass_web_service/web_services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  static final _i = GetIt.I;

  static void registerDependencies() {
    _registerWebServices();
    _registerDatabase();
    _registerMappers();
    _registerManagers();
    _registerUiServices();
    _registerUi();
  }

  static void _registerWebServices() {
    _i
      ..registerFactory<HttpHandler>(() => HttpHandler())
      ..registerLazySingleton<TodoWebService>(() => TodoWebService(_i.get<HttpHandler>()));
  }

  static void _registerDatabase() {
    _i
      ..registerSingleton<QueryExecutorProvider>(FlutterQueryExecutorProvider())
      ..registerSingleton<AppDatabase>(AppDatabase(_i.get<QueryExecutorProvider>()))
      ..registerSingleton<TodoRepository>(TodoRepository(_i.get<AppDatabase>()));
  }

  static void _registerMappers() {
    _i..registerLazySingleton<TodoMapper>(() => TodoMapper());
  }

  static void _registerManagers() {
    _i
      ..registerLazySingleton<TodoManager>(() => TodoManager(
            _i.get<TodoMapper>(),
            _i.get<TodoRepository>(),
            _i.get<TodoWebService>(),
          ));
  }

  static void _registerUiServices() {
    _i
      ..registerSingleton<AnalyticsService>(AnalyticsService())
      ..registerSingleton<NavigationService>(NavigationService())
      ..registerSingleton<DialogService>(DialogService());
  }

  static void _registerUi() {
    _i
      ..registerFactory<AppViewModel>(
        () => AppViewModel(
          _i.get<AnalyticsService>(),
          _i.get<NavigationService>(),
        ),
      )
      ..registerSingleton<AppView>(AppView(_i.get<AppViewModel>()))
      ..registerFactory<HomeViewModel>(() => HomeViewModel(_i.get<TodoManager>()))
      ..registerFactory<Widget>(
        () => HomeView(_i.get<HomeViewModel>()),
        instanceName: ViewNames.homeView,
      );
  }

  static T resolve<T>([String name]) {
    if (name?.isNotEmpty ?? false == true)
      return _i.get(name) as T;
    else
      return _i.get<T>();
  }
}
