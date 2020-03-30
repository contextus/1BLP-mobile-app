import 'package:flutter/services.dart';
import 'package:one_bataan_league_pass/keys/keys.dart';
import 'package:one_bataan_league_pass/resources/app_theme.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';

class AppView extends StatelessWidget {
  AppView(this._viewModel) : super(key: AppViewKeys.view);

  static final routeObserver = RouteObserver<PageRoute>();

  final AppViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierBuilder<AppViewModel>(
      create: () {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        _viewModel.init();
        return _viewModel;
      },
      builder: (context, viewModel, child) {
        return MaterialApp(
          title: '1Bataan League Pass',
          navigatorKey: AppViewKeys.navigator,
          navigatorObservers: [routeObserver],
          themeMode: ThemeMode.light,
          theme: AppTheme.materialLightTheme,
          darkTheme: AppTheme.materialDarkTheme,
          home: const SplashWidget(key: AppViewKeys.splashWidget),
        );
      },
    );
  }
}
