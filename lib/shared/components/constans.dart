import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String Token = '' ;

ThemeData LightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 30.0,
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.blue,
      type: BottomNavigationBarType.fixed,
      elevation: 0.0,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
    )
);

