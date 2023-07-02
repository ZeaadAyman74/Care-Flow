import 'dart:core';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/core/utils/my_inums.dart';
import 'package:care_flow/core/utils/snack_bar.dart';
import 'package:care_flow/doctor/login/business_logic/home_login_cubit/home_login_cubit.dart';
import 'package:care_flow/doctor/login/view/widgets/login_button.dart';
import 'package:care_flow/doctor/login/view/widgets/my_text_field.dart';
import 'package:care_flow/doctor/register/business_logic/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final nIdController = TextEditingController();
  final aboutController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String specialization;

  @override
  void initState() {
    specialization = RegisterCubit.get(context).specialties[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          AppFunctions.showToast(
              message: 'Registered Success', state: ToastStates.success);
          goToLogin(context);
        } else if (state is RegisterError) {
          AppFunctions.showToast(
              message: state.error, state: ToastStates.error);
        }
      },
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 70),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 25.h),
                      child: Text(
                        "SIGN UP",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 30.sp,
                            ),
                      ),
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
                      onSave: (value) {
                        // email = value!;
                      },
                      isPassword: false,
                      myController: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'enter an email';
                        } else if (value.endsWith('.com') &&
                            value.contains('@') &&
                            value.substring(0, value.indexOf('@')).isNotEmpty) {
                          return null;
                        } else {
                          return 'enter a valid email';
                        }
                      },
                      label: "Email Address",
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    BlocBuilder<RegisterCubit, RegisterState>(
                      buildWhen: (previous, current) =>
                          current is ChangePassVisibility,
                      builder: (context, state) => MyTextField(
                        myController: passController,
                        type: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'enter a password';
                          } else if (value.length < 8) {
                            return 'password must be above 8 digits';
                          } else {
                            return null;
                          }
                        },
                        label: "Password",
                        prefix: Icons.lock,
                        isPassword: RegisterCubit.get(context).isVisible,
                        suffix: RegisterCubit.get(context).visibleIcon,
                        suffixPress: () {
                          RegisterCubit.get(context).changePassVisibility();
                        },
                        onSave: (String? value) {
                          // password = value!;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
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
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        borderSide: const BorderSide(color: MyColors.grey),
                      )),
                      isExpanded: true,
                      menuMaxHeight: double.maxFinite,
                      value: specialization,
                      items: RegisterCubit.get(context)
                          .specialties
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: Colors.black,
                                      height: 1,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          specialization = value!;
                        });
                      },
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
                    MyTextField(
                      myController: nIdController,
                      type: TextInputType.number,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "National Id cannot be empty";
                        } else if (value.length != 14) {
                          return 'enter a valid national id';
                        } else {
                          return null;
                        }
                      },
                      label: "National Id",
                      prefix: Icons.perm_identity_outlined,
                      isPassword: false,
                      onSave: (value) {
                        // nId = value!;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      controller: aboutController,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          borderSide: const BorderSide(color: MyColors.grey),
                        ),
                      ),
                      maxLines: 5,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    BlocBuilder<RegisterCubit, RegisterState>(
                      buildWhen: (previous, current) =>
                          current is RegisterError ||
                          current is RegisterSuccess ||
                          current is RegisterLoad,
                      builder: (context, state) {
                        if (state is RegisterLoad) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return LoginButton(
                            txt: "REGISTER",
                            radius: 5,
                            background: MyColors.primary,
                            width: double.infinity,
                            foreColor: MyColors.white,
                            function: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                await RegisterCubit.get(context).register(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passController.text,
                                  phone: phoneController.text,
                                  nId: nIdController.text,
                                  address: addressController.text,
                                  specialization: specialization,
                                  about: aboutController.text,
                                );
                              }
                            },
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            HomeLoginCubit.get(context).changeToLogin();
                          },
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(color: MyColors.primary),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void goToLogin(BuildContext context) {
    HomeLoginCubit.get(context).changeToLogin();
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
    nIdController.dispose();
    addressController.dispose();
  }
}
