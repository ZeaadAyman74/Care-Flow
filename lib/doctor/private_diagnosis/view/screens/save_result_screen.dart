import 'dart:io';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/core/utils/my_inums.dart';
import 'package:care_flow/core/utils/snack_bar.dart';
import 'package:care_flow/doctor/prediction/view/widgets/common_buttons.dart';
import 'package:care_flow/doctor/private_diagnosis/business_logic/private_diagnosis_cubit.dart';
import 'package:care_flow/doctor/private_diagnosis/view/widgets/info_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveResultScreen extends StatefulWidget {
  const SaveResultScreen({Key? key, required this.result, required this.image})
      : super(key: key);
  final String result;
  final File image;

  @override
  State<SaveResultScreen> createState() => _SaveResultScreenState();
}

class _SaveResultScreenState extends State<SaveResultScreen> {
  String? name;
  String? age;
  String? notes;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PrivateDiagnosisCubit, PrivateDiagnosisState>(
      listener: (context, state) {
        if (state is SaveDiagnosisSuccess) {
          sl<AppFunctions>().showToast(
              message: 'Result Saved Successfully', state: ToastStates.success);
          context.pop();
        } else if (state is SaveDiagnosisError) {
          sl<AppFunctions>().showToast(
              message: state.error, state: ToastStates.error);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 5,
          title: const Text('Save Results'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InfoTextField(
                    title: 'Patient Name',
                    onSave: (value) => name = value,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  InfoTextField(
                    title: 'Patient Age',
                    onSave: (value) => age = value,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  InfoTextField(
                    title: 'Notes',
                    onSave: (value) => notes = value,
                    maxLines: 8,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  BlocBuilder<PrivateDiagnosisCubit, PrivateDiagnosisState>(
                    builder: (context, state) {
                      if (state is SaveDiagnosisLoad) {
                        return  Center(
                            child: CircularProgressIndicator(
                          color: sl<MyColors>().primary,
                        ));
                      } else {
                        return CommonButtons(
                          textLabel: 'Save',
                          textColor: Colors.white,
                          backgroundColor: sl<MyColors>().primary,
                          onTap: () async {
                            formKey.currentState!.save();
                            await PrivateDiagnosisCubit.get(context)
                                .uploadImage(
                                    name: name,
                                    age: age,
                                    result: widget.result,
                                    notes: notes,
                                    image: widget.image);
                          },
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
