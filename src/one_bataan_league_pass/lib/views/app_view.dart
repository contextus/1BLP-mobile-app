import 'package:one_bataan_league_pass/keys/keys.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/dialog_manager_widget.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AppView extends ModelBoundWidget<AppViewModel> {
  AppView(AppViewModel viewModel) : super(viewModel, key: AppViewKeys.view);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends ModelBoundState<AppView, AppViewModel> {
  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<AppViewModel>(
        builder: (context, child, viewModel) {
          return MaterialApp(
            title: '1Bataan League Pass',
            theme: ThemeData(
              primarySwatch: MaterialColor(
                4280361248,
                {
                  50: Color(0xfff2f2f2),
                  100: Color(0xffe6e6e5),
                  200: Color(0xffcdcdcb),
                  300: Color(0xffb4b4b1),
                  400: Color(0xff9b9b97),
                  500: Color(0xff81817e),
                  600: Color(0xff686864),
                  700: Color(0xff4e4e4b),
                  800: Color(0xff343432),
                  900: Color(0xff1a1a19)
                },
              ),
            ),
            navigatorKey: AppViewKeys.navigator,
            home: SplashWidget(key: AppViewKeys.splashWidget),
            builder: (_, widget) => Navigator(
              onGenerateRoute: (_) => MaterialPageRoute(
                builder: (_) => DialogManagerWidget(child: widget),
              ),
            ),
          );
        },
      ),
    );
  }
}
