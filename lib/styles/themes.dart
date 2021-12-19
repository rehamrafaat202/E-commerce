import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
    textTheme: const TextTheme(),
    scaffoldBackgroundColor: defaultBackGroundColor,
    primarySwatch: defaultColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        unselectedItemColor: greyColor),
    fontFamily: "SourceSansPro",
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: defaultColor),
        backgroundColor: defaultBackGroundColor,
        elevation: 0.0,
        toolbarTextStyle: TextStyle(color: Colors.red)));
