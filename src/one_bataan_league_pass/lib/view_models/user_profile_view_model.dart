import 'package:one_bataan_league_pass/models/models.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_common/logging.dart';

class UserProfileViewModel extends ViewModelBase {
  Future<void> getUserProfileTask;

  UserProfileModel _userProfile;
  UserProfileModel get userProfile => _userProfile;
  set userProfile(UserProfileModel value) {
    if (_userProfile != value) {
      _userProfile = value;
      notifyListeners('userProfile');
    }
  }

  @override
  Future<void> init([Map<String, Object> parameters]) async {
    getUserProfile();
  }

  void getUserProfile() {
    getUserProfileTask = _onGetUserProfile();
    notifyListeners();
  }

  Future<void> _onGetUserProfile() async {
    debugInfo('Getting user profile...');

    userProfile = null;

    await Future.delayed(Duration(seconds: 3));

    userProfile = UserProfileModel(
      name: 'Juan Dela Cruz',
      birthDate: DateTime(1985, 5, 21),
      nationality: 'Filipino',
      province: 'Metro Manila',
      cityOrMunicipality: 'Quezon City',
      imageUrl: 'https://www.openhost.co.za/download/bootmin/img/avatar_lg.jpg',
    );
  }
}
