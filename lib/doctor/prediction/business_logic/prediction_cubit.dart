import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
part 'prediction_state.dart';

class PredictionCubit extends Cubit<PredictionState> {
  PredictionCubit() : super(PredictionInitial());

  static PredictionCubit get(BuildContext context) =>
      BlocProvider.of<PredictionCubit>(context);

  final ImagePicker picker = ImagePicker();
  XFile? pickedImage;
  String? imagePath;
  File? imageFile;
  Future<void> pickImage({required ImageSource source}) async {
    try {
      pickedImage = await picker.pickImage(source: source);
      if (pickedImage != null) {
        imageFile=File(pickedImage!.path);
        imagePath = imageFile!.path;
        emit(PickImageSuccess());
      }
    } catch (error) {}
  }
  void removeImage() {
    pickedImage = null;
    result=null;
    emit(PickImageSuccess());
  }

  Future<void> loadModel() async {
    emit(LoadModelLoading());
    try {
      Tflite.close();
      String res = (await Tflite.loadModel(
          model: "assets/model.tflite", labels: "assets/labels.txt",))!;
      if (kDebugMode) {
        print(res);
      }
      emit(LoadModelSuccess());
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(LoadModelError('Some thing went wrong, please try again'));
    }
  }
  List<dynamic>?result;
  Future<void>imageClassification()async{
  try{
    var recognitions = await Tflite.runModelOnImage(
      path: imagePath!,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
      asynch: true
    );
    if(recognitions!=null){
      result=recognitions;
      emit(GetPredictionSuccess());
      if (kDebugMode) {
        print(result);
      }
    }
  }catch(error){
    emit(GetPredictionError(error.toString()));
    if (kDebugMode) {
      print(error.toString());
    }
  }
  }
}
