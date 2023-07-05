class PatientModel {
  final String name;
  final String email;
  final String phone;
  final int age;
  final String gender;
  final String nationalId;

  PatientModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.age,
    required this.gender,
    required this.nationalId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'nId': nationalId,
      'gender': gender,
      'age': age,
    };
  }

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      nationalId: json['nId'],
      age: json['age'],
      gender: json['gender'],
    );
  }
}
