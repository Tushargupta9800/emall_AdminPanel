import 'package:emall_adminpanel/Screens/Auth/LoginScreen.dart';
import 'package:emall_adminpanel/Screens/HomePage/DrawerPages/Language.dart';
import 'package:emall_adminpanel/Screens/HomePage/DrawerPages/Logout.dart';
import 'package:emall_adminpanel/Screens/HomePage/Homepage.dart';
import 'package:emall_adminpanel/SettingsAndVariables/routes/RouteCodes.dart';
import 'package:flutter/material.dart';

var routes = <String,WidgetBuilder>{
  LoginRouteCode: (BuildContext context) => LoginScreen(),
  HomePageRouteCode: (BuildContext context) => HomePage(),
  LogoutRouteCode: (BuildContext context) => Logout(),
  LanguageRouteCode: (BuildContext context) => Language(),
};