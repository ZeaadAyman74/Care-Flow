import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/snack_bar.dart';
import 'package:care_flow/doctor/receive_request/business_logic/receive_request_cubit/receive_requests_cubit.dart';
import 'package:care_flow/doctor/receive_request/view/widgets/empty_widget.dart';
import 'package:care_flow/doctor/receive_request/view/widgets/requests_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({Key? key}) : super(key: key);

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  final ScrollController scrollController = ScrollController();
  bool _getMoreData = false;

  void getRequests() async {
    if (ReceiveRequestsCubit.get(context).requests.isEmpty) {
      await ReceiveRequestsCubit.get(context).getRequests();
    }
  }

  void loadMoreData() async {
    scrollController.addListener(() async {
      if (scrollController.offset + 10 >
              scrollController.position.maxScrollExtent &&
          !_getMoreData) {
        _getMoreData = true;
        await ReceiveRequestsCubit.get(context).loadMoreData();
        _getMoreData = false;
      }
    });
  }

  @override
  void initState() {
    getRequests();
    loadMoreData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReceiveRequestsCubit, ReceiveRequestsState>(
      listener: (context, state) {
        if (state is ReceiveRequestError) {
          sl<AppFunctions>().showMySnackBar(context, state.error);
        }
      },
      child: BlocBuilder<ReceiveRequestsCubit,ReceiveRequestsState>(
        builder: (context, state) {
          if (state is ReceiveRequestSuccess ||
              state is MarkFinishSuccess ||
              state is ReadRequest ||
              state is LoadMoreData) {
            if (ReceiveRequestsCubit.get(context).requests.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  ReceiveRequestsCubit.get(context).requests = [];
                  await ReceiveRequestsCubit.get(context).getRequests();
                },
                child: Column(
                  children: [
                    Expanded(
                      child: RequestsList(
                          scrollController: scrollController,
                          requests: ReceiveRequestsCubit.get(context).requests),
                    ),
                    state is LoadMoreData
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                  ],
                ),
              );
            } else {
              return const EmptyWidget(text: 'No Requests Yet');
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
