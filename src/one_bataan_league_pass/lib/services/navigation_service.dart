import 'package:one_bataan_league_pass/keys/keys.dart';
import 'package:one_bataan_league_pass/service_locator.dart';
import 'package:one_bataan_league_pass/views/views.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

abstract class NavigationService {
  void goToTab(String tabViewName, [Map<String, Object> parameters]);

  void pop([Map<String, Object> result]);

  void popUntil(String viewName);

  Future<Map<String, Object>> push(String viewName, [Map<String, Object> parameters]);

  Future<Map<String, Object>> pushAndRemoveUntil(
    String viewName,
    String removeUntil, [
    Map<String, Object> parameters,
  ]);

  void pushToNewRoot(String viewName, [Map<String, Object> parameters]);

  Future<Map<String, Object>> pushModal(String viewName, [Map<String, Object> parameters]);

  Future<Map<String, Object>> pushReplacement(String viewName, [Map<String, Object> parameters]);
}

class NavigationServiceImpl implements NavigationService {
  @override
  void goToTab(String tabViewName, [Map<String, Object> parameters]) =>
      _tabNavigator.navigateToTab(tabViewName, parameters);

  @override
  void pop([Map<String, Object> result]) => _navigator.pop(result);

  @override
  void popUntil(String viewName) => _navigator.popUntil(ModalRoute.withName('/$viewName'));

  @override
  Future<Map<String, Object>> push(String viewName, [Map<String, Object> parameters]) {
    return _navigator.push(
      MaterialPageRoute(
        builder: (_) => _getViewAndInitParam(viewName),
        settings: RouteSettings(name: '/$viewName', arguments: parameters),
      ),
    );
  }

  @override
  Future<Map<String, Object>> pushAndRemoveUntil(
    String viewName,
    String removeUntil, [
    Map<String, Object> parameters,
  ]) {
    return _navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => _getViewAndInitParam(viewName),
        settings: RouteSettings(name: '/$viewName', arguments: parameters),
      ),
      ModalRoute.withName('/$removeUntil'),
    );
  }

  @override
  void pushToNewRoot(String viewName, [Map<String, Object> parameters]) {
    _navigator.pushAndRemoveUntil(
      PageTransition<void>(
        type: PageTransitionType.fade,
        curve: Curves.easeOutSine,
        duration: Duration(milliseconds: 150),
        child: _getViewAndInitParam(viewName),
        settings: RouteSettings(name: '/$viewName', arguments: parameters),
      ),
      (_) => false,
    );
  }

  @override
  Future<Map<String, Object>> pushModal(String viewName, [Map<String, Object> parameters]) {
    return _navigator.push(
      MaterialPageRoute(
        builder: (_) => _getViewAndInitParam(viewName),
        fullscreenDialog: true,
        settings: RouteSettings(name: '/$viewName', arguments: parameters),
      ),
    );
  }

  @override
  Future<Map<String, Object>> pushReplacement(String viewName, [Map<String, Object> parameters]) {
    return _navigator.pushReplacement(
      MaterialPageRoute(
        builder: (_) => _getViewAndInitParam(viewName),
        settings: RouteSettings(name: '/$viewName', arguments: parameters),
      ),
    );
  }

  static NavigatorState get _navigator => AppViewKeys.navigator.currentState;

  static MainTabViewState get _tabNavigator => MainTabViewKeys.tabNavigator.currentState;

  static Widget _getViewAndInitParam(String name) => ServiceLocator.resolve<Widget>(name);
}
