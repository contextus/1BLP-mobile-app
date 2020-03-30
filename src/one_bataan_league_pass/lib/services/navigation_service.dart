import 'package:one_bataan_league_pass/keys/keys.dart';
import 'package:one_bataan_league_pass/service_locator.dart';
import 'package:one_bataan_league_pass/views/views.dart';
import 'package:one_bataan_league_pass/widgets/model_bound_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NavigationService {
  void goToTab(String tabViewName, [Map<String, Object> parameters]) => _tabNavigator.navigateToTab(tabViewName);

  void pop<T extends Object>([T result]) => _navigator.pop(result);

  void popUntil(String viewName) => _navigator.popUntil(ModalRoute.withName('/$viewName'));

  Future<Map<String, Object>> push(String viewName, [Map<String, Object> parameters]) {
    return _navigator.push(
      MaterialPageRoute(
        builder: (_) => _getViewAndInitParam(viewName, parameters),
        settings: RouteSettings(name: '/$viewName'),
      ),
    );
  }

  Future<Map<String, Object>> pushAndRemoveUntil(String viewName, String removeUntil,
      [Map<String, Object> parameters]) {
    return _navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => _getViewAndInitParam(viewName, parameters),
        settings: RouteSettings(name: '/$viewName'),
      ),
      ModalRoute.withName('/$removeUntil'),
    );
  }

  Future<void> pushToNewRoot(String viewName, [Map<String, Object> parameters]) {
    return _navigator.pushAndRemoveUntil(
      PageTransition<void>(
        type: PageTransitionType.fade,
        curve: Curves.easeOutSine,
        duration: Duration(milliseconds: 150),
        child: _getViewAndInitParam(viewName, parameters),
      ),
      (_) => false,
    );
  }

  Future<Map<String, Object>> pushModal(String viewName, [Map<String, Object> parameters]) {
    return _navigator.push(
      MaterialPageRoute(
        builder: (_) => _getViewAndInitParam(viewName, parameters),
        fullscreenDialog: true,
      ),
    );
  }

  Future<Map<String, Object>> pushReplacement(String viewName, [Map<String, Object> parameters]) {
    return _navigator.pushReplacement(
      MaterialPageRoute(
        builder: (_) => _getViewAndInitParam(viewName, parameters),
        settings: RouteSettings(name: '/$viewName'),
      ),
    );
  }

  NavigatorState get _navigator => AppViewKeys.navigator.currentState;

  MainTabViewState get _tabNavigator => MainTabViewKeys.tabNavigator.currentState;

  Widget _getViewAndInitParam(String name, [Map<String, Object> parameters]) {
    final view = ServiceLocator.resolve<Widget>(name);

    if (view is ModelBoundWidget) view.viewModel.init(parameters);

    return view;
  }
}
