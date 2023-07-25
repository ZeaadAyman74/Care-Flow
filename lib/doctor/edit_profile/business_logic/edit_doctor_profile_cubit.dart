import 'dart:io';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'edit_doctor_profile_state.dart';

class EditDoctorProfileCubit extends Cubit<EditDoctorProfileState> {
  EditDoctorProfileCubit() : super(EditDoctorProfileInitial());

  static EditDoctorProfileCubit get(BuildContext context) =>
      BlocProvider.of<EditDoctorProfileCubit>(context);

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

  void removeImage() {
    pickedImage = null;
    emit(PickImageSuccess());
  }

  Future<void> updateDoctor(Map<String,dynamic>newInfo) async {
    emit(EditDoctorProfileLoad());
    try {
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(sl<AppStrings>().uId)
          .update(newInfo);
      emit(EditDoctorProfileSuccess());
    } catch (error) {
      if (error is SocketException) {
        emit(EditDoctorProfileError(sl<AppStrings>().checkInternet));
      } else {
        emit(EditDoctorProfileError(sl<AppStrings>().errorMessage));
      }
    }
  }

  Future<void> updateWithImageImage({
required Map<String,dynamic>newInfo,
  }) async {
    emit(EditDoctorProfileLoad());
    try {
      var value = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('doctor_profile/${Uri.file(imagePath!).pathSegments.last}')
          .putFile(imageFile!);
      String imageUrl = await value.ref.getDownloadURL();
      newInfo.addAll({'profile image':imageUrl});
      await updateDoctor(newInfo);
    } catch (error) {
      if (error is SocketException) {
        emit(EditDoctorProfileError(sl<AppStrings>().checkInternet));
      } else {
        emit(EditDoctorProfileError(sl<AppStrings>().errorMessage));
      }
    }
  }
}
