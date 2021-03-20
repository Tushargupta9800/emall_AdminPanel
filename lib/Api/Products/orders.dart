import 'dart:convert';

import 'package:emall_adminpanel/Api/Secrets/Secrets.dart';
import 'package:emall_adminpanel/Model/OrderModel.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:http/http.dart' as http;

Future<bool> AllOrders() async {
  var response = await http.get(
    Uri.parse(IncompleteOrdersUrl),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    },
  );

  Map<dynamic, dynamic> res = await jsonDecode(response.body.toString());

  if(res["error"] == null){
    AllOrdersList.clear();
    for(var order in res["data"]){
      OrderModel newOrder = OrderModel();
      newOrder = OrderModel.fromJson(order);
      newOrder.getAmounts();
      AllOrdersList.add(newOrder);
    }
  }

  return false;

}