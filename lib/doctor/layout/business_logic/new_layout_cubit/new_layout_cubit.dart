import 'package:care_flow/doctor/diagnoses/business_logic/diagnoses_cubit.dart';
import 'package:care_flow/doctor/layout/view/screens/layout_screen.dart';
import 'package:care_flow/doctor/layout/view/widgets/drawer_index.dart';
import 'package:care_flow/doctor/receive_request/business_logic/receive_request_cubit/receive_requests_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'new_layout_state.dart';

class NewLayoutCubit extends Cubit<NewLayoutState> {
  NewLayoutCubit() : super(NewLayoutInitial());

  static NewLayoutCubit get(BuildContext context)=>BlocProvider.of<NewLayoutCubit>(context);

  DrawerIndex currentDrawerIndex = DrawerIndex.home;
  Widget screenView = MultiBlocProvider(providers: [
    BlocProvider(create: (context) => DiagnosesCubit(),),
    BlocProvider(create: (context) => ReceiveRequestsCubit(),),
  ],child: const LayoutScreen());

  Future<void> changeDrawerIndex(DrawerIndex index) async {
    if (currentDrawerIndex != index) {
      currentDrawerIndex = index;
      switch (currentDrawerIndex) {
        case DrawerIndex.home:
          screenView = MultiBlocProvider(providers: [
            BlocProvider(create: (context) => DiagnosesCubit(),),
            BlocProvider(create: (context) => ReceiveRequestsCubit(),),
          ],child: const LayoutScreen());
          emit(DrawerIndexChanged());
          break;
        case DrawerIndex.help:
          screenView = const Text('help');
          emit(DrawerIndexChanged());
          break;

        case DrawerIndex.feedBack:
          screenView = const Text('feedback');
          emit(DrawerIndexChanged());
          break;

        case DrawerIndex.language:
          screenView = const Text('language');
          emit(DrawerIndexChanged());
          break;

        case DrawerIndex.invite:
          screenView = const Text('invite');
          emit(DrawerIndexChanged());
          break;

        default:
          break;
      }
    }
  }
}
