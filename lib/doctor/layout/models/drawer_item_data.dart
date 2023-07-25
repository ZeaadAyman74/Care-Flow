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

  final String labelName;
  final Icon? icon;
final  bool isAssetsImage;
 final String imageName;
 final DrawerIndex? index;
}