import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/cubit/shop_cubit/cubit.dart';
import 'package:shop_app/widgets/shared/components/shared_component.dart';
import '../network/local/shared_preference.dart';
import 'package:shop_app/screens/login_page_screen.dart';

String? token = "";

void signOut(context) {
  CashHelper.removeData('token');
  token = null;
  var model = ShopCubit.get(context).userModel;
  model!.data!.email = "";
  model.data!.name = "";
  model.data!.phone = "";
  navagateToAndReplace(context, const LoginPageScreen());
  ShopCubit.get(context).currentIndex = 0;
}
