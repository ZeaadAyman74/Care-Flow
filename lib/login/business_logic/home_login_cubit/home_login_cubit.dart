import 'package:care_flow/login/business_logic/login_cubit/login_cubit.dart';
import 'package:care_flow/login/view/screens/login_screen.dart';
import 'package:care_flow/register/business_logic/register_cubit.dart';
import 'package:care_flow/register/views/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_login_state.dart';

class HomeLoginCubit extends Cubit<HomeLoginState> {
  HomeLoginCubit() : super(HomeLoginInitial());

  static HomeLoginCubit get(BuildContext context) =>
      BlocProvider.of<HomeLoginCubit>(context);

  Widget view = BlocProvider(
      create: (context) => LoginCubit(), child: const LoginScreen());

  void changeToLogin() {
    view = BlocProvider(
        create: (context) => LoginCubit(), child: const LoginScreen());
    emit(ChangeView());
  }

  void changeToRegister() {
    view = BlocProvider(
        create: (context) => RegisterCubit(), child: const RegisterScreen());
    emit(ChangeView());
  }
}
