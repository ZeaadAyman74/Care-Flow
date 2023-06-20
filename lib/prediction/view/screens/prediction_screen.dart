import 'dart:io';
import 'package:care_flow/prediction/business_logic/prediction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({Key? key}) : super(key: key);

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  void _loadModel() async {
    await PredictionCubit.get(context).loadModel();
  }

  @override
  void initState() {
    _loadModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: BlocBuilder<PredictionCubit, PredictionState>(
            builder: (context, state) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PredictionCubit.get(context).pickedImage != null
                    ? SizedBox(
                        height: 150,
                        width: 150,
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.file(File(PredictionCubit.get(context)
                                .pickedImage!
                                .path)),
                            IconButton(
                                onPressed: () =>
                                    PredictionCubit.get(context).removeImage(),
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 30,
                                ))
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          await PredictionCubit.get(context).pickImages();
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                '+',
                                style:
                                    TextStyle(fontSize: 30, color: Colors.grey),
                              ),
                              Text(
                                'Add Image',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                MaterialButton(
                  onPressed: () async =>
                      PredictionCubit.get(context).imageClassification(),
                  child: const Text('Go'),
                ),
                const SizedBox(
                  height: 30,
                ),
                PredictionCubit.get(context).result!=null?
                Text(
                  PredictionCubit.get(context).result![0]['label'],
                  style: TextStyle(
                      color: PredictionCubit.get(context).result![0]['index'] == 0
                              ? Colors.red
                              : Colors.green,
                  fontSize: 22.sp,
                    fontWeight: FontWeight.w700
                  ),
                )
                    :
                    const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
