import 'package:one_bataan_league_pass/view_models/view_model_base.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_common/logging.dart';

class MainViewModel extends ViewModelBase {
  MainViewModel(this.homeViewModel);

  final HomeViewModel homeViewModel;

  int _currentIndex = 0;
  int get currentPageIndex => _currentIndex;
  set currentPageIndex(int value) {
    if (_currentIndex != value) {
      _currentIndex = value;
      notifyListeners('currentPageIndex');
    }
  }

  Future<void> onOpenAccount() async {
    debugInfo('Opening account...');
  }
}
