import 'package:care_flow/bloc_observer.dart';
import 'package:care_flow/core/cache_helper.dart';
import 'package:care_flow/core/routing/router.dart';
import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/core/utils/theme.dart';
import 'package:care_flow/doctor/layout/business_logic/layout_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  String initialRoute;
  AppStrings.uId = CacheHelper.getData(key: 'uId');
  initialRoute=Routes.loginRoute;
  // if (AppStrings.uId  != null) {
  //     initialRoute=Routes.homeRoute;
  // } else {
  //   initialRoute = Routes.loginRoute;
  // }
  runApp( const MyApp());
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});
// final String initialRoute;
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
          debugShowCheckedModeBanner: false,
          title: 'Care Flow',
          theme: MyTheme.lightTheme(),
          onGenerateRoute: AppRouter().generateRoute,
          initialRoute:Routes.chooseRole,
        ),
      ),
    );
  }
}
