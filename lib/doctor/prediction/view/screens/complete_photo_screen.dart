import 'dart:io';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompletePhotoScreen extends StatefulWidget {
  const CompletePhotoScreen({Key? key,required this.image}) : super(key: key);
final String image;
  @override
  State<CompletePhotoScreen> createState() => _CompletePhotoScreenState();
}

class _CompletePhotoScreenState extends State<CompletePhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            SizedBox(
              width: context.width,
              height: context.height,
              child: InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  clipBehavior: Clip.none,
                  panEnabled: false,

                  child: Image.file(File(widget.image),fit: BoxFit.scaleDown,)),
            ),
            Positioned(
              left: 20,
              top: 20,
              child: Container(
                height: 50.w,
                width: 50.w,
                decoration:const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ) ,
                child: IconButton(onPressed: ()=>context.pop(), icon: const Icon(Icons.arrow_back,color: MyColors.black,)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
