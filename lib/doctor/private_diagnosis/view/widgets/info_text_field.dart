import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoTextField extends StatelessWidget {
  const InfoTextField(
      {Key? key,
      required this.title,
      required this.onSave,
      this.maxLines,
      this.validator,
      this.controller})
      : super(key: key);
  final String title;
  final void Function(String?)? onSave;
  final int? maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border =  OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: sl<MyColors>().primary));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
        ),
        SizedBox(
          height: 5.h,
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            border: border,
            enabledBorder: border,
            focusedBorder: border,
          ),
          onSaved: onSave,
          maxLines: maxLines ?? 1,
        ),
      ],
    );
  }
}
