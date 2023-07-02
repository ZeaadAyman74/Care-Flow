import 'package:care_flow/choose_role/business_logic/choose_role_cubit.dart';
import 'package:care_flow/choose_role/choose_role.dart';
import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/doctor/layout/business_logic/layout_cubit.dart';
import 'package:care_flow/doctor/layout/view/screens/layout_screen.dart';
import 'package:care_flow/doctor/login/business_logic/home_login_cubit/home_login_cubit.dart';
import 'package:care_flow/doctor/login/view/screens/home_login.dart';
import 'package:care_flow/doctor/lung_diseases/view/lung_screen.dart';
import 'package:care_flow/doctor/prediction/business_logic/prediction_cubit.dart';
import 'package:care_flow/doctor/prediction/view/screens/complete_photo_screen.dart';
import 'package:care_flow/doctor/prediction/view/screens/set_photo_screen.dart';
import 'package:care_flow/doctor/private_diagnosis/business_logic/private_diagnosis_cubit.dart';
import 'package:care_flow/doctor/private_diagnosis/view/screens/save_result_screen.dart';
import 'package:care_flow/patient/choose_doctor/business_logic/choose_doctor_cubit.dart';
import 'package:care_flow/patient/choose_doctor/view/screens/choose_doctor_screen.dart';
import 'package:care_flow/patient/layout/business_logic/patient_layout_cubit.dart';
import 'package:care_flow/patient/layout/view/patient_layout_screen.dart';
import 'package:care_flow/patient/login/business_logic/patient_home_login_cubit/patient_home_login_cubit.dart';
import 'package:care_flow/patient/login/view/screens/home_login_screen.dart';
import 'package:care_flow/patient/send_request/business_logic/send_request_cubit.dart';
import 'package:care_flow/patient/send_request/view/screens/send_request_screen.dart';
import 'package:care_flow/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  AppRouter();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return CustomPageRouter(const SplashScreen());
      case Routes.chooseRole:
        return _getPageRoute(BlocProvider(
            create: (context) => ChooseRoleCubit(),
            child: const ChooseRoleScreen()));
      case Routes.loginRoute:
        return _getPageRoute(BlocProvider<HomeLoginCubit>(
            create: (context) => HomeLoginCubit(),
            child: const HomeLoginScreen()));
      case Routes.layoutRoute:
        return _getPageRoute(BlocProvider(
            create: (context) => LayoutCubit(), child: const LayoutScreen()));
      case Routes.lungRoute:
        return _getPageRoute(const LungScreen());
      case Routes.predictionRoute:
        return _getPageRoute(BlocProvider(
          create: (context) => PredictionCubit(),
          child: const CoronaDetectionScreen(),
        ));
      case Routes.completePhotoRoute:
        var arg = settings.arguments as Map;
        return _getPageRoute(CompletePhotoScreen(image: arg['image']));
      case Routes.savePrivateResult:
        var arg = settings.arguments as Map;
        return _getPageRoute(BlocProvider(
          create: (context) => PrivateDiagnosisCubit(),
          child: SaveResultScreen(result: arg['result'], image: arg['image']),
        ));
      case Routes.patientLoginRoute:
        return _getPageRoute(BlocProvider(
          create: (context) => PatientHomeLoginCubit(),
          child: const PatientHomeLogin(),
        ));
      case Routes.patientLayoutRoute:
        return _getPageRoute(BlocProvider(
          create: (context) => PatientLayoutCubit(),
          child: const PatientLayoutScreen(),
        ));
      case Routes.chooseDoctorRoute:
        var arg = settings.arguments as Map;
        return _getPageRoute(BlocProvider(
          create: (context) => ChooseDoctorCubit(),
          child: ChooseDoctorScreen(specialize: arg['specialize']),
        ));
      case Routes.sendRequestRoute:
        var arg = settings.arguments as Map;
        return _getPageRoute(BlocProvider(
          create: (context) => SendRequestCubit(),
          child: SendRequestScreen(
            doctorName: arg['doctorName'],
            doctorId: arg['doctorId'],
          ),
        ));
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
