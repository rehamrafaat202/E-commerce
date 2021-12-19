import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/cubit/register/state.dart';
// import 'package:shop_app/models/arwalogin.dart';
import 'package:shop_app/models/login_model.dart';
import '../../widgets/shared/network/remote/dio_helper.dart';
import '../../widgets/shared/network/remote/end_points.dart';
// import 'package:shop_app/widgets/constant.dart';

class ShopRegisterCubit extends Cubit<ShopRegistertStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? userLogin;

  void postRegisterUserData({name, email, pass, phone}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
            url: REGISTER,
            data: {
              "name": name,
              "email": email,
              "password": pass,
              "phone": phone
            },
            lang: "en")
        .then((value) {
      userLogin = ShopLoginModel.fromJson(value.data);

      emit(ShopRegisterSucessState(userLogin));
    }).catchError((error) {
      // print(error);
      emit(ShopRegisterErrorState(error));
    });
  }

  IconData visbilityIcon = (Icons.visibility_off_outlined);
  bool isvisbal = true;
  void visbility() {
    isvisbal = !isvisbal;
    visbilityIcon =
        isvisbal ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeRegisterVisibilityOFPasswordState());
  }
}
