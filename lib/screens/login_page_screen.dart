import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/cubit/login_cubit/cubit.dart';
import 'package:shop_app/cubit/login_cubit/state.dart';

import '../widgets/shared/network/local/shared_preference.dart';

import 'package:shop_app/screens/register_screen.dart';
import 'package:shop_app/styles/colors.dart';
import 'package:shop_app/widgets/shared/components/constant.dart';
import 'package:shop_app/widgets/shared/components/shared_component.dart';
import './shop_layout_screen.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({Key? key}) : super(key: key);

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLogintStates>(
          listener: (context, state) {
            if (state is ShopLoginSucessState) {
              if (state.userLogin!.status!) {
                print(state.userLogin!.message);
                print(state.userLogin!.data!.token);
                CashHelper.saveData(
                        key: 'token', value: state.userLogin!.data!.token)
                    .then((value) {
                  navagateToAndReplace(context, const ShopLayoutScreen());

                  token = state.userLogin!.data!.token;
                }).catchError((e) {
                  print(e.toString());
                });

                // Fluttertoast.showToast(
                // msg: state.userLogin!.message,
                // toastLength: Toast.LENGTH_LONG,
                // gravity: ToastGravity.BOTTOM,
                // timeInSecForIosWeb: 1,
                // backgroundColor: Colors.green,
                // textColor: Colors.white,
                // fontSize: 16.0);
              } else {
                print(state.userLogin!.message);
                showToast(message: state.userLogin!.message);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Image.asset("assets/images/login.png")),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "LOGIN",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "login now to browse our hot offers",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        defaultFormText(
                            control: emailController,
                            type: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Email can't be Empty";
                              }
                              return null;
                            },
                            label: "Email",
                            prefix: Icons.email),
                        const SizedBox(
                          height: 25,
                        ),
                        defaultFormText(
                            control: passwordController,
                            isPassword: ShopLoginCubit.get(context).isvisbal,
                            suffix: ShopLoginCubit.get(context).visbilityIcon,
                            suffixClicked: () {
                              ShopLoginCubit.get(context).visbility();
                            },
                            type: TextInputType.visiblePassword,
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).postLloginUserData(
                                    email: emailController.text,
                                    pass: passwordController.text);
                                // print(emailController.text);
                                // print(passwordController.text);
                              }
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Password is to short !";
                              }
                              return null;
                            },
                            label: "password",
                            prefix: Icons.lock_outline),
                        const SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context)
                                      .postLloginUserData(
                                          email: emailController.text,
                                          pass: passwordController.text);
                                  // print()
                                  // print(emailController.text);
                                  // print(passwordController.text);
                                }
                              },
                              text: "login".toUpperCase(),
                              backGroundColor: defaultColor),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have account yet ? "),
                            TextButton(
                              onPressed: () {
                                navagateTo(context, const RegisterPageScreen());
                              },
                              child: Text("register".toUpperCase()),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
