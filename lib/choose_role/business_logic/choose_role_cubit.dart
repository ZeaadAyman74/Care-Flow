import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'choose_role_state.dart';

class ChooseRoleCubit extends Cubit<ChooseRoleState> {
  ChooseRoleCubit() : super(ChooseRoleInitial());

  static ChooseRoleCubit get(BuildContext context)=>BlocProvider.of<ChooseRoleCubit>(context);

  bool isDoctor=true;
  bool isPatient=false;

  void changeRole(){
    isDoctor=!isDoctor;
    isPatient=!isPatient;
    emit(ChooseRole());
  }
}
