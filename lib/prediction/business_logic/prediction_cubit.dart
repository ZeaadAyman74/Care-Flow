import 'dart:io';
import 'package:flutter/cupertino.dart';
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

  Future<void> pickImages() async {
    try {
      pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        imagePath = File(pickedImage!.path).path;
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
      print(res);
      emit(LoadModelSuccess());
    } catch (error) {
      print(error.toString());
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
    }
  }catch(error){
    emit(GetPredictionError(error.toString()));
    print(error.toString());
  }
  }

}
