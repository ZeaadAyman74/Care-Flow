import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/snack_bar.dart';
import 'package:care_flow/doctor/my_private_diagnoses/business_logic/my_private_diagnoses_cubit.dart';
import 'package:care_flow/doctor/my_private_diagnoses/view/widgets/private_diagnoses_list.dart';
import 'package:care_flow/doctor/receive_request/view/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivateDiagnosesScreen extends StatefulWidget {
  const PrivateDiagnosesScreen({Key? key}) : super(key: key);

  @override
  State<PrivateDiagnosesScreen> createState() => _PrivateDiagnosesScreenState();
}

class _PrivateDiagnosesScreenState extends State<PrivateDiagnosesScreen> {
  void _getPrivateDiagnoses()async{
    await MyPrivateDiagnosesCubit.get(context).getMyPrivateDiagnoses();
  }
  @override
  void initState() {
_getPrivateDiagnoses();
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<MyPrivateDiagnosesCubit,MyPrivateDiagnosesState>(
      listener: (context, state) {
        if(state is GetMyPrivateDiagnosesError){
          sl<AppFunctions>().showMySnackBar(context, state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Private Diagnoses'),
          centerTitle: true,
          elevation: 5,
        ),
        body: BlocBuilder<MyPrivateDiagnosesCubit,MyPrivateDiagnosesState>(
          builder: (context, state) {
            if(state is GetMyPrivateDiagnosesSuccess){
              if(MyPrivateDiagnosesCubit.get(context).privateDiagnoses.isNotEmpty){
                return PrivateDiagnosesList(
                  diagnoses: MyPrivateDiagnosesCubit.get(context).privateDiagnoses,
                );
              }else {
                return const EmptyWidget(text: 'No Private Diagnoses Yet');
              }
            }else {
              return const Center(child: CircularProgressIndicator(),);
            }
          }
        ),
      ),
    );
  }
}
