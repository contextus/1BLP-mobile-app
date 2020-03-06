import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class AppViewModel extends ViewModelBase {
  AppViewModel(this._analyticsService, this._navigationService);

  final AnalyticsService _analyticsService;
  final NavigationService _navigationService;

  @override
  Future<void> init([Map<String, Object> parameters]) async {
    await Future.delayed(Duration(seconds: 1));
    await _analyticsService.start();
    await _navigationService.pushAndReset(ViewNames.mainTabView);
  }
}
