import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData LightMode=ThemeData(
  primarySwatch: Colors.blue,
primaryColor: Colors.black,
appBarTheme: AppBarTheme(
  backgroundColor: Colors.transparent,
  elevation: 0,
  shadowColor: Colors.transparent,
  iconTheme: IconThemeData(color: Colors.blue,size: 25),
  systemOverlayStyle: SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // Navigation bar
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent, //// Status bar
    statusBarIconBrightness: Brightness.dark,

  ),


)

);