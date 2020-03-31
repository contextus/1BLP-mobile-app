import 'dart:async';

import 'package:flutter/foundation.dart';

typedef ModelChangedCallback = void Function(String name);

abstract class ListenableModel extends ChangeNotifier {
  final _callbacks = Set<ModelChangedCallback>();
  int _microtaskVersion = 0;
  int _version = 0;

  void addOnModelChanged(ModelChangedCallback callback) => _callbacks.add(callback);

  void removeOnModelChanged(ModelChangedCallback callback) => _callbacks.remove(callback);

  void removeAllOnModelChanged() => _callbacks.clear();

  @protected
  @mustCallSuper
  @override
  void notifyListeners([String propertyName]) {
    super.notifyListeners();

    if (_microtaskVersion == _version) {
      _microtaskVersion++;
      scheduleMicrotask(() {
        _version++;
        _microtaskVersion = _version;
        _callbacks.toList().forEach((callback) => callback(propertyName));
        onModelChanged(propertyName);
      });
    }
  }

  @protected
  void onModelChanged([String propertyName]) {}

  @mustCallSuper
  @override
  void dispose() {
    removeAllOnModelChanged();
    super.dispose();
  }
}
