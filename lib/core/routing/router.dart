import 'package:care_flow/choose_role/business_logic/choose_role_cubit.dart';
import 'package:care_flow/choose_role/choose_role.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/doctor/diagnoses/business_logic/diagnoses_cubit/diagnoses_cubit.dart';
import 'package:care_flow/doctor/diagnoses/business_logic/diagnosis_details_cubit/diagnosis_details_cubit.dart';
import 'package:care_flow/doctor/diagnoses/view/diagnosis_details_screen.dart';
import 'package:care_flow/doctor/layout/business_logic/home_layout_cubit/home_layout_cubit.dart';
import 'package:care_flow/doctor/layout/business_logic/new_layout_cubit/new_layout_cubit.dart';
import 'package:care_flow/doctor/layout/view/screens/layout_screen.dart';
import 'package:care_flow/doctor/layout/view/screens/new_layout.dart';
import 'package:care_flow/doctor/login/business_logic/home_login_cubit/home_login_cubit.dart';
import 'package:care_flow/doctor/login/view/screens/home_login.dart';
import 'package:care_flow/doctor/lung_diseases/view/lung_screen.dart';
import 'package:care_flow/doctor/my_private_diagnoses/view/private_diagnosis_details.dart';
import 'package:care_flow/doctor/prediction/business_logic/prediction_cubit.dart';
import 'package:care_flow/doctor/prediction/view/screens/complete_photo_screen.dart';
import 'package:care_flow/doctor/prediction/view/screens/set_photo_screen.dart';
import 'package:care_flow/doctor/private_diagnosis/business_logic/private_diagnosis_cubit.dart';
import 'package:care_flow/doctor/private_diagnosis/view/screens/save_result_screen.dart';
import 'package:care_flow/doctor/receive_request/business_logic/receive_request_cubit/receive_requests_cubit.dart';
import 'package:care_flow/doctor/receive_request/business_logic/request_details_cubit/request_details_cubit.dart';
import 'package:care_flow/doctor/receive_request/view/screens/request_details_screen.dart';
import 'package:care_flow/doctor/receive_request/view/widgets/complete_photo.dart';
import 'package:care_flow/doctor/send_diagnosis/business_logic/send_diagnosis_cubit.dart';
import 'package:care_flow/doctor/send_diagnosis/view/diagnosis_screen.dart';
import 'package:care_flow/laboratory/covid_check.dart';
import 'package:care_flow/laboratory/lab_lung_diseases.dart';
import 'package:care_flow/laboratory/lab_specializations.dart';
import 'package:care_flow/medicine_recommender/medicine_recommender_screen.dart';
import 'package:care_flow/patient/choose_doctor/business_logic/choose_doctor_cubit.dart';
import 'package:care_flow/patient/choose_doctor/view/screens/choose_doctor_screen.dart';
import 'package:care_flow/patient/home/view/patient_home_screen.dart';
import 'package:care_flow/patient/layout/business_logic/patient_layout_cubit.dart';
import 'package:care_flow/patient/layout/view/patient_layout_screen.dart';
import 'package:care_flow/patient/login/business_logic/patient_home_login_cubit/patient_home_login_cubit.dart';
import 'package:care_flow/patient/login/view/screens/home_login_screen.dart';
import 'package:care_flow/patient/requests/business_logic/request_details/patient_request_details_cubit.dart';
import 'package:care_flow/patient/requests/business_logic/requests/requests_cubit.dart';
import 'package:care_flow/patient/requests/view/screens/sent_request_details.dart';
import 'package:care_flow/patient/responses/business_logic/responses_cubit/responses_cubit.dart';
import 'package:care_flow/patient/responses/business_logic/responses_details_cubit/responses_details_cubit.dart';
import 'package:care_flow/patient/responses/view/screens/response_details_screen.dart';
import 'package:care_flow/patient/send_request/business_logic/send_request_cubit.dart';
import 'package:care_flow/patient/send_request/view/screens/send_request_screen.dart';
import 'package:care_flow/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  const AppRouter();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return CustomPageRouter(const SplashScreen());
      case Routes.chooseRole:
        return _getPageRoute(BlocProvider(
            create: (context) => sl<ChooseRoleCubit>(),
            child: const ChooseRoleScreen()));
      case Routes.loginRoute:
        return _getPageRoute(BlocProvider<HomeLoginCubit>(
            create: (context) => sl<HomeLoginCubit>(),
            child: const HomeLoginScreen()));
      case Routes.newLayout:
        return _getPageRoute(BlocProvider(
          create: (context) => sl<NewLayoutCubit>(),
          child: const NewLayout(),
        ));
      case Routes.layoutRoute:
        return _getPageRoute(MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => HomeLayoutCubit(),
          ),
          BlocProvider(
            create: (context) => sl<DiagnosesCubit>(),
          ),
          BlocProvider(
            create: (context) => sl<ReceiveRequestsCubit>(),
          ),
        ], child: const LayoutScreen()));
      case Routes.lungRoute:
        return _getPageRoute(const LungScreen());
      case Routes.predictionRoute:
        return _getPageRoute(BlocProvider(
          create: (context) => sl<PredictionCubit>(),
          child: const CoronaDetectionScreen(),
        ));
      case Routes.completePhotoRoute:
        var arg = settings.arguments as Map;
        return _getPageRoute(CompletePhotoScreen(image: arg['image']));
      case Routes.savePrivateResult:
        var arg = settings.arguments as Map;
        return _getPageRoute(BlocProvider(
          create: (context) => sl<PrivateDiagnosisCubit>(),
          child: SaveResultScreen(result: arg['result'], image: arg['image']),
        ));
      case Routes.requestDetailsRoute:
        var arg = settings.arguments as Map;
        return _getPageRoute(BlocProvider(
          create: (context) => sl<RequestDetailsCubit>(),
          child: RequestDetailsScreen(
            requestId: arg['id'],
          ),
        ));
      case Routes.diagnosisDetailsRoute:
        var arg = settings.arguments as Map;
        return _getPageRoute(BlocProvider(
          create: (context) => DiagnosisDetailsCubit(),
          child: DiagnosisDetailsScreen(diagnosisId: arg['diagnosisId']),
        ));
      case Routes.completeNetworkPhotoRoute:
        var arg = settings.arguments as Map;
        return _getPageRoute(CompletePhoto(image: arg['image']));
      case Routes.sendDiagnosisRoute:
        var arg = settings.arguments as Map;
        return _getPageRoute(BlocProvider(
          create: (context) => sl<SendDiagnosisCubit>(),
          child: DiagnosisScreen(
              request: arg['request'], coronaResult: arg['coronaResult']),
        ));
      case Routes.privateDiagnosisRoute:
        var model = settings.arguments as Map<String, dynamic>;
        return _getPageRoute(PrivateDiagnosisDetails(model: model['model']));

      ////////////////////////////////////////////////////////////////////////////////////////////////////////////

      case Routes.patientLoginRoute:
        return _getPageRoute(BlocProvider(
          create: (context) => sl<PatientHomeLoginCubit>(),
          child: const PatientHomeLogin(),
        ));
      case Routes.patientLayoutRoute:
        return _getPageRoute(MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => sl<PatientLayoutCubit>(),
          ),
          BlocProvider(
            create: (context) => sl<ResponsesCubit>(),
          ),
          BlocProvider(
            create: (context) => sl<RequestsCubit>(),
          ),
        ], child: const PatientLayoutScreen()));
      case Routes.chooseDoctorRoute:
        var arg = settings.arguments as Map;
        return _getPageRoute(BlocProvider(
          create: (context) => sl<ChooseDoctorCubit>(),
          child: ChooseDoctorScreen(specialize: arg['specialize']),
        ));
      case Routes.sendRequestRoute:
        var arg = settings.arguments as Map;
        return _getPageRoute(BlocProvider(
          create: (context) => sl<SendRequestCubit>(),
          child: SendRequestScreen(
            doctorName: arg['doctorName'],
            doctorId: arg['doctorId'],
            doctorSpecialize: arg['doctorSpecialize'],
            doctorDeviceToken: arg['doctorDeviceToken'],
          ),
        ));
      case Routes.responseDetailsRoute:
        var arg = settings.arguments as Map;
        return _getPageRoute(BlocProvider(
          create: (context) => ResponsesDetailsCubit(),
          child: ResponseDetailsScreen(
            responseId: arg['responseId'],
          ),
        ));
      case Routes.sentRequestDetailsRoute:
        var arg = settings.arguments as Map;
        return _getPageRoute(BlocProvider(
            create: (context) => PatientRequestDetailsCubit(),
            child: SentRequestDetails(requestId: arg['requestId'])));
      case Routes.diagnosisRoute:
        return _getPageRoute(const PatientHomeScreen());
      case Routes.medicineRecommenderRoute:
        return _getPageRoute(const MedicineRecommenderScreen());
      case Routes.labSpecializationsRoute:
        return _getPageRoute(const LabSpecializationsScreen());
      case Routes.labLungDiseases:
        return _getPageRoute(const LabLungDiseases());
      case Routes.labCheckRoute:
        return _getPageRoute(const CovidCheck());
    }
    return null;
  }

  PageRoute _getPageRoute(Widget child) {
    return CustomPageRouter(child);
  }
}

class CustomPageRouter<T> extends PageRouteBuilder<T> {
  final Widget child;

  CustomPageRouter(this.child)
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                child,
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              const begin = 0.0;
              const end = 1.0;
              var tween = Tween<double>(begin: begin, end: end);
              return FadeTransition(
                opacity: animation.drive(tween),
                child: child,
              );
            });
}
