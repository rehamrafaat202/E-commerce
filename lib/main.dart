import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit/cubit.dart';

import 'package:shop_app/screens/login_page_screen.dart';
import 'package:shop_app/screens/on_boarding_screen.dart';
import 'package:shop_app/screens/shop_layout_screen.dart';
import 'package:shop_app/styles/themes.dart';
import 'package:shop_app/widgets/shared/components/constant.dart';

import './widgets/shared/network/local/shared_preference.dart';
import './widgets/shared/network/remote/dio_helper.dart';
import 'blocObserver.dart';
// import 'package:bloc/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init1();

  await CashHelper.init();

  String? onBoarding = CashHelper.getData(key: 'onBoarding');
  print(onBoarding);
  token = CashHelper.getData(key: 'token');
  print(token);
  Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayoutScreen();
    } else {
      widget = const LoginPageScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategoryData()
              ..getAllFavorites()
              ..getUserData())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: lightTheme,
        home: startWidget,
      ),
    );
  }
}
