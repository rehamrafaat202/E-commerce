import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/login_cubit/state.dart';
// import 'package:shop_app/models/arwalogin.dart';
import 'package:shop_app/models/login_model.dart';
// import 'package:shop_app/models/user_profile_model.dart';

// import 'package:shop_app/widgets/constant.dart';
import '../../widgets/shared/network/remote/dio_helper.dart';
import '../../widgets/shared/network/remote/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLogintStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? userLogin;
  // LoginArwaModel? user;
  // UserProfileModel? userProfileModel;

  void postLloginUserData({email, pass}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
            url: login, data: {"email": email, "password": pass}, lang: "en")
        .then((value) {
      // print(value.data["data"]["email"]);
      // Data.fromJson(value.data);
      userLogin = ShopLoginModel.fromJson(value.data);
      // print(userLogin!.message);
      // print(userLogin!.data!.email);
      // print(LoginModel.fromJson(value.data).dataItems!.email);
      emit(ShopLoginSucessState(userLogin));
    }).catchError((error) {
      // print(error);
      emit(ShopLoginErrorState(error));
    });
  }

  IconData visbilityIcon = (Icons.visibility_off_outlined);
  bool isvisbal = true;
  void visbility() {
    isvisbal = !isvisbal;
    visbilityIcon =
        isvisbal ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeVisibilityOFPassword());
  }
}
