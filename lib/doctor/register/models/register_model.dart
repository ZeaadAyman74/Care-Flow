class DoctorModel {
  final String name;
  final String email;
  final String phone;
  final String nationalId;
  final String address;
  final String specialize;
  final String about;
  final String uId;
  final String? profileImage;

  DoctorModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.nationalId,
    required this.specialize,
    required this.about,
    required this.uId,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'nId': nationalId,
      'address': address,
      'specialize':specialize,
      'about':about,
      'uId':uId,
      'profile image':profileImage,
    };
  }

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      nationalId: json['nId'],
      specialize:json['specialize'],
      about: json['about'],
      uId:json['uId'],
      profileImage: json['profile image'],
    );
  }
}
