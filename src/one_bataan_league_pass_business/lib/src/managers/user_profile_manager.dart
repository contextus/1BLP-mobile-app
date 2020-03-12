import 'package:one_bataan_league_pass_business/src/entities/user_profile_entity.dart';

class UserProfileManager {
  Future<UserProfileEntity> getUserProfile() async {
    await Future.delayed(Duration(seconds: 1));

    return UserProfileEntity(
      name: 'Juan Dela Cruz',
      birthDate: DateTime(1985, 5, 21),
      nationality: 'Filipino',
      province: 'Metro Manila',
      cityOrMunicipality: 'Quezon City',
      street: '43A Blk. A, Maginhawa Street',
      barangayDistrict: 'Barangay Maharlika, Diliman',
      zipCode: '1100',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTKM9BUy0eVYn8_C3sg0J40Oa5MlWpFbS83fleauNdF4W5HQQJQ',
    );
  }
}
