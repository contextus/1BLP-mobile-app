import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class AppViewModel extends ViewModelBase {
  AppViewModel(this._analyticsService, this._navigationService) {
    instance = this;
  }

  final AnalyticsService _analyticsService;
  final NavigationService _navigationService;

  // TODO: Add to settings.
  bool _isDarkModeEnabled = false;
  bool get isDarkModeEnabled => _isDarkModeEnabled;
  set isDarkModeEnabled(bool value) {
    if (_isDarkModeEnabled != value) {
      _isDarkModeEnabled = value;
      notifyListeners();
    }
  }

  static AppViewModel instance;

  @override
  Future<void> init([Map<String, Object> parameters]) async {
    await Future.delayed(Duration(seconds: 1));
    await _analyticsService.start();
    await _navigationService.pushToNewRoot(ViewNames.mainTabView);
  }
}
