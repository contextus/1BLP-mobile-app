import 'package:arch/arch.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:one_bataan_league_pass_common/logging.dart';

class AppViewModel extends ViewModel {
  AppViewModel(AnalyticsService analyticsService, NavigationService navigationService)
      : super(analyticsService: analyticsService, navigationService: navigationService);

  @override
  Future<void> init([Map<String, Object> parameters]) async {
    await Future<void>.delayed(Duration(seconds: 1));
    await analyticsService.start();
    navigationService.pushToNewRoot(ViewNames.mainTabView);
  }
}
