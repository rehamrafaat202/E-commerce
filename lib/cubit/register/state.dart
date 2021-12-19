import 'package:shop_app/models/login_model.dart';

abstract class ShopRegistertStates {}

class ShopRegisterInitialState extends ShopRegistertStates {}

class ShopRegisterLoadingState extends ShopRegistertStates {}

class ShopRegisterSucessState extends ShopRegistertStates {
  final ShopLoginModel? userLogin;
  ShopRegisterSucessState(this.userLogin);
}

class ShopRegisterErrorState extends ShopRegistertStates {
  dynamic error;

  ShopRegisterErrorState(this.error);
}

class ChangeRegisterVisibilityOFPasswordState extends ShopRegistertStates {}

class ShopRegisterGetProfileLoadingState extends ShopRegistertStates {}

class ShopRegisterGetProfileSucessState extends ShopRegistertStates {
  final ShopLoginModel? userLogin;
  ShopRegisterGetProfileSucessState(this.userLogin);
}

class ShopRegisterGetProfileErrorState extends ShopRegistertStates {
  dynamic error;

  ShopRegisterGetProfileErrorState(this.error);
}
