import 'dart:io';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/fcm/fcm.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/patient/register/models/patient_model.dart';
import 'package:care_flow/patient/send_request/models/request_details_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'send_request_state.dart';

class SendRequestCubit extends Cubit<SendRequestState> {
  SendRequestCubit() : super(SendRequestInitial());

  static SendRequestCubit get(BuildContext context) =>
      BlocProvider.of<SendRequestCubit>(context);

FirebaseFirestore firebase=FirebaseFirestore.instance;

  PatientModel? patient;
  Future<void> getCurrentUser() async {
    try {
      final user = await firebase
          .collection('patients')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      patient = PatientModel.fromJson(user.data()!);
    } catch (error) {}
  }

  Future<void> sendRequest({
    required String name,
    required int age,
    required String prevDiseases,
    required String email,
    required String phone,
    required String doctorId,
    required String notes,
    required String imageUrl,
    required String doctorName,
    required String doctorSpecialize,
    required String doctorDeviceToken,
  }) async {
    try {
      RequestDetailsModel request = RequestDetailsModel(
        name: name,
        age: age,
        phone: phone,
        email: email,
        prevDiseases: prevDiseases,
        xrayImage: imageUrl,
        notes: notes,
        patientId: sl<AppStrings>().uId!,
        doctorSpecialize:doctorSpecialize,
        doctorName: doctorName,
        time: Timestamp.now(),
        read: false,
        finished: false,
      );
      var doc= firebase
          .collection('doctors')
          .doc(doctorId)
          .collection('requests')
          .doc();
   await doc.set(request.toJson(doc.id));
   await sl<FirebaseApi>().pushNotification(token: doctorDeviceToken, data:request.toJson(doc.id), notification: {
     'title':name,
     'body':'Diagnostic Request',
     'image':'https://scontent.fcai20-3.fna.fbcdn.net/v/t39.30808-6/340112952_142220165469022_7534464729291194521_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=81D7rxC8O6gAX8Q_p6m&_nc_ht=scontent.fcai20-3.fna&oh=00_AfDhYa-KGWsg_QhfqbrqlNAYEYt0UZcO9dC7-tU2B7MMew&oe=64C8A366'
   });
   var patientDoc= firebase.collection('patients').doc(sl<AppStrings>().uId).collection('requests').doc();
   await patientDoc.set(request.toJson(patientDoc.id));
    } catch (error) {
      emit(SendRequestError(sl<AppStrings>().errorMessage));
    }
  }

  Future<void> uploadImage({
    required String prevDiseases,
    required String doctorId,
    required String doctorName,
    required String doctorSpecialize,
    required String notes,
    required String doctorDeviceToken,
  }) async {
    try {
      emit(SendRequestLoad());
      var value = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('X-rays/${Uri.file(imagePath!).pathSegments.last}')
          .putFile(imageFile!);
      String imageUrl = await value.ref.getDownloadURL();
      await getCurrentUser();
     await sendRequest(
        name: patient!.name,
        age: patient!.age,
        prevDiseases: prevDiseases,
        email: patient!.email,
        phone: patient!.phone,
        doctorId: doctorId,
        notes: notes,
        imageUrl: imageUrl,
       doctorName:doctorName,
       doctorSpecialize: doctorSpecialize,
       doctorDeviceToken: doctorDeviceToken,
      );
      emit(SendRequestSuccess());
    } catch (error) {
      emit(SendRequestError(sl<AppStrings>().errorMessage));
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  final ImagePicker picker = ImagePicker();
  XFile? pickedImage;
  String? imagePath;
  File? imageFile;

  Future<void> pickImage({required ImageSource source}) async {
    try {
      pickedImage = await picker.pickImage(source: source);
      if (pickedImage != null) {
        imageFile = File(pickedImage!.path);
        imagePath = imageFile!.path;
        emit(PickImageSuccess());
      }
    } catch (error) {}
  }
}
