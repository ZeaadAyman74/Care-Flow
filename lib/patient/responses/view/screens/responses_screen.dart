import 'package:care_flow/core/utils/snack_bar.dart';
import 'package:care_flow/patient/responses/business_logic/responses_cubit.dart';
import 'package:care_flow/patient/responses/view/widgets/responses_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResponsesScreen extends StatefulWidget {
  const ResponsesScreen({Key? key}) : super(key: key);

  @override
  State<ResponsesScreen> createState() => _ResponsesScreenState();
}

class _ResponsesScreenState extends State<ResponsesScreen> {
  void getResponses() async {
    if( ResponsesCubit.get(context).responses.isEmpty){
      await ResponsesCubit.get(context).getResponses();
    }
  }

  @override
  void initState() {
    getResponses();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<ResponsesCubit, ResponsesState>(
      listener: (context, state) {
        if (state is GetResponsesError) {
          AppFunctions.showMySnackBar(context, state.error);
        }
      },
      child: BlocBuilder<ResponsesCubit, ResponsesState>(
        builder: (context, state) {
          if (state is GetResponsesSuccess ) {
            if (ResponsesCubit.get(context).responses.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async{
                  ResponsesCubit.get(context).responses=[];
                  await ResponsesCubit.get(context).getResponses();
                },
                child: ResponsesList(
                    responses: ResponsesCubit.get(context).responses),
              );
            } else {
              return const Center(
                child: Text('No Responses Yet'),
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
