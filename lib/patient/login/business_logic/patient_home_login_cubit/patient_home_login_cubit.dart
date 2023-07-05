import 'package:care_flow/patient/login/business_logic/patient_login_cubit/patient_login_cubit.dart';
import 'package:care_flow/patient/login/view/screens/patient_login_screen.dart';
import 'package:care_flow/patient/register/business_logic/patient_register_cubit.dart';
import 'package:care_flow/patient/register/view/screens/patient_register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'patient_home_login_state.dart';

class PatientHomeLoginCubit extends Cubit<PatientHomeLoginState> {
  PatientHomeLoginCubit() : super(PatientHomeLoginInitial());

  static PatientHomeLoginCubit get(BuildContext context) =>
      BlocProvider.of<PatientHomeLoginCubit>(context);

  Widget view = BlocProvider(
    create: (context) => PatientLoginCubit(),
    child: const PatientLoginScreen(),
  );

  void changeToLogin() {
    view = BlocProvider(
      create: (context) => PatientLoginCubit(),
      child: const PatientLoginScreen(),
    );
    emit(ChangeView());
  }

  void changeToRegister() {
    view = BlocProvider(
      create: (context) => PatientRegisterCubit(),
      child: const PatientRegisterScreen(),
    );
    emit(ChangeView());
  }
}
