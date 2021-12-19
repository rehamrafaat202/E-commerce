import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/cubit/register/cubit.dart';
import 'package:shop_app/cubit/register/state.dart';

import 'package:shop_app/screens/login_page_screen.dart';
import '../widgets/shared/network/local/shared_preference.dart';

import 'package:shop_app/styles/colors.dart';
import 'package:shop_app/widgets/shared/components/constant.dart';
import 'package:shop_app/widgets/shared/components/shared_component.dart';
import './shop_layout_screen.dart';

class RegisterPageScreen extends StatefulWidget {
  const RegisterPageScreen({Key? key}) : super(key: key);

  @override
  State<RegisterPageScreen> createState() => _RegisterPageScreenState();
}

class _RegisterPageScreenState extends State<RegisterPageScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit, ShopRegistertStates>(
          listener: (context, state) {
            if (state is ShopRegisterSucessState) {
              if (state.userLogin!.status!) {
                print(state.userLogin!.message);
                // print(state.userLogin!.data!.token);
                CashHelper.saveData(
                        key: "token", value: state.userLogin!.data!.token)
                    .then((value) {
                  token = state.userLogin!.data!.token;
                  navagateToAndReplace(context, const ShopLayoutScreen());
                });
              } else {
                print(state.userLogin!.message);
                showToast(message: state.userLogin!.message);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "REGISTER",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Register now to browse our hot offers",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          defaultFormText(
                            control: nameController,
                            type: TextInputType.name,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Name can't be Empty";
                              }
                              return null;
                            },
                            label: "UserName",
                            prefix: Icons.person,
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
                            prefix: Icons.email,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          defaultFormText(
                              control: passwordController,
                              isPassword:
                                  ShopRegisterCubit.get(context).isvisbal,
                              suffix:
                                  ShopRegisterCubit.get(context).visbilityIcon,
                              suffixClicked: () {
                                ShopRegisterCubit.get(context).visbility();
                              },
                              type: TextInputType.visiblePassword,
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
                          defaultFormText(
                            control: phoneController,
                            type: TextInputType.phone,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "phone can't be Empty";
                              }
                              return null;
                            },
                            label: "phoneNumber",
                            prefix: Icons.phone,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingState,
                            builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopRegisterCubit.get(context)
                                        .postRegisterUserData(
                                            name: nameController.text,
                                            email: emailController.text,
                                            pass: passwordController.text,
                                            phone: phoneController.text);
                                  }
                                },
                                text: "Register".toUpperCase(),
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
                              const Text("Already have account  ? "),
                              TextButton(
                                onPressed: () {
                                  navagateTo(context, const LoginPageScreen());
                                },
                                child: Text("login".toUpperCase()),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
