import 'dart:convert';

import 'package:emall_adminpanel/Api/Secrets/Secrets.dart';
import 'package:http/http.dart' as http;

Future<double> GetDeliveryCharges() async {
  var response = await http.get(
    Uri.parse(GetDeliveryChargesUrl),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    },
  );
  Map<dynamic, dynamic> res = await jsonDecode(response.body.toString());
  if(res["error"] == null) return double.parse(res["Delivery_charges"]);
  return -1;
}