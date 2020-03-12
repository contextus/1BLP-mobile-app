import 'package:one_bataan_league_pass/service_locator.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class AppViewModel extends ViewModelBase {
  AppViewModel(this._serviceLocator);

  final ServiceLocator _serviceLocator;

  @override
  Future<void> init([Map<String, Object> parameters]) async {
    await _serviceLocator.registerDependencies();

    final _analyticsService = _serviceLocator.resolve<AnalyticsService>();
    final _navigationService = _serviceLocator.resolve<NavigationService>();

    await _analyticsService.start();
    await _navigationService.pushToNewRoot(ViewNames.mainTabView);
  }
}
