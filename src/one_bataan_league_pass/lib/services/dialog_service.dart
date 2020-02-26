typedef AlertCallback = Future<void> Function(String message, String title, String ok);

typedef ConfirmCallback = Future<bool> Function(String message, String title, String ok, String cancel);

class DialogService {
  AlertCallback _onAlert;
  ConfirmCallback _onConfirm;

  void registerCallbacks({AlertCallback onAlert, ConfirmCallback onConfirm, void Function() onAppInfo}) {
    _onAlert = onAlert;
    _onConfirm = onConfirm;
  }

  Future<void> alert(String message, {String title, String ok = 'Ok'}) => _onAlert(message, title, ok);

  Future<bool> confirm(String message, {String title, String ok = 'Ok', String cancel = 'Cancel'}) =>
      _onConfirm(message, title, ok, cancel);
}
