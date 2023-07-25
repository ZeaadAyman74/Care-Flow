import 'dart:io';
import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/doctor/prediction/business_logic/prediction_cubit.dart';
import 'package:care_flow/doctor/prediction/view/widgets/common_buttons.dart';
import 'package:care_flow/doctor/prediction/view/widgets/result_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'select_photo_options_screen.dart';

class CoronaDetectionScreen extends StatefulWidget {
  const CoronaDetectionScreen({super.key});

  @override
  State<CoronaDetectionScreen> createState() => _CoronaDetectionScreenState();
}

class _CoronaDetectionScreenState extends State<CoronaDetectionScreen> {
  void _showSelectPhotoOptions(BuildContext context,PredictionCubit cubit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child:  SelectPhotoOptionsScreen(cubit: cubit),
            );
          }),
    );
  }

String? result;
  @override
  Widget build(BuildContext context) {
    var cubit=PredictionCubit.get(context);
    return BlocListener<PredictionCubit,PredictionState>(
      listener: (context, state) {
        if(state is PickImageSuccess){
          Navigator.pop(context);
        }
        if(state is GetPredictionSuccess){
          result=PredictionCubit.get(context).result![0]['label'];
          showDialog(context: context, builder: (context) => ResultDialog(result:result!,cubit: cubit,),);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('COVID-19 Detection'),
          centerTitle: true,
          elevation: 5,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h, top: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(
                    'Set a Photo of your lung',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    'Try set the photo with a high quality to get the best results',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              BlocBuilder<PredictionCubit,PredictionState>(
                builder: (context, state) {
                  if(PredictionCubit.get(context).pickedImage!=null){
                    return GestureDetector(
                      onTap: () => context.push(Routes.completePhotoRoute,arg:{'image':PredictionCubit.get(context).pickedImage!.path} ),
                      child: Center(
                        child: InteractiveViewer(
                          clipBehavior: Clip.none,
                          panEnabled: false,
                          minScale: 1,
                          maxScale: 4,
                          child: Container(
                            height: 200.w,
                            width: 200.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.r))
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.file(File(PredictionCubit.get(context).pickedImage!.path),fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    );
                  }else {
                    return Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          _showSelectPhotoOptions(context,cubit);
                        },
                        child: Center(
                          child: Container(
                              height: 200.0.w,
                              width: 200.0.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200,
                              ),
                              child: const Center(
                                child: Text(
                                  'No image selected',
                                  style: TextStyle(fontSize: 20),
                                ),
                              )),
                        ),
                      ),
                    );
                  }
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CommonButtons(
                    onTap: () async {
                      await PredictionCubit.get(context).imageClassification();
                    },
                    backgroundColor: sl<MyColors>().primary,
                    textColor: Colors.white,
                    textLabel: 'Check',
                  ),
                  SizedBox(height: 10.h,),
                  CommonButtons(
                    onTap: () => _showSelectPhotoOptions(context,cubit),
                    backgroundColor: sl<MyColors>().primary,
                    textColor: Colors.white,
                    textLabel: 'Add a Photo',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
