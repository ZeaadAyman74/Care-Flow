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
  final String initialRoute;
  AppStrings.uId = CacheHelper.getData(key: 'uId');
  AppStrings.role=CacheHelper.getData(key: 'role');
  if (AppStrings.uId  == null) {
      initialRoute=Routes.chooseRole;
  } else {
    if(AppStrings.role=='p'){
      initialRoute = Routes.patientLayoutRoute;
    }else {
      initialRoute = Routes.newLayout;
    }
  }
  runApp(  MyApp(initialRoute: initialRoute,));
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,required this.initialRoute});
final String initialRoute;
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
          initialRoute:initialRoute,
        ),
      ),
    );
  }
}
