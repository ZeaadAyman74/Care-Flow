import 'package:care_flow/choose_role/business_logic/choose_role_cubit.dart';
import 'package:care_flow/core/cache_helper.dart';
import 'package:care_flow/core/fcm/fcm.dart';
import 'package:care_flow/core/network/dio_helper.dart';
import 'package:care_flow/core/notifications/notifications.dart';
import 'package:care_flow/core/routing/router.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/core/utils/snack_bar.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/doctor/diagnoses/business_logic/diagnoses_cubit/diagnoses_cubit.dart';
import 'package:care_flow/doctor/edit_profile/business_logic/edit_doctor_profile_cubit.dart';
import 'package:care_flow/doctor/layout/business_logic/home_layout_cubit/home_layout_cubit.dart';
import 'package:care_flow/doctor/layout/business_logic/new_layout_cubit/new_layout_cubit.dart';
import 'package:care_flow/doctor/login/business_logic/home_login_cubit/home_login_cubit.dart';
import 'package:care_flow/doctor/login/business_logic/login_cubit/login_cubit.dart';
import 'package:care_flow/doctor/my_private_diagnoses/business_logic/my_private_diagnoses_cubit.dart';
import 'package:care_flow/doctor/prediction/business_logic/prediction_cubit.dart';
import 'package:care_flow/doctor/private_diagnosis/business_logic/private_diagnosis_cubit.dart';
import 'package:care_flow/doctor/receive_request/business_logic/receive_request_cubit/receive_requests_cubit.dart';
import 'package:care_flow/doctor/receive_request/business_logic/request_details_cubit/request_details_cubit.dart';
import 'package:care_flow/doctor/register/business_logic/register_cubit.dart';
import 'package:care_flow/doctor/send_diagnosis/business_logic/send_diagnosis_cubit.dart';
import 'package:care_flow/patient/choose_doctor/business_logic/choose_doctor_cubit.dart';
import 'package:care_flow/patient/layout/business_logic/patient_layout_cubit.dart';
import 'package:care_flow/patient/login/business_logic/patient_home_login_cubit/patient_home_login_cubit.dart';
import 'package:care_flow/patient/login/business_logic/patient_login_cubit/patient_login_cubit.dart';
import 'package:care_flow/patient/register/business_logic/patient_register_cubit.dart';
import 'package:care_flow/patient/requests/business_logic/requests/requests_cubit.dart';
import 'package:care_flow/patient/responses/business_logic/responses_cubit/responses_cubit.dart';
import 'package:care_flow/patient/send_request/business_logic/send_request_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    sl.registerLazySingleton<MyColors>(() => const MyColors());
    sl.registerLazySingleton<AppStrings>(() => AppStrings());
    sl.registerLazySingleton<AppImages>(() => const AppImages());
    sl.registerLazySingleton<AppFunctions>(() => const AppFunctions());
    sl.registerLazySingleton<AppRouter>(() => const AppRouter());
    sl.registerLazySingleton<CacheHelper>(() => CacheHelper());
    sl.registerLazySingleton<NotificationsApi>(() => NotificationsApi());
    sl.registerLazySingleton<FirebaseApi>(() => FirebaseApi());
    sl.registerLazySingleton<DioHelper>(() => DioHelper());

    sl.registerFactory(() => ChooseRoleCubit());
    sl.registerFactory(() => DiagnosesCubit());
    sl.registerFactory(() => EditDoctorProfileCubit());
    sl.registerFactory(() => HomeLayoutCubit());
    sl.registerFactory(() => NewLayoutCubit());
    sl.registerFactory(() => HomeLoginCubit());
    sl.registerFactory(() => LoginCubit());
    sl.registerFactory(() => RegisterCubit());
    sl.registerFactory(() => MyPrivateDiagnosesCubit());
    sl.registerFactory(() => PredictionCubit());
    sl.registerFactory(() => PrivateDiagnosisCubit());
    sl.registerFactory(() => ReceiveRequestsCubit());
    sl.registerFactory(() => RequestDetailsCubit());
    sl.registerFactory(() => SendDiagnosisCubit());
    sl.registerFactory(() => ChooseDoctorCubit());
    sl.registerFactory(() => PatientLayoutCubit());
    sl.registerFactory(() => PatientHomeLoginCubit());
    sl.registerFactory(() => PatientLoginCubit());
    sl.registerFactory(() => PatientRegisterCubit());
    sl.registerFactory(() => RequestsCubit());
    sl.registerFactory(() => ResponsesCubit());
    sl.registerFactory(() => SendRequestCubit());
  }
}
