import 'package:care_flow/bloc_observer.dart';
import 'package:care_flow/core/cache_helper.dart';
import 'package:care_flow/core/fcm/fcm.dart';
import 'package:care_flow/core/network/dio_helper.dart';
import 'package:care_flow/core/routing/router.dart';
import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/core/utils/theme.dart';
import 'package:care_flow/doctor/layout/business_logic/layout_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final navigatorKey=GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  await Firebase.initializeApp();
  sl<DioHelper>().init();
  await FirebaseApi().initNotifications();
  await sl<CacheHelper>().init();
  sl<AppStrings>().uId = sl<CacheHelper>().getData(key: 'uId');
  sl<AppStrings>().role = sl<CacheHelper>().getData(key: 'role');

  final String initialRoute;
  if (sl<AppStrings>().uId == null) {
    initialRoute = Routes.chooseRole;
  } else {
    if (sl<AppStrings>().role == 'p') {
      initialRoute = Routes.patientLayoutRoute;
    } else {
      initialRoute = Routes.newLayout;
    }
  }

  runApp(MyApp(
    initialRoute: initialRoute,
  ));
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LayoutCubit(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'MEDIX-E',
          theme: MyTheme.lightTheme(),
          onGenerateRoute: const AppRouter().generateRoute,
          initialRoute: widget.initialRoute,
        ),
      ),
    );
  }
}
