class ResponseModel {
  final String tips;
  final String medicine;
  final String? coronaCheck;
  final String doctorName;
  final String patientName;
  final int patientAge;
  final String patientEmail;
  final String patientPhone;
  bool isRead;
  final String xray;
  final String patientNotes;
  final String prevDiseases;
  final String? doctorImage;

  ResponseModel({
    required this.medicine,
    required this.tips,
    required this.coronaCheck,
    required this.doctorName,
    required this.patientName,
    required this.patientAge,
    required this.patientEmail,
    required this.patientPhone,
    required this.isRead,
    required this.prevDiseases,
    required this.patientNotes,
    required this.xray,
    required this.doctorImage
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      medicine: json['medicine'],
      tips: json['tips'],
      coronaCheck: json['Corona Check'],
      doctorName: json['doctor name'],
      patientName: json['patientName'],
      patientAge: json['patientAge'],
      patientEmail: json['patientEmail'],
      patientPhone: json['patientPhone'],
      isRead: json['isRead'],
      patientNotes: json['notes'],
      xray: json['xray'],
      prevDiseases: json['prev diseases'],
      doctorImage: json['doctorImage']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tips': tips,
      'medicine': medicine,
      'Corona Check': coronaCheck,
      'doctor name': doctorName,
      'patientName': patientName,
      'patientAge': patientAge,
      'patientEmail': patientEmail,
      'patientPhone': patientPhone,
      'isRead': false,
      'prev diseases': prevDiseases,
      'xray': xray,
      'notes': patientNotes,
      'doctorImage':doctorImage,
    };
  }
}
