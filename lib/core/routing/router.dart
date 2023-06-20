import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/home/view/screens/home.dart';
import 'package:care_flow/layout/business_logic/layout_cubit.dart';
import 'package:care_flow/layout/view/screens/layout_screen.dart';
import 'package:care_flow/login/business_logic/home_login_cubit/home_login_cubit.dart';
import 'package:care_flow/login/view/screens/home_login.dart';
import 'package:care_flow/lung_diseases/view/screens/lung_screen.dart';
import 'package:care_flow/prediction/business_logic/prediction_cubit.dart';
import 'package:care_flow/prediction/view/screens/prediction_screen.dart';
import 'package:care_flow/prediction/view/screens/set_photo_screen.dart';
import 'package:care_flow/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  AppRouter();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return CustomPageRouter(const SplashScreen());
      case Routes.loginRoute:
        return _getPageRoute(BlocProvider<HomeLoginCubit>(
            create: (context) => HomeLoginCubit(),
            child: const HomeLoginScreen()));
      case Routes.layoutRoute:
        return _getPageRoute(BlocProvider(
            create: (context) => LayoutCubit(), child: const LayoutScreen()));
      case Routes.lungRoute :
        return _getPageRoute(const LungScreen());
      case Routes.predictionRoute:
        return _getPageRoute(BlocProvider(
          create: (context) => PredictionCubit(),
          child: const CoronaDetectionScreen(),
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
