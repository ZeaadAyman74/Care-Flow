import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'patient_home_state.dart';

class PatientHomeCubit extends Cubit<PatientHomeState> {
  PatientHomeCubit() : super(PatientHomeInitial());
}
