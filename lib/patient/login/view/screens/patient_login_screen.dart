import 'package:care_flow/core/cache_helper.dart';
import 'package:care_flow/core/fcm/fcm.dart';
import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/core/utils/my_inums.dart';
import 'package:care_flow/core/utils/snack_bar.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/doctor/login/view/widgets/login_button.dart';
import 'package:care_flow/doctor/login/view/widgets/my_text_field.dart';
import 'package:care_flow/patient/login/business_logic/patient_home_login_cubit/patient_home_login_cubit.dart';
import 'package:care_flow/patient/login/business_logic/patient_login_cubit/patient_login_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientLoginScreen extends StatefulWidget {
  const PatientLoginScreen({Key? key}) : super(key: key);

  @override
  State<PatientLoginScreen> createState() => _PatientLoginScreenState();
}

class _PatientLoginScreenState extends State<PatientLoginScreen> with TickerProviderStateMixin{
  AnimationController? _animationController;

  var emailController = TextEditingController();

  var passController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  void _goToHome(){
    context.pushAndRemove(Routes.patientLayoutRoute);
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientLoginCubit,PatientLoginState>(
      listener: (context, state) async {
        if(state is PatientLoginSuccess){
          sl<AppFunctions>().showToast(message: 'Login Success', state: ToastStates.success);
          sl<AppStrings>().uId=FirebaseAuth.instance.currentUser!.uid;
          await sl<CacheHelper>().putData(key: 'uId', value: sl<AppStrings>().uId);
          await sl<CacheHelper>().putData(key: 'role', value: 'p');
          await sl<FirebaseApi>().refreshToken();
          _goToHome();
        }else if(state is PatientLoginError){
          sl<AppFunctions>().showToast(message: state.error, state: ToastStates.error);
        }
      },
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.w, 0, 20.w, 20.h),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(sl<AppImages>().patientLogin,),
                    SizedBox(height: 30.h,),
                    Text(
                      "LOGIN",
                      style:
                      Theme
                          .of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(
                          fontSize: 30.sp,
                          color:sl<MyColors>().black
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    MyTextField(
                      isPassword: false,
                      myController: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "Email cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      label: "Email Address",
                      prefix: Icons.email_outlined,
                      onSave: (value) {},
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    BlocBuilder<PatientLoginCubit,PatientLoginState>(
                      buildWhen: (previous, current) => current is ChangePassVisibility,
                      builder: (context, state) =>MyTextField(
                          onSave: (value) {},
                          myController: passController,
                          type: TextInputType.visiblePassword,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "password cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          label: "Password",
                          prefix: Icons.lock,
                          isPassword: PatientLoginCubit
                              .get(context)
                              .isVisible,
                          suffix: PatientLoginCubit
                              .get(context)
                              .visibleIcon,
                          suffixPress: () {
                            PatientLoginCubit.get(context).changePassVisibility();
                          }),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    BlocBuilder<PatientLoginCubit,PatientLoginState>(
                      buildWhen: (previous, current) => current is PatientLoginError || current is PatientLoginSuccess || current is PatientLoginLoad,
                      builder: (context, state) {
                        if (state is PatientLoginLoad) {
                          return const Center(child: CircularProgressIndicator(),);
                        } else {
                          return LoginButton(txt: 'LOGIN',
                              radius: 5,
                              function: () async{
                                if (formKey.currentState!.validate()) {
                                  await  PatientLoginCubit.get(context).loginPatient(email: emailController.text, password: passController.text);
                                }
                              },
                              background: sl<MyColors>().primary,
                              width: double.infinity,
                              foreColor: sl<MyColors>().white);
                        }
                      },),
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text("Don't have an account? ", style:Theme
                            .of(context)
                            .textTheme
                            .bodySmall!.copyWith(color:Colors.black),),
                        TextButton(
                          onPressed: () {
                            PatientHomeLoginCubit.get(context).changeToRegister();
                          },
                          child:  Text(
                            "REGISTER",
                            style: TextStyle(color: sl<MyColors>().primary),
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
}
