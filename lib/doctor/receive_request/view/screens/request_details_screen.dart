import 'package:auto_size_text/auto_size_text.dart';
import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/core/utils/snack_bar.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/doctor/prediction/view/widgets/common_buttons.dart';
import 'package:care_flow/doctor/receive_request/business_logic/request_details_cubit/request_details_cubit.dart';
import 'package:care_flow/doctor/receive_request/view/widgets/info_part.dart';
import 'package:care_flow/doctor/receive_request/view/widgets/save_result_dialog.dart';
import 'package:care_flow/patient/send_request/models/request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({Key? key, required this.request})
      : super(key: key);
  final RequestModel request;

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  void _loadModel() async {
    await RequestDetailsCubit.get(context).loadModel();
  }

  @override
  void initState() {
    _loadModel();
    coronaResult='positive';
    super.initState();
  }

  String? coronaResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text('Consultation'),
        centerTitle: true,
      ),
      body: BlocListener<RequestDetailsCubit, RequestDetailsState>(
        listener: (context, state) {
          if (state is PredictionSuccess) {
            final String result = RequestDetailsCubit
                .get(context)
                .result![0]['label'];
            showDialog(context: context,
              builder: (context) =>
                  SaveResultDialog(result: result, request: widget.request),);
          } else if (state is PredictionError) {
            AppFunctions.showMySnackBar(context, AppStrings.errorMessage);
          }
        },
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          children: [
            InfoPart(
                name: widget.request.name,
                age: widget.request.age,
                email: widget.request.email,
                phone: widget.request.phone),
            Row(
              children: [
                const FaIcon(FontAwesomeIcons.comment, color: MyColors.primary),
                SizedBox(width: 5.w,),
                Text(
                  'Complaint:',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      color: MyColors.primary
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h,),
            AutoSizeText(widget.request.notes,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),),
            SizedBox(height: 10.h,),
            Row(
              children: [
                const FaIcon(FontAwesomeIcons.disease, color: MyColors.primary),
                SizedBox(width: 5.w,),
                Text(
                  'Previous diseases:',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      color: MyColors.primary

                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h,),
            AutoSizeText(widget.request.prevDiseases,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),),
            SizedBox(height: 30.h,),
            GestureDetector(
              onTap: () =>
                  context.push(Routes.completeNetworkPhotoRoute,
                      arg: {'image': widget.request.xrayImage}),
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
                    child: Image.network(
                        widget.request.xrayImage, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            coronaResult!=null?
            Column(
              children: [
                SizedBox(height: 10.h,),
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.virusCovid, color: MyColors.primary,),
                    SizedBox(width: 5.w,),
                    AutoSizeText.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'COVID-19 Check:',
                            style: TextStyle(fontSize: 18.sp, color: MyColors
                                .primary),
                          ),
                          TextSpan(
                            text: coronaResult,
                            style: TextStyle(fontSize: 18.sp, color:coronaResult=='positive'? Colors.red:
                                Colors.green),
                          ),
                        ]
                    ),
                    ),
                  ],
                )
              ],
            ):
                const SizedBox(),
            SizedBox(height: 30.h,),
            CommonButtons(textLabel: 'Check',
              textColor: MyColors.white,
              backgroundColor: MyColors.primary,
              onTap: () async {
                final imageFile = await RequestDetailsCubit.get(context)
                    .fileFromImageUrl(widget.request.xrayImage);
                await RequestDetailsCubit.get(context).imageClassification(
                    imageFile.path);
              },),
            CommonButtons(textLabel: 'Continue',
              textColor: MyColors.white,
              backgroundColor: MyColors.primary,
              onTap: () async {
                context.push(Routes.sendDiagnosisRoute,
                    arg: {'request': widget.request, 'coronaResult': null});
              },),
          ],
        ),
      ),
    );
  }
}
