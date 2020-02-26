import 'package:one_bataan_league_pass/keys/keys.dart';
import 'package:one_bataan_league_pass/resources/app_theme.dart';
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
            theme: AppTheme.defaultTheme,
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
