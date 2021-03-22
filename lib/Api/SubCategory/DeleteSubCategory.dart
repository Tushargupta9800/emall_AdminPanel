import 'dart:convert';

import 'package:emall_adminpanel/Api/Secrets/Secrets.dart';
import 'package:http/http.dart' as http;

Future<bool> DeleteSubCategory(String id) async {

  var response = await http.post(
    Uri.parse(DeleteSubCategoryUrl),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    },
    body: jsonEncode(<String, dynamic>{
      "id": id,
    }),
  );

  Map<dynamic, dynamic> res = jsonDecode(response.body.toString());

  if(res["error"] == null) return true;
  return false;
}