import 'package:shop_app/models/login_model.dart';

abstract class ShopLogintStates {}

class ShopLoginInitialState extends ShopLogintStates {}

class ShopLoginLoadingState extends ShopLogintStates {}

class ShopLoginSucessState extends ShopLogintStates {
  final ShopLoginModel? userLogin;
  ShopLoginSucessState(this.userLogin);
}

class ShopLoginErrorState extends ShopLogintStates {
  dynamic error;

  ShopLoginErrorState(this.error);
}

class ChangeVisibilityOFPassword extends ShopLogintStates {}
