import 'package:flutter/material.dart';
import 'my_inums.dart';

extension MediaQueryExtension on BuildContext {
  Size get _size => MediaQuery.of(this).size;
  double get width => _size.width;
  double get height => _size.height;
}

extension NavigationExtension on BuildContext {
  void push(String routeName){
    Navigator.pushNamed(this, routeName);
  }

  void pushAndRemove(String routeName){
    Navigator.pushNamedAndRemoveUntil(this, routeName, (route) => false);
  }
  void pop(){
    return Navigator.pop(this);
  }
}

extension DeviceTypeExtension on DeviceType {
  int getMinWidth() {
    switch (this) {
      case DeviceType.mobile:
        return 320;
      case DeviceType.ipad:
        return 481;
      case DeviceType.smallScreenLaptop:
        return 769;
      case DeviceType.largeScreenDesktop:
        return 1025;
      case DeviceType.extraLargeTV:
        return 1600;
    }
  }

  int getMaxWidth() {
    switch (this) {
      case DeviceType.mobile:
        return 550;
      case DeviceType.ipad:
        return 750;
      case DeviceType.smallScreenLaptop:
        return 1024;
      case DeviceType.largeScreenDesktop:
        return 1200;
      case DeviceType.extraLargeTV:
        return 3840; // any number more than 1200
    }
  }
}