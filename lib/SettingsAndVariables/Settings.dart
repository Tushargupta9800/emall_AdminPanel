import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:emall_adminpanel/localization/code/Language_Constraints.dart';
import 'package:emall_adminpanel/main.dart';
import 'package:flutter/material.dart';

void changeLanguage(String code,BuildContext context) async {

  Locale _temp;
  switch(code){
    case 'en':
      _temp = Locale('en', 'US');
      break;
    case 'ar':
      _temp = Locale('ar', 'SA');
      break;
    default:
      _temp = Locale('en', 'US');
  }
  await setLocale(_temp.languageCode);
  MyApp.setLocale(context, _temp);

}

Widget Loading(){
  return Container(
    width: ScreenWidth,
    height: ScreenHeight,
    color: White,
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

