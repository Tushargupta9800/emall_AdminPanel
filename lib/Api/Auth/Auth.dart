import 'dart:convert';

import 'package:emall_adminpanel/Api/Secrets/Secrets.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:http/http.dart' as http;

Future<bool> AuthAdmin(String Password) async {
  var response = await http.post(
    Uri.parse(LoginUrl),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    },
    body: jsonEncode(<String, dynamic>{
      "password": Password,
    }),
  );
  Map<dynamic, dynamic> res = await jsonDecode(response.body.toString());
  if(res["error"] == null){
    isAuth = true;
    return true;
  }
  return false;
}