import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_business/managers.dart';
import 'package:one_bataan_league_pass_common/logging.dart';

class UserProfileViewModel extends ViewModelBase {
  UserProfileViewModel(this._userProfileManager) {
    getUserProfile = _onGetUserProfile();
  }

  final UserProfileManager _userProfileManager;

  UserProfileEntity userProfile;

  Future<UserProfileEntity> getUserProfile;

  void refetchUserProfile() {
    getUserProfile = _onGetUserProfile();
    notifyListeners();
  }

  Future<UserProfileEntity> _onGetUserProfile() async {
    debugInfo('Getting user profile...');

    try {
      return userProfile = await _userProfileManager.getUserProfile();
    } on Exception catch (e) {
      debugError('Failed to retrieve user profile', e);
      rethrow;
    }
  }
}
