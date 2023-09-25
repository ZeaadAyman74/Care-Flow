import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/doctor/receive_request/view/widgets/info_part.dart';
import 'package:care_flow/patient/responses/business_logic/responses_details_cubit/responses_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:care_flow/patient/responses/view/widgets/title.dart';

class ResponseDetailsScreen extends StatefulWidget {
  const ResponseDetailsScreen({Key? key, required this.responseId})
      : super(key: key);
  final String responseId;

  @override
  State<ResponseDetailsScreen> createState() => _ResponseDetailsScreenState();
}

class _ResponseDetailsScreenState extends State<ResponseDetailsScreen> {
  void _getResponseDetails() async {
    await ResponsesDetailsCubit.get(context)
        .getResponseDetails(widget.responseId);
  }

  @override
  void initState() {
    _getResponseDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis'),
        centerTitle: true,
        elevation: 5,
      ),
      body: BlocBuilder<ResponsesDetailsCubit, ResponsesDetailsState>(
        builder: (context, state) {
          if (state is GetResponseDetailsSuccess) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              children: [
                InfoPart(
                    name: ResponsesDetailsCubit.get(context)
                        .response!
                        .patientName,
                    age:
                        ResponsesDetailsCubit.get(context).response!.patientAge,
                    email: ResponsesDetailsCubit.get(context)
                        .response!
                        .patientEmail,
                    phone: ResponsesDetailsCubit.get(context)
                        .response!
                        .patientPhone),
                Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: sl<MyColors>().primary),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Your Request',
                          style: TextStyle(
                              fontSize: 24.sp,
                              color: sl<MyColors>().primary,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const MyTitle(
                          title: 'complaint:', icon: FontAwesomeIcons.comment),
                      SizedBox(
                        height: 10.h,
                      ),
                      AutoSizeText(ResponsesDetailsCubit.get(context)
                          .response!
                          .patientNotes),
                      SizedBox(
                        height: 20.h,
                      ),
                      const MyTitle(
                          title: 'Previous diseases:',
                          icon: FontAwesomeIcons.disease),
                      SizedBox(
                        height: 10.h,
                      ),
                      AutoSizeText(ResponsesDetailsCubit.get(context)
                          .response!
                          .prevDiseases),
                      SizedBox(
                        height: 30.h,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 200.w,
                          width: 200.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r))),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: CachedNetworkImage(
                            imageUrl: ResponsesDetailsCubit.get(context)
                                .response!
                                .xray,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: sl<MyColors>().primary),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Doctor Diagnosis',
                          style: TextStyle(
                              fontSize: 24.sp,
                              color: sl<MyColors>().primary,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const MyTitle(
                        icon: FontAwesomeIcons.check,
                        title: 'Checks',
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.virusCovid,
                            color: sl<MyColors>().primary,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          AutoSizeText.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: 'COVID-19 Check:',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: sl<MyColors>().primary),
                              ),
                              TextSpan(
                                text: ResponsesDetailsCubit.get(context)
                                    .response!
                                    .coronaCheck,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: ResponsesDetailsCubit.get(context)
                                                .response!
                                                .coronaCheck ==
                                            'positive'
                                        ? Colors.red
                                        : Colors.green),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const MyTitle(
                          title: 'Tips', icon: Icons.tips_and_updates),
                      AutoSizeText(
                          ResponsesDetailsCubit.get(context).response!.tips,
                          style: TextStyle(fontSize: 18.sp),
                          maxLines: 100),
                      SizedBox(
                        height: 20.h,
                      ),
                      const MyTitle(
                          title: 'Medicine',
                          icon: Icons.medical_information_outlined),
                      AutoSizeText(
                          ResponsesDetailsCubit.get(context).response!.medicine,
                          style: TextStyle(fontSize: 18.sp),
                          maxLines: 100),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
