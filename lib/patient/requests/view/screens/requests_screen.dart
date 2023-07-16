import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/core/utils/snack_bar.dart';
import 'package:care_flow/patient/requests/business_logic/requests_cubit.dart';
import 'package:care_flow/patient/requests/view/widgets/sent_requests_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SentRequestsScreen extends StatefulWidget {
  const SentRequestsScreen({Key? key}) : super(key: key);

  @override
  State<SentRequestsScreen> createState() => _SentRequestsScreenState();
}

class _SentRequestsScreenState extends State<SentRequestsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage( const AssetImage(AppImages.doctor), context);
  }
  void getRequests() async {
    if( RequestsCubit.get(context).requests.isEmpty){
      await RequestsCubit.get(context).getRequests();
    }
  }

  @override
  void initState() {
    getRequests();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestsCubit, RequestsState>(
      listener: (context, state) {
        if (state is GetRequestsError) {
          AppFunctions.showMySnackBar(context, state.error);
        }
      },
      child: BlocBuilder<RequestsCubit, RequestsState>(
        builder: (context, state) {
          if (state is GetRequestsSuccess ) {
            if (RequestsCubit.get(context).requests.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async{
                  RequestsCubit.get(context).requests=[];
                  await RequestsCubit.get(context).getRequests();
                },
                child: SentRequestsList(
                    requests: RequestsCubit.get(context).requests),
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
