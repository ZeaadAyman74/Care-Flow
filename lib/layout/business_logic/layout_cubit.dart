import 'package:care_flow/core/cache_helper.dart';
import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/home/view/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(BuildContext context) =>
      BlocProvider.of<LayoutCubit>(context);

  int selectedIndex = 0;
  List<Widget> views = [
    const HomeScreen(),
     Builder(
       builder: (context) => Center(
        child: TextButton(
          child: const Text('Logout'),
          onPressed: ()async{
            await FirebaseAuth.instance.signOut().then((value) async {
             context.pushAndRemove(Routes.loginRoute);
            await CacheHelper.removeValue(key: 'uId');
            });
          },
        ),
    ),
     ),
  ];

  void changeView(int index) {
    selectedIndex = index;
    emit(ChangeScreen());
  }
}
