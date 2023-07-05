import 'package:care_flow/core/utils/snack_bar.dart';
import 'package:care_flow/doctor/diagnoses/business_logic/diagnoses_cubit.dart';
import 'package:care_flow/doctor/diagnoses/view/widgets/diagnoses_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiagnosesScreen extends StatefulWidget {
  const DiagnosesScreen({Key? key}) : super(key: key);

  @override
  State<DiagnosesScreen> createState() => _DiagnosesScreenState();
}

class _DiagnosesScreenState extends State<DiagnosesScreen> {
  void getMyDiagnoses() async {
    if( DiagnosesCubit.get(context).diagnoses.isEmpty){
      await DiagnosesCubit.get(context).getMyDiagnoses();
    }
  }

  @override
  void initState() {
    getMyDiagnoses();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<DiagnosesCubit, DiagnosesState>(
      listener: (context, state) {
        if (state is GetMyDiagnosesError) {
          AppFunctions.showMySnackBar(context, state.error);
        }
      },
      child: BlocBuilder<DiagnosesCubit, DiagnosesState>(
        builder: (context, state) {
          if (state is GetMyDiagnosesSuccess ) {
            if (DiagnosesCubit.get(context).diagnoses.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async{
                  DiagnosesCubit.get(context).diagnoses=[];
                  await DiagnosesCubit.get(context).getMyDiagnoses();
                },
                child: DiagnosesList(diagnoses: DiagnosesCubit.get(context).diagnoses),
              );
            } else {
              return const Center(
                child: Text('No Diagnoses Yet'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
