import 'package:arch/arch.dart';
import 'package:one_bataan_league_pass/resources/app_theme.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';

class AppView extends Application {
  AppView(Initializer initializer) : super(initializer);

  static final routeObserver = RouteObserver<PageRoute>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierBuilder<AppViewModel>(
      create: () {
        final viewModel = Application.serviceLocator.resolve<AppViewModel>();
        viewModel.init();
        return viewModel;
      },
      builder: (context, viewModel, child) {
        return MaterialApp(
          title: '1Bataan League Pass',
          navigatorKey: NavigationService.navigatorKey,
          navigatorObservers: [routeObserver],
          themeMode: ThemeMode.light,
          theme: AppTheme.materialLightTheme,
          darkTheme: AppTheme.materialDarkTheme,
          home: const SplashWidget(),
        );
      },
    );
  }
}
