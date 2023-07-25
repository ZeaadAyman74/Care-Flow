import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/core/utils/my_inums.dart';
import 'package:care_flow/core/utils/snack_bar.dart';
import 'package:care_flow/doctor/layout/business_logic/layout_cubit.dart';
import 'package:care_flow/doctor/prediction/view/widgets/common_buttons.dart';
import 'package:care_flow/doctor/private_diagnosis/view/widgets/info_text_field.dart';
import 'package:care_flow/doctor/send_diagnosis/business_logic/send_diagnosis_cubit.dart';
import 'package:care_flow/patient/send_request/models/request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen(
      {Key? key, required this.request, required this.coronaResult})
      : super(key: key);
  final RequestModel request;
  final String? coronaResult;

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  late String tips;
  late String medicine;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendDiagnosisCubit, SendDiagnosisState>(
      listener: (context, state) {
        if (state is SendDiagnosisSuccess) {
          SendDiagnosisCubit.get(context).markFinish(widget.request.requestId!);
          // ReceiveRequestsCubit.get(context).requests.firstWhere((element) => element==widget.request).finished=true;
          context.pop();
          sl<AppFunctions>().showToast(
              message: 'Diagnosis Sent Successfully',
              state: ToastStates.success);
        } else if (state is SendDiagnosisError) {
          sl<AppFunctions>().showMySnackBar(context, state.error);
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text('Send Diagnosis'),
              centerTitle: true,
              elevation: 5,
            ),
            body: SingleChildScrollView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InfoTextField(
                      title: 'Tips',
                      maxLines: 5,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please write your tips';
                        } else {
                          return null;
                        }
                      },
                      onSave: (value) {
                        tips = value!;
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    InfoTextField(
                      title: 'Medicine',
                      maxLines: 5,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please write the medicine';
                        } else {
                          return null;
                        }
                      },
                      onSave: (value) {
                        medicine = value!;
                      },
                    ),
                    TextButton(onPressed: () =>context.push(Routes.medicineRecommenderRoute) , child: Row(
                      children:  [
                        const Icon(Icons.help,color: Colors.grey,),
                        SizedBox(width: 2.w,),
                         Text('Medicine recommendation to help you',style: TextStyle(color: sl<MyColors>().primary,fontSize: 14.sp,fontWeight: FontWeight.w500),),
                      ],
                    ) ),
                    SizedBox(
                      height: 20.h,
                    ),
                    BlocBuilder<SendDiagnosisCubit, SendDiagnosisState>(
                      builder: (context, state) {
                        if (state is SendDiagnosisLoad) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return CommonButtons(
                            textLabel: 'Send',
                            textColor: Colors.white,
                            backgroundColor: sl<MyColors>().primary,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                SendDiagnosisCubit.get(context).sendDiagnosis(
                                  tips: tips,
                                  medicine: medicine,
                                  coronaCheck: widget.coronaResult,
                                  doctorName: LayoutCubit.get(context).currentDoctor!.name,
                                  currentRequest: widget.request,
                                  doctorImage: LayoutCubit.get(context).currentDoctor!.profileImage,
                                );
                              }
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
