class UserProfileModel {
  UserProfileModel({
    this.name,
    this.birthDate,
    this.nationality,
    this.province,
    this.cityOrMunicipality,
    this.imageUrl,
  });

  final String name;
  final DateTime birthDate;
  final String nationality;
  final String province;
  final String cityOrMunicipality;
  final String imageUrl;
}
