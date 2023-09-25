import 'package:care_flow/doctor/diagnoses/view/diagnoses_screen.dart';
import 'package:care_flow/doctor/home/view/screens/home.dart';
import 'package:care_flow/doctor/receive_request/view/screens/requests_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(LayoutInitial());

  static HomeLayoutCubit get(BuildContext context) =>
      BlocProvider.of<HomeLayoutCubit>(context);

  int selectedIndex = 0;
  List<Widget> views = [
    const HomeScreen(),
    const RequestsScreen(),
    const DiagnosesScreen(),
  ];

  void changeView(int index) {
    selectedIndex = index;
    emit(ChangeScreen());
  }
}
