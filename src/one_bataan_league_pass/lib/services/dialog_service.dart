import 'package:one_bataan_league_pass/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/service_locator.dart';
import 'package:one_bataan_league_pass/widgets/views.dart';

abstract class DialogService {
  Future<void> alert(String message, {String title, String ok = 'Ok'});

  Future<bool> confirm(String message, {String title, String ok = 'Ok', String cancel = 'Cancel'});

  Future<Map<String, Object>> showCustomDialog(String dialogName, [Map<String, Object> parameters]);

  void pop([Map<String, Object> result]);
}

class DialogServiceImpl implements DialogService {
  @override
  Future<void> alert(String message, {String title, String ok = 'Ok'}) {
    return showDialog(
      context: _context,
      builder: (context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(ok),
              onPressed: Navigator.of(context).pop,
            )
          ],
        );
      },
    );
  }

  @override
  Future<bool> confirm(String message, {String title, String ok = 'Ok', String cancel = 'Cancel'}) {
    return showDialog<bool>(
      context: _context,
      builder: (context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(cancel),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            FlatButton(
              child: Text(ok),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }

  @override
  Future<Map<String, Object>> showCustomDialog(String dialogName, [Map<String, Object> parameters]) {
    return showDialog(
      context: _context,
      builder: (context) => DialogRoute(
        child: ServiceLocator.resolve<Widget>(dialogName),
        settings: RouteSettings(name: dialogName, arguments: parameters),
      ),
    );
  }

  @override
  void pop([Map<String, Object> result]) => Navigator.of(_context).pop(result);

  static BuildContext get _context => AppViewKeys.navigator.currentState.overlay.context;
}
