import 'dart:convert';

import 'package:emall_adminpanel/Api/Secrets/Secrets.dart';
import 'package:emall_adminpanel/Model/OrderModel.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:http/http.dart' as http;

Future<bool> HalfCompleted() async {
  var response = await http.get(
    Uri.parse(VenderPaymentUrl),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    },
  );

  Map<dynamic, dynamic> res = await jsonDecode(response.body.toString());

  if(res["error"] == null){
    AllVenderPaymentLeftList.clear();
    for(var order in res["data"]){
      OrderModel newOrder = OrderModel();
      newOrder = OrderModel.fromJson(order);
      newOrder.getAmounts();
      AllVenderPaymentLeftList.add(newOrder);
    }
  }

  return false;

}