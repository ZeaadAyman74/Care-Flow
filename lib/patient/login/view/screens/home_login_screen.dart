import 'package:care_flow/patient/login/business_logic/patient_home_login_cubit/patient_home_login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientHomeLogin extends StatelessWidget {
  const PatientHomeLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocBuilder<PatientHomeLoginCubit, PatientHomeLoginState>(
          builder: (context, state) => PatientHomeLoginCubit.get(context).view,
        ),
      ),
    );
  }
}
