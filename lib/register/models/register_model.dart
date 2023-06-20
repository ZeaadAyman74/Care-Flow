class UserModel {
  final String name;
  final String email;
  final String phone;
  final String nationalId;
  final String address;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.nationalId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'nId': nationalId,
      'address': address,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      nationalId: json['nId'],
    );
  }
}
