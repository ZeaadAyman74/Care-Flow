import 'dart:io';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/core/utils/my_inums.dart';
import 'package:care_flow/core/utils/snack_bar.dart';
import 'package:care_flow/doctor/prediction/view/screens/select_photo_options_screen.dart';
import 'package:care_flow/doctor/prediction/view/widgets/common_buttons.dart';
import 'package:care_flow/doctor/private_diagnosis/view/widgets/info_text_field.dart';
import 'package:care_flow/patient/send_request/business_logic/send_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendRequestScreen extends StatefulWidget {
  const SendRequestScreen(
      {Key? key, required this.doctorName, required this.doctorId,required this.doctorSpecialize})
      : super(key: key);
  final String doctorName;
  final String doctorId;
  final String doctorSpecialize;

  @override
  State<SendRequestScreen> createState() => _SendRequestScreenState();
}

class _SendRequestScreenState extends State<SendRequestScreen> {
  final notesController = TextEditingController();
  final prevDiseasesController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String notes;
  late String preDiseases;

  @override
  Widget build(BuildContext context) {
    var cubit = SendRequestCubit.get(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 5,
          title: Text('Dr/ ${widget.doctorName}'),
          centerTitle: true,
        ),
        body: BlocListener<SendRequestCubit, SendRequestState>(
          listener: (context, state) {
            if (state is SendRequestError) {
              sl<AppFunctions>().showMySnackBar(context, state.error);
            } else if (state is SendRequestSuccess) {
              sl<AppFunctions>().showToast(
                  message: 'Request sent successfully',
                  state: ToastStates.success);
              context.pop();
            } else if (state is PickImageSuccess) {
              context.pop();
            }
          },
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            reverse: true,
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocBuilder<SendRequestCubit, SendRequestState>(
                      buildWhen: (previous, current) =>
                          current is PickImageSuccess,
                      builder: (context, state) {
                        if (SendRequestCubit.get(context).pickedImage != null) {
                          return Center(
                            child: Container(
                              height: 200.w,
                              width: 200.w,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.r))),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.file(
                                  File(SendRequestCubit.get(context)
                                      .pickedImage!
                                      .path),
                                  fit: BoxFit.cover),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                _showSelectPhotoOptions(context, cubit);
                              },
                              child: Center(
                                child: Container(
                                    height: 200.0.w,
                                    width: 200.0.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade200,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Select X-ray image',
                                          style: TextStyle(fontSize: 20.sp),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        const Icon(
                                          Icons.camera_alt_outlined,
                                          size: 30,
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InfoTextField(
                      title: 'previous diseases',
                      maxLines: 5,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return 'if there are not any previous diseases write no';
                        }
                      },
                      onSave: (value) {
                        preDiseases = value!;
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    InfoTextField(
                      title: 'Symptoms',
                      maxLines: 5,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return 'if there are not any notes write no';
                        }
                      },
                      onSave: (value) {
                        notes = value!;
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    BlocBuilder<SendRequestCubit, SendRequestState>(
                      buildWhen: (previous, current) =>
                          current is SendRequestLoad ||
                          current is SendRequestError ||
                          current is SendRequestSuccess,
                      builder: (context, state) {
                        if (state is SendRequestLoad) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return CommonButtons(
                            textLabel: 'Send',
                            textColor: Colors.white,
                            backgroundColor: sl<MyColors>().primary,
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                if (SendRequestCubit.get(context).pickedImage ==
                                    null) {
                                  sl<AppFunctions>().showMySnackBar(
                                      context, 'Please provide an X-ray image');
                                } else {
                                  formKey.currentState!.save();
                                  await SendRequestCubit.get(context).uploadImage(
                                      prevDiseases: preDiseases,
                                      doctorId: widget.doctorId,
                                      notes: notes,
                                  doctorName: widget.doctorName,
                                    doctorSpecialize: widget.doctorSpecialize
                                  );
                                }
                              }
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
      ),
    );
  }

  void _showSelectPhotoOptions(BuildContext context, SendRequestCubit cubit) {
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
              child: SelectPhotoOptionsScreen(cubit: cubit),
            );
          }),
    );
  }
}
