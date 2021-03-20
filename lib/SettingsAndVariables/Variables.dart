import 'package:emall_adminpanel/Model/OrderModel.dart';
import 'package:emall_adminpanel/Model/SubCategoryModel.dart';
import 'package:emall_adminpanel/Model/VenderModel.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Settings.dart';
import 'package:flutter/material.dart';

String AppLanguage = "en";

double ScreenWidth;
double ScreenHeight;

Color White = Colors.white;
Color Black = Colors.black;
Color Grey = Colors.grey;
Color LightGrey = Colors.grey[400];
Color LightestGrey = Colors.grey[100];
Color Blue = Colors.blue;
Color Red = Colors.red;
Color DarkBlue = HexColor.fromHex("#18396A");

String NoImageImageCode = "Assets/images/background/noimage.png";
String BackgroundImageCode = "Assets/images/background/background.png";

List<SubCategoryModel> AllSubCategoryList = [];
List<VenderModel> AllVendersList = [];
List<OrderModel> AllOrdersList = [];
List<OrderModel> AllVenderPaymentLeftList = [];
List<OrderModel> AllCompletedOrderList = [];