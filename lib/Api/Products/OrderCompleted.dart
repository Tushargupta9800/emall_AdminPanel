import 'dart:convert';

import 'package:emall_adminpanel/Api/Secrets/Secrets.dart';
import 'package:http/http.dart' as http;

Future<bool> MarkOrderComplete(String id) async {

  var response = await http.post(
    Uri.parse(CustomerPaymentConfirmationUrl),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    },
    body: jsonEncode(<String, dynamic>{
      "order_id": id,
    }),
  );

  Map<dynamic, dynamic> res = jsonDecode(response.body.toString());

  if(res["error"] == null) return true;
  print(res);
  return false;
}