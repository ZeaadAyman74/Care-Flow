import 'package:care_flow/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {Key? key,
      required this.validate,
      this.suffix,
      required this.isPassword,
      required this.label,
      required this.myController,
      required this.prefix,
      this.suffixPress,
      required this.type,
      required this.onSave})
      : super(key: key);
  final TextEditingController myController;
  final TextInputType type;
  final String? Function(String? value) validate;
  final String label;
  final IconData prefix;
  final IconData? suffix;
  final void Function()? suffixPress;
  final bool isPassword;
  final void Function(String? value) onSave;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(fontSize: 20, color: Colors.black),
      scrollPadding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      controller: myController,
      keyboardType: type,
      validator: validate,
      obscureText: isPassword,
      onSaved: (newValue) => onSave,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          borderSide: const BorderSide(color: MyColors.grey),
        ),
        hintText: label,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontSize: 15, color: Colors.black),
        prefixIcon: Icon(prefix, color: MyColors.primary),
        suffixIcon: IconButton(
          icon: Icon(suffix, color: MyColors.primary),
          onPressed: suffixPress,
          color: MyColors.black,
        ),
      ),
    );
  }
}
