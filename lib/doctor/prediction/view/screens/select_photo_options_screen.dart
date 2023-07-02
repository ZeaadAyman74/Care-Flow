import 'package:care_flow/doctor/prediction/business_logic/prediction_cubit.dart';
import 'package:care_flow/doctor/prediction/view/widgets/re_usable_select_photo_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class SelectPhotoOptionsScreen extends StatelessWidget {
  const SelectPhotoOptionsScreen({
    Key? key,
    required this.cubit,
  }) : super(key: key);
final cubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey.shade300,
      padding: const EdgeInsets.all(20),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: [
          const SizedBox(
            height: 20,
          ),
          Column(children: [
            SelectPhoto(
              onTap: () async {
                await cubit.pickImage(source: ImageSource.gallery);
              },
              icon: Icons.image,
              textLabel: 'Browse Gallery',
            ),
             SizedBox(
              height: 10.h,
            ),
             Text(
               'OR',
               style: TextStyle(fontSize: 18.sp),
             ),
             SizedBox(
              height: 10.h,
            ),
            SelectPhoto(
              onTap: () async {
                await cubit.pickImage(source: ImageSource.camera);
              },
              icon: Icons.camera_alt_outlined,
              textLabel: 'Use a Camera',
            ),
          ]),
          Positioned(
            top: -35,
            child: Container(
              width: 80.w,
              height: 6.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.5),
                color: Colors.white,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
