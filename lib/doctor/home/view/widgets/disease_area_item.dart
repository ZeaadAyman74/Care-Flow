import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DiseaseAreaItem extends StatefulWidget {
  const DiseaseAreaItem({Key? key, required this.image, required this.title})
      : super(key: key);
  final String title;
  final String image;

  @override
  State<DiseaseAreaItem> createState() => _DiseaseAreaItemState();
}

class _DiseaseAreaItemState extends State<DiseaseAreaItem> {
  @override
  void didChangeDependencies() {
    precacheImage(  AssetImage(widget.image), context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        shadowColor: Colors.black,
        child: ClipRRect(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black.withOpacity(.2),
                width: .5,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.r))),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(
                      widget.image,
                      height: 100.w,
                      width: 100.w,
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: 10.sp,
                ),
                Text(widget.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 20.sp)),
                const Spacer(),
                const Icon(FontAwesomeIcons.arrowRight),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
