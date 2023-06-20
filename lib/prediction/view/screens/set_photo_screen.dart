import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/prediction/view/widgets/common_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'select_photo_options_screen.dart';

class CoronaDetectionScreen extends StatefulWidget {
  const CoronaDetectionScreen({super.key});

  @override
  State<CoronaDetectionScreen> createState() => _CoronaDetectionScreenState();
}

class _CoronaDetectionScreenState extends State<CoronaDetectionScreen> {
  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: const SelectPhotoOptionsScreen(),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COVID-19 Detection'),
        centerTitle: true,
        elevation: 5,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h, top: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  'Set a Photo of your lung',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Try set the photo with a high quality to get the best results',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _showSelectPhotoOptions(context);
                },
                child: Center(
                  child: Container(
                      height: 200.0.w,
                      width: 200.0.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: const Center(
                        child: Text(
                          'No image selected',
                          style: TextStyle(fontSize: 20),
                        ),
                      )),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CommonButtons(
                  onTap: () => _showSelectPhotoOptions(context),
                  backgroundColor: MyColors.primary,
                  textColor: Colors.white,
                  textLabel: 'Add a Photo',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
