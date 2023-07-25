import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/doctor/diagnoses/business_logic/diagnoses_cubit.dart';
import 'package:care_flow/doctor/edit_profile/business_logic/edit_doctor_profile_cubit.dart';
import 'package:care_flow/doctor/edit_profile/view/screens/edit_doctor_screen.dart';
import 'package:care_flow/doctor/layout/view/screens/layout_screen.dart';
import 'package:care_flow/doctor/layout/view/widgets/drawer_index.dart';
import 'package:care_flow/doctor/my_private_diagnoses/business_logic/my_private_diagnoses_cubit.dart';
import 'package:care_flow/doctor/my_private_diagnoses/view/my_private_diagnoses_screen.dart';
import 'package:care_flow/doctor/receive_request/business_logic/receive_request_cubit/receive_requests_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'new_layout_state.dart';

class NewLayoutCubit extends Cubit<NewLayoutState> {
  NewLayoutCubit() : super(NewLayoutInitial());

  static NewLayoutCubit get(BuildContext context) =>
      BlocProvider.of<NewLayoutCubit>(context);

  DrawerIndex currentDrawerIndex = DrawerIndex.home;
  Widget screenView = MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => DiagnosesCubit(),
    ),
    BlocProvider(
      create: (context) => ReceiveRequestsCubit(),
    ),
  ], child: const LayoutScreen());

  Future<void> changeDrawerIndex(DrawerIndex index) async {
    if (currentDrawerIndex != index) {
      currentDrawerIndex = index;
      switch (currentDrawerIndex) {
        case DrawerIndex.home:
          screenView = MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => DiagnosesCubit(),
            ),
            BlocProvider(
              create: (context) => ReceiveRequestsCubit(),
            ),
          ], child: const LayoutScreen());
          emit(DrawerIndexChanged());
          break;
        case DrawerIndex.editProfile:
          screenView = BlocProvider(
            create: (context) => sl<EditDoctorProfileCubit>(),
            child: const EditDoctorScreen(),
          );
          emit(DrawerIndexChanged());
          break;

        case DrawerIndex.privateDiagnosis:
          screenView = BlocProvider(
            create: (context) => sl<MyPrivateDiagnosesCubit>(),
            child: const PrivateDiagnosesScreen(),
          );
          emit(DrawerIndexChanged());
          break;

        case DrawerIndex.language:
          screenView = const Text('language');
          emit(DrawerIndexChanged());
          break;

        case DrawerIndex.about:
          screenView = const Text('invite');
          emit(DrawerIndexChanged());
          break;

        default:
          break;
      }
    }
  }
}
