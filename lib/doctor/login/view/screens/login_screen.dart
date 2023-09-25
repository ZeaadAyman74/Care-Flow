import 'package:care_flow/core/cache_helper.dart';
import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/core/utils/my_inums.dart';
import 'package:care_flow/core/utils/snack_bar.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/doctor/login/business_logic/home_login_cubit/home_login_cubit.dart';
import 'package:care_flow/doctor/login/business_logic/login_cubit/login_cubit.dart';
import 'package:care_flow/doctor/login/view/widgets/login_button.dart';
import 'package:care_flow/doctor/login/view/widgets/my_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {

  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  void _goToHome() {
    context.pushAndRemove(Routes.newLayout);
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          sl<AppFunctions>().showToast(message: 'Login Success', state: ToastStates.success);
          sl<AppStrings>().uId = FirebaseAuth.instance.currentUser!.uid;
          await sl<CacheHelper>().putData(key: 'uId', value: sl<AppStrings>().uId);
          await sl<CacheHelper>().putData(key: 'role', value: 'd');
          _goToHome();
        } else if (state is LoginError) {
          sl<AppFunctions>().showToast(
              message: state.error, state: ToastStates.error);
        }
      },
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            reverse: true,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.w, 0, 20.w, 20.h),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(alignment: Alignment.center,child: Lottie.asset(sl<AppImages>().login,repeat: false,reverse: false)),
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
                          color: sl<MyColors>().black
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
                    BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (previous,
                          current) => current is ChangePassVisibility,
                      builder: (context, state) =>
                          MyTextField(
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
                              isPassword: LoginCubit
                                  .get(context)
                                  .isVisible,
                              suffix: LoginCubit
                                  .get(context)
                                  .visibleIcon,
                              suffixPress: () {
                                LoginCubit.get(context).changePassVisibility();
                              }),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (previous, current) =>
                      current is LoginError || current is LoginSuccess ||
                          current is LoginLoading,
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),);
                        } else {
                          return LoginButton(txt: 'LOGIN',
                              radius: 5,
                              function: () async {
                                if (formKey.currentState!.validate()) {
                                  await LoginCubit.get(context).loginUser(
                                      email: emailController.text,
                                      password: passController.text);
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
                      children: [
                        Text("Don't have an account? ", style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),),
                        TextButton(
                          onPressed: () {
                            HomeLoginCubit.get(context).changeToRegister();
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
