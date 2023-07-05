import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/patient/register/models/patient_model.dart';
import 'package:care_flow/patient/send_request/models/request_model.dart';
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

  PatientModel? patient;

  Future<void> getCurrentUser() async {
    try {
      final user = await FirebaseFirestore.instance
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
  }) async {
    try {
      RequestModel request = RequestModel(
        name: name,
        age: age,
        phone: phone,
        email: email,
        prevDiseases: prevDiseases,
        xrayImage: imageUrl,
        notes: notes,
        patientId: AppStrings.uId!,
        read: false,
        finished: false,
      );
      var doc= FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctorId)
          .collection('requests')
          .doc();
    doc.set(request.toJson(doc.id));
    } catch (error) {
      emit(SendRequestError(AppStrings.errorMessage));
    }
  }

  Future<void> uploadImage({
    required String prevDiseases,
    required String doctorId,
    required String notes,
  }) async {
    try {
      emit(SendRequestLoad());
      var value = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('X-rays/${Uri.file(imagePath!).pathSegments.last}')
          .putFile(imageFile!);
      String imageUrl = await value.ref.getDownloadURL();
      await getCurrentUser();
      sendRequest(
        name: patient!.name,
        age: patient!.age,
        prevDiseases: prevDiseases,
        email: patient!.email,
        phone: patient!.phone,
        doctorId: doctorId,
        notes: notes,
        imageUrl: imageUrl,
      );
      emit(SendRequestSuccess());
    } catch (error) {
      emit(SendRequestError(AppStrings.errorMessage));
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
