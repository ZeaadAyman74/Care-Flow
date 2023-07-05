import 'package:care_flow/core/utils/snack_bar.dart';
import 'package:care_flow/doctor/receive_request/business_logic/receive_request_cubit/receive_requests_cubit.dart';
import 'package:care_flow/doctor/receive_request/view/widgets/requests_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({Key? key}) : super(key: key);

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  void getRequests() async {
    if( ReceiveRequestsCubit.get(context).requests.isEmpty){
      await ReceiveRequestsCubit.get(context).getRequests();
    }
  }

  @override
  void initState() {
    getRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReceiveRequestsCubit, ReceiveRequestsState>(
      listener: (context, state) {
        if (state is ReceiveRequestError) {
          AppFunctions.showMySnackBar(context, state.error);
        }
      },
      child: BlocBuilder<ReceiveRequestsCubit, ReceiveRequestsState>(
        builder: (context, state) {
          if (state is ReceiveRequestSuccess || state is MarkFinishSuccess ||state is ReadRequest) {
            if (ReceiveRequestsCubit.get(context).requests.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async{
                  ReceiveRequestsCubit.get(context).requests=[];
                  await ReceiveRequestsCubit.get(context).getRequests();
                },
                child: RequestsList(
                    requests: ReceiveRequestsCubit.get(context).requests),
              );
            } else {
              return const Center(
                child: Text('No Requests Yet'),
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
