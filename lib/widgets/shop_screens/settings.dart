import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit/cubit.dart';
import 'package:shop_app/cubit/shop_cubit/states.dart';

import 'package:shop_app/widgets/shared/components/constant.dart';

import 'package:shop_app/widgets/shared/components/shared_component.dart';

class SettingsScreen extends StatelessWidget {
  var emailControler = TextEditingController();
  var nameControler = TextEditingController();
  var phoneControler = TextEditingController();
  var formKey = GlobalKey<FormState>();

  // var emailControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessUpdateUserState) {
          if (state.userLogin!.status!) {
            print(state.userLogin!.message);
            print(state.userLogin!.data!.token);
            showToast(message: state.userLogin!.message);
          } else {
            print(state.userLogin!.message);
            showToast(message: state.userLogin!.message);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        emailControler.text = cubit.userModel!.data!.email!;
        print(emailControler.text);
        nameControler.text = cubit.userModel!.data!.name!;
        phoneControler.text = cubit.userModel!.data!.phone!;

        return ConditionalBuilder(
          condition: cubit.userModel != null,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateUserState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormText(
                        control: nameControler,
                        type: TextInputType.name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Name can't be Empty";
                          }
                          return null;
                        },
                        label: "Name",
                        prefix: Icons.person),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormText(
                        control: emailControler,
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
                      height: 20,
                    ),
                    defaultFormText(
                        control: phoneControler,
                        type: TextInputType.phone,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Phone can't be Empty";
                          }
                          return null;
                        },
                        label: "Phone",
                        prefix: Icons.phone),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserData(
                              name: nameControler.text,
                              email: emailControler.text,
                              phone: phoneControler.text,
                            );
                          }
                        },
                        text: "update"),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        text: "signout",
                        function: () {
                          signOut(context);
                          // ShopCubit.get(context).getUserData();
                        })
                  ],
                ),
              ),
            );
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
