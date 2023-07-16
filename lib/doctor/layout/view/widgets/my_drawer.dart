import 'package:care_flow/core/cache_helper.dart';
import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/doctor/layout/business_logic/layout_cubit.dart';
import 'package:care_flow/doctor/layout/models/drawer_item_data.dart';
import 'package:care_flow/doctor/layout/view/widgets/drawer_index.dart';
import 'package:care_flow/doctor/layout/view/widgets/drawer_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MyDrawer extends StatefulWidget {
  const MyDrawer(
      {Key? key,
        this.screenIndex,
        this.iconAnimationController,
        this.onChangeDrawerIndex})
      : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? onChangeDrawerIndex;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final List<DrawerItemData> drawerList = <DrawerItemData>[
      DrawerItemData(
        index: DrawerIndex.home,
        labelName: 'home',
        icon: const Icon(Icons.home),
      ),
      DrawerItemData(
        index: DrawerIndex.feedBack,
        labelName: 'feedback',
        icon: const Icon(Icons.help),
      ),
      DrawerItemData(
        index: DrawerIndex.invite,
        labelName: 'invite_friend',
        icon: const Icon(Icons.group),
      ),
      DrawerItemData(
        index: DrawerIndex.about,
        labelName: 'about_us',
        icon: const Icon(Icons.info),
      ),
      DrawerItemData(
        index: DrawerIndex.language,
        labelName: 'language',
        icon: const Icon(Icons.language_rounded),
      ),
    ];
    return Scaffold(
      backgroundColor: MyColors.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(1.0 -
                            (widget.iconAnimationController!.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(
                              begin: 0.0, end: 24.0)
                              .animate(CurvedAnimation(
                              parent: widget.iconAnimationController!,
                              curve: Curves.fastOutSlowIn))
                              .value /
                              360),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: MyColors.grey.withOpacity(0.6),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 8),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(60.0)),
                              child: Image.asset(AppImages.patient),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                      'Ziad Ayman',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: MyColors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: MyColors.grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList.length,
              itemBuilder: (BuildContext context, int index) {
                return DrawerItem(
                  drawerItemData: drawerList[index],
                  screenIndex: widget.screenIndex,
                  iconAnimationController: widget.iconAnimationController,
                  onChangeDrawerIndex: navigationToScreen,
                );
              },
            ),
          ),
          Divider(
            height: 1,
            color: MyColors.grey.withOpacity(0.6),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: const Text(
                 'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: MyColors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: const Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () async{
                  await FirebaseAuth.instance.signOut().then((value) async {
                    context.pushAndRemove(Routes.chooseRole);
                    AppStrings.uId = null;
                    LayoutCubit.get(context).currentDoctor=null;
                    await CacheHelper.removeValue(key: 'uId');
                    await CacheHelper.removeValue(key: 'role');
                  });
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> navigationToScreen(DrawerIndex indexScreen) async {
    widget.onChangeDrawerIndex!(indexScreen);
  }
}
