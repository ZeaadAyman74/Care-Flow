import 'package:bloc/bloc.dart';
import 'package:care_flow/core/cache_helper.dart';
import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/patient/home/view/patient_home_screen.dart';
import 'package:care_flow/patient/responses/view/screens/responses_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'patient_layout_state.dart';

class PatientLayoutCubit extends Cubit<PatientLayoutState> {
  PatientLayoutCubit() : super(PatientLayoutInitial());

static PatientLayoutCubit get(BuildContext context)=>BlocProvider.of<PatientLayoutCubit>(context);

  int selectedIndex = 0;
  List<Widget> views = [
    const PatientHomeScreen(),
    const ResponsesScreen(),
    Builder(
      builder: (context) => Center(
        child: TextButton(
          child: const Text('Logout'),
          onPressed: ()async{
            await FirebaseAuth.instance.signOut().then((value) async {
              context.pushAndRemove(Routes.chooseRole);
              await CacheHelper.removeValue(key: 'uId');
            });
          },
        ),
      ),
    ),
  ];

  void changeView(int index) {
    selectedIndex = index;
    emit(ChangeScreen());
  }
}
