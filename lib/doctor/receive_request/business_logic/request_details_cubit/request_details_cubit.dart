import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite/tflite.dart';

part 'request_details_state.dart';

class RequestDetailsCubit extends Cubit<RequestDetailsState> {
  RequestDetailsCubit() : super(RequestDetailsInitial());

  static RequestDetailsCubit get(BuildContext context) =>
      BlocProvider.of<RequestDetailsCubit>(context);

  Future<File> fileFromImageUrl(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File(join(documentDirectory.path, 'imagetest.png'));
    file.writeAsBytesSync(
      response.bodyBytes,
    );
    return file;
  }

  Future<void> loadModel() async {
    emit(LoadModel());
    try {
      String res = (
          await Tflite.loadModel(
            numThreads: 2,
        model: "assets/model.tflite",
            labels: "assets/labels.txt",
          isAsset: true,
          )
      )!;
      // Tflite.close();
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
  Future<void>imageClassification(String imagePath)async{
    try{
      var recognitions = await Tflite.runModelOnImage(
          path: imagePath,
          numResults: 2,
          threshold: 0.6,
          imageMean: 127.5,
          imageStd: 127.5,
          asynch: true
      );
      if(recognitions!=null){
        result=recognitions;
        emit(PredictionSuccess());
        if (kDebugMode) {
          print(result);
        }
      }
    }catch(error){
      emit(PredictionError(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

}
