class UserProfileEntity {
  UserProfileEntity({
    this.name,
    this.birthDate,
    this.nationality,
    this.province,
    this.cityOrMunicipality,
    this.zipCode,
    this.barangayDistrict,
    this.street,
    this.imageUrl,
  });

  final String name;
  final DateTime birthDate;
  final String nationality;
  final String province;
  final String cityOrMunicipality;
  final String street;
  final String barangayDistrict;
  final String zipCode;
  final String imageUrl;
}
