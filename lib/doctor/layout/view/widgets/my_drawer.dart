import 'package:cached_network_image/cached_network_image.dart';
import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/doctor/layout/business_logic/user_cubit/user_cubit.dart';
import 'package:care_flow/doctor/layout/models/drawer_item_data.dart';
import 'package:care_flow/doctor/layout/view/widgets/drawer_index.dart';
import 'package:care_flow/doctor/layout/view/widgets/drawer_item.dart';
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
        index: DrawerIndex.editProfile,
        labelName: 'Edit Profile',
        icon: const Icon(Icons.person),
      ),
      DrawerItemData(
        index: DrawerIndex.privateDiagnosis,
        labelName: 'Private Diagnosis',
        icon: const Icon(Icons.list_alt),
      ),
      DrawerItemData(
        index: DrawerIndex.about,
        labelName: 'about us',
        icon: const Icon(Icons.info),
      ),
      DrawerItemData(
        index: DrawerIndex.language,
        labelName: 'language',
        icon: const Icon(Icons.language_rounded),
      ),
    ];
    return Scaffold(
      backgroundColor: sl<MyColors>().notWhite.withOpacity(0.5),
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
                                    color: sl<MyColors>().grey.withOpacity(0.6),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 8),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60.0)),
                              child: UserCubit.get(context)
                                          .currentDoctor!
                                          .profileImage ==
                                      null
                                  ? Image.asset(sl<AppImages>().doctor)
                                  : CachedNetworkImage(
                                      imageUrl: UserCubit.get(context)
                                          .currentDoctor!
                                          .profileImage!),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                      UserCubit.get(context).currentDoctor!.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: sl<MyColors>().black.withOpacity(.6),
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
            color: sl<MyColors>().grey.withOpacity(0.6),
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
            color: sl<MyColors>().grey.withOpacity(0.6),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: sl<MyColors>().black,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: const Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () async {
                  await UserCubit.get(context).doctorLogout();
                  if (context.mounted) {
                    context.pushAndRemove(Routes.chooseRole);
                  }
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
