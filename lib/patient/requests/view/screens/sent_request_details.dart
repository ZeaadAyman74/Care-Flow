import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:care_flow/patient/requests/business_logic/request_details/patient_request_details_cubit.dart';
import 'package:care_flow/patient/responses/view/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SentRequestDetails extends StatefulWidget {
  const SentRequestDetails({Key? key, required this.requestId})
      : super(key: key);
  final String requestId;

  @override
  State<SentRequestDetails> createState() => _SentRequestDetailsState();
}

class _SentRequestDetailsState extends State<SentRequestDetails> {
  void _getRequestDetails() async {
    await PatientRequestDetailsCubit.get(context)
        .getPatientRequestDetails(widget.requestId);
  }

  @override
  void initState() {
    _getRequestDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientRequestDetailsCubit,PatientRequestDetailsState>(
      builder: (context, state) {
        if(state is GetPatientRequestDetailsSuccess){
         return Scaffold(
            appBar: AppBar(
              title: Text(
                  'to Dr/ ${PatientRequestDetailsCubit.get(context).request!.doctorName}'),
              centerTitle: true,
              elevation: 5,
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
              children: [
                const MyTitle(
                    title: 'complaint:', icon: FontAwesomeIcons.comment),
                SizedBox(
                  height: 10.h,
                ),
                AutoSizeText(
                    PatientRequestDetailsCubit.get(context).request!.notes),
                SizedBox(
                  height: 20.h,
                ),
                const MyTitle(
                    title: 'Previous diseases:',
                    icon: FontAwesomeIcons.disease),
                SizedBox(
                  height: 10.h,
                ),
                AutoSizeText(PatientRequestDetailsCubit.get(context)
                    .request!
                    .prevDiseases),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  height: 200.w,
                  width: 200.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.r))),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: CachedNetworkImage(
                      imageUrl: PatientRequestDetailsCubit.get(context)
                          .request!
                          .xrayImage,
                      fit: BoxFit.cover),
                ),
              ],
            ),
          );
        }else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(),),
          );
        }
      },
    );
  }
}
