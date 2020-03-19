import 'package:intl/intl.dart';
import 'package:one_bataan_league_pass/models/models.dart';
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

  List<SingleDetailListItemModel> userProfileDetails = [];

  Future<UserProfileEntity> getUserProfile;

  void refetchUserProfile() {
    getUserProfile = _onGetUserProfile();
    notifyListeners();
  }

  Future<UserProfileEntity> _onGetUserProfile() async {
    debugInfo('Getting user profile...');

    try {
      userProfile = await _userProfileManager.getUserProfile();

      userProfileDetails
        ..clear()
        ..add(SingleDetailListItemModel('BIRTHDATE', DateFormat('MMMM dd, y').format(userProfile.birthDate)))
        ..add(SingleDetailListItemModel('NATIONALITY', userProfile.nationality))
        ..add(SingleDetailListItemModel('STREET', userProfile.street))
        ..add(SingleDetailListItemModel('BARANGAY/DISTRICT', userProfile.barangayDistrict))
        ..add(SingleDetailListItemModel('CITY/MUNICIPALITY/TOWN', userProfile.cityOrMunicipality))
        ..add(SingleDetailListItemModel('ZIPCODE', userProfile.zipCode))
        ..add(SingleDetailListItemModel('PROVINCE', userProfile.province));

      return userProfile;
    } on Exception catch (e) {
      debugError('Failed to retrieve user profile', e);
      rethrow;
    }
  }
}
