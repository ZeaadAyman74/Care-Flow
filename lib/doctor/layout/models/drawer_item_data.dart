import 'package:care_flow/doctor/layout/view/widgets/drawer_index.dart';
import 'package:flutter/material.dart';

class DrawerItemData {
  DrawerItemData({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}