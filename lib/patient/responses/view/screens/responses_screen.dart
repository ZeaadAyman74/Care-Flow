import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/snack_bar.dart';
import 'package:care_flow/doctor/receive_request/view/widgets/empty_widget.dart';
import 'package:care_flow/patient/responses/business_logic/responses_cubit/responses_cubit.dart';
import 'package:care_flow/patient/responses/view/widgets/responses_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsesScreen extends StatefulWidget {
  const ResponsesScreen({Key? key}) : super(key: key);

  @override
  State<ResponsesScreen> createState() => _ResponsesScreenState();
}

class _ResponsesScreenState extends State<ResponsesScreen> {
  void getResponses() async {
    if (ResponsesCubit.get(context).responses.isEmpty) {
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
          sl<AppFunctions>().showMySnackBar(context, state.error);
        }
      },
      child: BlocBuilder<ResponsesCubit, ResponsesState>(
        builder: (context, state) {
          if (state is GetResponsesSuccess) {
            if (ResponsesCubit.get(context).responses.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  ResponsesCubit.get(context).responses = [];
                  await ResponsesCubit.get(context).getResponses();
                },
                child: Column(
                  children: [
                    Expanded(
                      child: ResponsesList(
                          responses: ResponsesCubit.get(context).responses),
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
              return const EmptyWidget(text: 'No Responses Yet');
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
