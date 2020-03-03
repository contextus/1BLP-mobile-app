import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_common/logging.dart';

class MainTabViewModel extends ViewModelBase {
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
