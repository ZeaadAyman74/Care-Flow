class RequestModel {
  final String name;
  final String email;
  final String phone;
  final int age;
  final String patientId;
  final String notes;
  final String prevDiseases;
  final String xrayImage;
  final String? requestId;
   bool read;
   bool finished;

  RequestModel({
    required this.name,
    required this.age,
    required this.phone,
    required this.email,
    required this.prevDiseases,
    required this.xrayImage,
    required this.notes,
    required this.patientId,
    required this.read,
    required this.finished,
    this.requestId,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      name: json['name'],
      age: json['age'],
      phone: json['phone'],
      email: json['email'],
      prevDiseases: json['prevDiseases'],
      xrayImage: json['xray'],
      notes: json['notes'],
      patientId: json['patientId'],
      read: json['read'],
      requestId: json['requestId'],
      finished: json['finished'],
    );
  }

  Map<String, dynamic> toJson(String id) {
    return {
      'name': name,
      'email': email,
      'age': age,
      'phone': phone,
      'prevDiseases': prevDiseases,
      'xray': xrayImage,
      'notes':notes,
      'patientId':patientId,
      'read':read,
      'requestId':id,
      'finished':finished,
    };
  }
}
