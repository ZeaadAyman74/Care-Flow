import 'package:care_flow/doctor/login/business_logic/home_login_cubit/home_login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLoginScreen extends StatefulWidget {
  const HomeLoginScreen({Key? key}) : super(key: key);

  @override
  State<HomeLoginScreen> createState() => _HomeLoginScreenState();
}

class _HomeLoginScreenState extends State<HomeLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocBuilder<HomeLoginCubit, HomeLoginState>(
          builder: (context, state) => HomeLoginCubit.get(context).view,
        ),
      ),
    );
  }
}
