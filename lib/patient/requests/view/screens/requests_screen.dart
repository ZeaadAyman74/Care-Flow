import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/core/utils/snack_bar.dart';
import 'package:care_flow/doctor/receive_request/view/widgets/empty_widget.dart';
import 'package:care_flow/patient/requests/business_logic/requests/requests_cubit.dart';
import 'package:care_flow/patient/requests/view/widgets/sent_requests_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SentRequestsScreen extends StatefulWidget {
  const SentRequestsScreen({Key? key}) : super(key: key);

  @override
  State<SentRequestsScreen> createState() => _SentRequestsScreenState();
}

class _SentRequestsScreenState extends State<SentRequestsScreen> {
  final ScrollController _scrollController=ScrollController();
  bool _getMoreData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(  AssetImage(sl<AppImages>().doctor), context);
  }
  void _getRequests() async {
    if( RequestsCubit.get(context).requests.isEmpty){
      await RequestsCubit.get(context).getRequests();
    }
  }
  void _loadMoreData() async {
    _scrollController.addListener(() async {
      if (_scrollController.offset + 10 >
          _scrollController.position.maxScrollExtent &&
          !_getMoreData) {
        _getMoreData = true;
        await RequestsCubit.get(context).loadMoreData();
        _getMoreData = false;
      }
    });
  }

  @override
  void initState() {
    _getRequests();
    _loadMoreData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestsCubit, RequestsState>(
      listener: (context, state) {
        if (state is GetRequestsError) {
          sl<AppFunctions>().showMySnackBar(context, state.error);
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
                child: Column(
                  children: [
                    Expanded(
                      child: SentRequestsList(
                        scrollController: _scrollController,
                          requests: RequestsCubit.get(context).requests),
                    ),
                    state is LoadMoreData
                        ? SizedBox(
                      height: 20.w,
                      width: 20.w,
                      child: const CircularProgressIndicator(),
                    )
                        : const SizedBox(),
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
