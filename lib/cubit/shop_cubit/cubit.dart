import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit/states.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/login_model.dart';

import 'package:shop_app/models/shop_home_model.dart';
import 'package:shop_app/widgets/shop_screens/category_screen.dart';
import 'package:shop_app/widgets/shop_screens/favourite_screen.dart';
import 'package:shop_app/widgets/shop_screens/home_shop_screen.dart';
import 'package:shop_app/widgets/shop_screens/settings.dart';

import '../../widgets/shared/network/remote/dio_helper.dart';
import '../../widgets/shared/network/remote/end_points.dart';
import 'package:shop_app/widgets/shared/components/constant.dart';

import '../../models/shop_home_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitalState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomBody = [
    const HomeShopScreen(),
    const CategoryScreen(),
    const FavouriteScreen(),
    SettingsScreen()
  ];
  void changeBottom(int index) {
    if (index == 3) getUserData();
    if (index == 2) getAllFavorites();
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> inFavourite = {};
  Map<int, bool> incart = {};
  FavoriteModel? favoriteModel;
  void getHomeData() {
    emit(GetLoadingHomeShopState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((e) {
        inFavourite.addAll({e.id!: e.in_favorites!});
      });
      // print(inFavourite.toString());
      // print(homeModel!.data!.banners![0].image);
      // print(favorites);
      // print(homeModel!.data!.products![1]);
      homeModel!.data!.products!.forEach((e) {
        incart.addAll({e.id!: e.in_cart!});
      });
      print(incart.toString());

      emit(GetSuccesHomeShopState());
    }).catchError((e) {
      print(e.toString());
      emit(GetErrorHomeShopState());
    });
  }

  CategoryModel? categoryModel;
  void getCategoryData() {
    emit(GetLoadingCategoryShopState());
    DioHelper.getData(
      url: categories,
      token: token,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      // print(categoryModel!.data!.data![0].name);
      // print(favorites);
      // print(homeModel!.data!.products![1]);
      emit(GetSuccesCategoryShopState());
    }).catchError((e) {
      print(e.toString());
      emit(GetErrorCategoryShopState());
    });
  }

  ChangeFavModel? changeFavModel;
  void changeFavorites(productId) {
    inFavourite[productId] = !inFavourite[productId]!;
    emit(ChangeFavoritesShopState());
    DioHelper.postData(
            url: favorites, data: {"product_id": productId}, token: token)
        .then((value) {
      changeFavModel = ChangeFavModel.fromJson(value.data);
      if (!changeFavModel!.status!) {
        inFavourite[productId] = !inFavourite[productId]!;
      } else {
        getAllFavorites();
      }
      // print(changeFavModel!.message!);
      emit(ChangeFavoritesSuccessShopState(changeFavModel));
    }).catchError((e) {
      inFavourite[productId] = !inFavourite[productId]!;

      emit(ChangeFavoritesErrorShopState());
    });
  }

  void getAllFavorites() {
    emit(GetFavoritesLoadingShopState());
    DioHelper.getData(url: favorites, token: token).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      // print(value.data.);
      emit(GetFavoritesSuccessShopState());
    }).catchError((e) {
      emit(GetFavoritesErrorShopState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSucessUserDataState());
    }).catchError((e) {
      emit(ShopErrorUserDataState(e));
    });
  }

  void updateUserData({name, email, phone}) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
            url: updateProfile,
            data: {"name": name, "email": email, "phone": phone},
            token: token)
        .then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((e) {
      emit(ShopErrorUpdateUserState(e));
    });
  }
}
