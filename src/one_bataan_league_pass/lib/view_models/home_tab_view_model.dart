import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';

class HomeTabViewModel extends ViewModelBase {
  HomeTabViewModel(
    NavigationService navigationService,
    DialogService dialogService,
  ) : super(navigationService, dialogService);

  Future<void> onShareLiveGame() => dialogService.alert('Sharing is not yet available.');
}
