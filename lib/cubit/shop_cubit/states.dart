import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopInitalState extends ShopStates {}

class ChangeBottomNavState extends ShopStates {}

class GetLoadingHomeShopState extends ShopStates {}

class GetSuccesHomeShopState extends ShopStates {}

class GetErrorHomeShopState extends ShopStates {}

class GetLoadingCategoryShopState extends ShopStates {}

class GetSuccesCategoryShopState extends ShopStates {}

class GetErrorCategoryShopState extends ShopStates {}

class ChangeFavoritesSuccessShopState extends ShopStates {
  ChangeFavModel? model;
  ChangeFavoritesSuccessShopState(this.model);
}

class ChangeFavoritesErrorShopState extends ShopStates {}

class ChangeFavoritesShopState extends ShopStates {}

class GetFavoritesLoadingShopState extends ShopStates {}

class GetFavoritesSuccessShopState extends ShopStates {}

class GetFavoritesErrorShopState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSucessUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {
  dynamic error;

  ShopErrorUserDataState(this.error);
}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  final ShopLoginModel? userLogin;
  ShopSuccessUpdateUserState(this.userLogin);
}

class ShopErrorUpdateUserState extends ShopStates {
  String e;
  ShopErrorUpdateUserState(this.e);
}

// class ShopLoadingProductDetailsState extends ShopStates {}

// class ShopSuccessProductDetailsState extends ShopStates {}

// class ShopErrorProductDetailsState extends ShopStates {
//   String e;
//   ShopErrorProductDetailsState(this.e);
// }
