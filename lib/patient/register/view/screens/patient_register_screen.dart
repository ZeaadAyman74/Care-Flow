import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/core/utils/my_inums.dart';
import 'package:care_flow/core/utils/snack_bar.dart';
import 'package:care_flow/doctor/login/view/widgets/login_button.dart';
import 'package:care_flow/doctor/login/view/widgets/my_text_field.dart';
import 'package:care_flow/patient/login/business_logic/patient_home_login_cubit/patient_home_login_cubit.dart';
import 'package:care_flow/patient/register/business_logic/patient_register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientRegisterScreen extends StatefulWidget {
  const PatientRegisterScreen({Key? key}) : super(key: key);

  @override
  State<PatientRegisterScreen> createState() => _PatientRegisterScreenState();
}

class _PatientRegisterScreenState extends State<PatientRegisterScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final nIdController = TextEditingController();
  final ageController = TextEditingController();
  String gender = 'Male';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // late String email;
  // late String password;
  // late String phone;
  // late String name;
  // late String physicalConditions;
  // late String age;
  // late String address;
  // late String nId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientRegisterCubit, PatientRegisterState>(
      listener: (context, state) {
        if (state is RegisterPatientSuccess) {
          AppFunctions.showToast(
              message: 'Registered Success', state: ToastStates.success);
          goToLogin(context);
        } else if (state is RegisterPatientError) {
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
                    BlocBuilder<PatientRegisterCubit, PatientRegisterState>(
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
                        isPassword: PatientRegisterCubit.get(context).isVisible,
                        suffix: PatientRegisterCubit.get(context).visibleIcon,
                        suffixPress: () {
                          PatientRegisterCubit.get(context)
                              .changePassVisibility();
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
                      prefix: Icons.numbers,
                      isPassword: false,
                      onSave: (value) {
                        // nId = value!;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    MyTextField(
                      myController: ageController,
                      type: TextInputType.number,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "Age Id cannot be empty";
                        } else if (value.length > 2) {
                          return 'enter a valid national id';
                        } else {
                          return null;
                        }
                      },
                      label: "Age",
                      prefix: Icons.person_add_sharp,
                      isPassword: false,
                      onSave: (value) {
                        // nId = value!;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Text('Male'),
                            Radio(
                                value: 'Male',
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value!;
                                  });
                                })
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Female'),
                            Radio(
                                value: 'Female',
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value!;
                                  });
                                })
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    BlocBuilder<PatientRegisterCubit, PatientRegisterState>(
                      buildWhen: (previous, current) =>
                          current is RegisterPatientSuccess ||
                          current is RegisterPatientLoad ||
                          current is RegisterPatientError,
                      builder: (context, state) {
                        if (state is RegisterPatientLoad) {
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
                                await PatientRegisterCubit.get(context)
                                    .register(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passController.text,
                                  phone: phoneController.text,
                                  nId: nIdController.text,
                                  gender: gender,
                                  age: int.parse(ageController.text),
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
                            PatientHomeLoginCubit.get(context).changeToLogin();
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
    PatientHomeLoginCubit.get(context).changeToLogin();
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
    nIdController.dispose();
  }
}
