import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/doctor/layout/view/widgets/drawer_index.dart';
import 'package:care_flow/doctor/layout/view/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class DrawerUserController extends StatefulWidget {
  const DrawerUserController({
    Key? key,
    this.drawerWidth = 250,
    this.onDrawerCall,
    this.screenView,
    this.animatedIconData = AnimatedIcons.arrow_menu,
    this.menuView,
    this.drawerIsOpen,
    this.screenIndex,
  }) : super(key: key);

  final double drawerWidth;
  final Function(DrawerIndex)? onDrawerCall;
  final Widget? screenView;
  final Function(bool)? drawerIsOpen;
  final AnimatedIconData? animatedIconData;
  final Widget? menuView;
  final DrawerIndex? screenIndex;

  @override
  State<DrawerUserController> createState() => _DrawerUserControllerState();
}

class _DrawerUserControllerState extends State<DrawerUserController>
    with TickerProviderStateMixin {
  ScrollController? scrollController;
  AnimationController? iconAnimationController;
  double scrollOffset = 0.0;

  @override
  void initState() {
    iconAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 0));
    iconAnimationController?.animateTo(1.0, duration: const Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);
    scrollController = ScrollController(initialScrollOffset: widget.drawerWidth);
    scrollController!.addListener(() {
      if (scrollController!.offset <= 0) {
        if (scrollOffset != 1.0) {
          setState(() {
            scrollOffset = 1.0;
            try {
              widget.drawerIsOpen!(true);
            } catch (_) {}
          });
        }
        iconAnimationController?.animateTo(0.0,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      } else if (scrollController!.offset > 0 && scrollController!.offset < widget.drawerWidth.floor()) {
        iconAnimationController?.animateTo(
            (scrollController!.offset  / (widget.drawerWidth)),
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      } else {
        if (scrollOffset != 0.0) {
          setState(() {
            scrollOffset = 0.0;
            try {
              widget.drawerIsOpen!(false);
            } catch (_) {}
          });
        }
        iconAnimationController?.animateTo(1.0,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => getInitState());
    super.initState();
  }

  Future<bool> getInitState() async {
    scrollController?.jumpTo(
      widget.drawerWidth,
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
            child: SizedBox(
              height: context.height,
              width: context.width + widget.drawerWidth,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: widget.drawerWidth,
                    //we divided first drawer Width with HomeDrawer and second full-screen Width with all home screen, we called screen View
                    height: context.height,
                    child: AnimatedBuilder(
                      animation: iconAnimationController!,
                      builder: (BuildContext context, Widget? child) {
                        return Transform(
                          //transform we use for the stable drawer  we, not need to move with scroll view
                          transform: Matrix4.translationValues(scrollController!.offset, 0.0, 0.0),
                          child: MyDrawer(
                            screenIndex: widget.screenIndex ?? DrawerIndex.home,
                            iconAnimationController: iconAnimationController,
                            onChangeDrawerIndex: (DrawerIndex indexType) {
                              onDrawerClick();
                              widget.onDrawerCall!(indexType);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: context.width,
                    height: context.height,
                    //full-screen Width with widget.screenView
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: sl<MyColors>().grey.withOpacity(0.6),
                              blurRadius: 24),
                        ],
                      ),
                      child: Stack(
                        children: <Widget>[
                          //this IgnorePointer we use as touch(user Interface) widget.screen View, for example scrolloffset == 1 means drawer is close we just allow touching all widget.screen View
                          IgnorePointer(
                            ignoring: scrollOffset == 1 || false,
                            child: widget.screenView,
                          ),
                          //alternative touch(user Interface) for widget.screen, for example, drawer is close we need to tap on a few home screen area and close the drawer
                          if (scrollOffset == 1.0)
                            InkWell(
                              onTap: () {
                                onDrawerClick();
                              },
                            ),
                          // this just menu and arrow icon animation
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top + 8,
                                left: 8),
                            child: SizedBox(
                              width: AppBar().preferredSize.height - 8,
                              height: AppBar().preferredSize.height - 8,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(
                                      AppBar().preferredSize.height),
                                  child: Center(
                                    // if you use your own menu view UI you add form initialization
                                    child: widget.menuView ??
                                        AnimatedIcon(
                                          icon: widget.animatedIconData ??
                                              AnimatedIcons.arrow_menu,
                                          progress: iconAnimationController!,
                                          color: Colors.white,
                                        ),
                                  ),
                                  onTap: () {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    onDrawerClick();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }

  void onDrawerClick() {
    if (scrollController!.offset != 0.0) {
      scrollController?.animateTo(
        0.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      scrollController?.animateTo(
        widget.drawerWidth,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}