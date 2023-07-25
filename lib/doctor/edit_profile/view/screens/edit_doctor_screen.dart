import 'package:cached_network_image/cached_network_image.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/doctor/edit_profile/business_logic/edit_doctor_profile_cubit.dart';
import 'package:care_flow/doctor/layout/business_logic/layout_cubit.dart';
import 'package:care_flow/doctor/login/view/widgets/login_button.dart';
import 'package:care_flow/doctor/login/view/widgets/my_text_field.dart';
import 'package:care_flow/doctor/prediction/view/screens/select_photo_options_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditDoctorScreen extends StatefulWidget {
  const EditDoctorScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditDoctorScreen> createState() => _EditDoctorScreenState();
}

class _EditDoctorScreenState extends State<EditDoctorScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController addressController;
  late final TextEditingController aboutController;
  late final TextEditingController phoneController;

  late String name;
  late String address;
  late String phone;
  late String about;

  @override
  void initState() {
    nameController = TextEditingController(
        text: LayoutCubit.get(context).currentDoctor!.name);
    addressController = TextEditingController(
        text: LayoutCubit.get(context).currentDoctor!.address);
    aboutController = TextEditingController(
        text: LayoutCubit.get(context).currentDoctor!.about);
    phoneController = TextEditingController(
        text: LayoutCubit.get(context).currentDoctor!.phone);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = EditDoctorProfileCubit.get(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          centerTitle: true,
          elevation: 5,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocBuilder<EditDoctorProfileCubit, EditDoctorProfileState>(
                    buildWhen: (previous, current) => current is PickImageSuccess,
                    builder: (context, state) => Align(
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          EditDoctorProfileCubit.get(context).imageFile==null?
                          LayoutCubit.get(context).currentDoctor!.profileImage==null?
                          CircleAvatar(
                              radius: 70.r,
                              backgroundImage: AssetImage(sl<AppImages>().doctor,),
                          ) :
                          CircleAvatar(
                            radius: 70.r,
                              backgroundImage:CachedNetworkImageProvider(LayoutCubit.get(context).currentDoctor!.profileImage!)
                          )
                          :
                          CircleAvatar(
                              radius: 70.r,
                              backgroundImage: FileImage(EditDoctorProfileCubit.get(context).imageFile!)
                          ),
                          IconButton(
                            onPressed: () =>
                                _showSelectPhotoOptions(context, cubit),
                            icon: Icon(
                              cubit.imageFile == null
                                  ? Icons.camera_alt
                                  : Icons.close,
                              color: Colors.grey,
                            ),
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  MyTextField(
                    myController: nameController,
                    type: TextInputType.name,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "Name cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    label: "Name",
                    prefix: Icons.person,
                    isPassword: false,
                    onSave: (value) {
                      // name = value!;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  MyTextField(
                    myController: phoneController,
                    type: TextInputType.phone,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "Phone cannot be empty";
                      } else if (value.length < 10) {
                        return 'Enter a valid number';
                      } else {
                        return null;
                      }
                    },
                    onSave: (value) {
                      // phone = value!;
                    },
                    isPassword: false,
                    label: "Phone",
                    prefix: Icons.phone,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  MyTextField(
                    myController: addressController,
                    type: TextInputType.streetAddress,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "Address cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    label: "Address",
                    prefix: Icons.location_on,
                    isPassword: false,
                    onSave: (value) {
                      // address = value!;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    controller: aboutController,
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'about you',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        borderSide:  BorderSide(color: sl<MyColors>().grey),
                      ),
                    ),
                    maxLines: 5,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  BlocBuilder<EditDoctorProfileCubit, EditDoctorProfileState>(
                    buildWhen: (previous, current) =>
                        current is EditDoctorProfileError ||
                        current is EditDoctorProfileSuccess ||
                        current is EditDoctorProfileLoad,
                    builder: (context, state) {
                      if (state is EditDoctorProfileLoad) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return LoginButton(
                          txt: "Edit Profile",
                          radius: 5,
                          background: sl<MyColors>().primary,
                          width: double.infinity,
                          foreColor: sl<MyColors>().white,
                          function: () async {
                            if (formKey.currentState!.validate()) {
                              Map<String,dynamic>newInfo={};
                              if(nameController.text!=LayoutCubit.get(context).currentDoctor!.name){
                                newInfo.addAll({'name':nameController.text});
                              }
                              if(phoneController.text!=LayoutCubit.get(context).currentDoctor!.phone){
                                newInfo.addAll({'phone':phoneController.text});
                              }
                              if(aboutController.text!=LayoutCubit.get(context).currentDoctor!.about){
                                newInfo.addAll({'about':aboutController.text});
                              }
                              if(addressController.text!=LayoutCubit.get(context).currentDoctor!.address){
                                newInfo.addAll({'address':nameController.text});
                              }
                              if (cubit.pickedImage != null) {
                                await cubit.updateWithImageImage(newInfo: newInfo);
                                await LayoutCubit.get(context).getCurrentDoctor();
                              }else {
                                await cubit.updateDoctor(newInfo);
                                await LayoutCubit.get(context).getCurrentDoctor();
                              }
                            }
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }

  void _showSelectPhotoOptions(BuildContext context, EditDoctorProfileCubit cubit) {
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
              child: SelectPhotoOptionsScreen(cubit: cubit),
            );
          }),
    );
  }

}
