import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/snack_bar.dart';
import 'package:care_flow/patient/choose_doctor/business_logic/choose_doctor_cubit.dart';
import 'package:care_flow/patient/choose_doctor/view/widgets/doctors_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseDoctorScreen extends StatefulWidget {
  const ChooseDoctorScreen({Key? key, required this.specialize})
      : super(key: key);
  final String specialize;

  @override
  State<ChooseDoctorScreen> createState() => _ChooseDoctorScreenState();
}

class _ChooseDoctorScreenState extends State<ChooseDoctorScreen> {
  void getDoctors() async {
    await ChooseDoctorCubit.get(context)
        .getDoctors(specialization: widget.specialize);
  }

  @override
  void initState() {
    getDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChooseDoctorCubit,ChooseDoctorState>(
      listener: (context, state) {
        if(state is GetDoctorsError){
          sl<AppFunctions>().showMySnackBar(context,state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title:  Text(widget.specialize),
          centerTitle: true,
        ),
        body: BlocBuilder<ChooseDoctorCubit, ChooseDoctorState>(
          builder: (context, state) {
            if (state is GetDoctorsSuccess) {
              if(ChooseDoctorCubit.get(context).doctors.isEmpty){
                return const Center(child: Text('No Doctors in this field yet'),);
              }else {
                return DoctorsList(doctors: ChooseDoctorCubit.get(context).doctors);
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
