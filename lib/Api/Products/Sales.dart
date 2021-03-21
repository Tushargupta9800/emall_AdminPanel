import 'dart:convert';

import 'package:emall_adminpanel/Api/Secrets/Secrets.dart';
import 'package:emall_adminpanel/Model/OrderModel.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:http/http.dart' as http;

Future<bool> AdminSales() async {
  var response = await http.get(
    Uri.parse(ViewSalesUrl),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    },
  );

  Map<dynamic, dynamic> res = await jsonDecode(response.body.toString());

  if(res["error"] == null){
    AllCompletedOrderList.clear();
    for(var order in res["data"]){
      OrderModel newOrder = OrderModel();
      newOrder = OrderModel.fromJson(order);
      newOrder.getAmounts();
      AllCompletedOrderList.add(newOrder);
    }
  }

  return false;

}