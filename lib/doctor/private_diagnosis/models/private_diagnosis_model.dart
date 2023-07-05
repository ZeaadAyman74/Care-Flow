class PrivateDiagnosisModel {
  final String? name;
  final String? age;
  final String result;
  final String? notes;
  final String image;

  PrivateDiagnosisModel({
   required this.age,
    required this.name,
    required this.result,
    required this.notes,
    required this.image
});

  factory PrivateDiagnosisModel.fromJson(Map<String,dynamic>json){
    return PrivateDiagnosisModel(age: json['age'], name:json['name'], result: json['result'],notes:json['notes'],image: json['base64Image']);
  }

  Map<String,dynamic> toJson(){
    return {
      'name':name??'NO',
    'age':age??'NO',
    'notes':notes??'No',
      result:result,
      image:image,
    };
  }
}