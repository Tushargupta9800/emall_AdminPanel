import 'dart:convert';

import 'package:emall_adminpanel/Api/Secrets/Secrets.dart';
import 'package:emall_adminpanel/Model/VenderModel.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:http/http.dart' as http;

Future<bool> GetInfo(String id) async {

  var response = await http.post(
    Uri.parse(GetInfoOfVenderUrl),
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

  if(res["error"] == null){
    PayToThisVender = VenderModel();
    PayToThisVender.Validation = res["data"]["validation"];
    PayToThisVender.step1Completed(
        res["data"]["name"],
        res["data"]["email"],
        res["data"]["password"],
        res["data"]["Mobile"],
        res["data"]["_id"]
    );
    PayToThisVender.step2Completed(
        res["data"]["Shop_Details"]["shopname"],
        res["data"]["Shop_Details"]["address"],
        res["data"]["Shop_Details"]["city"],
        res["data"]["Shop_Details"]["postalcode"],
        res["data"]["Shop_Details"]["state"],
        res["data"]["Shop_Details"]["country"]);
    PayToThisVender.step3Completed(
        res["data"]["Bank_Details"]["Bankholdername"],
        res["data"]["Bank_Details"]["Accountnumber"],
        res["data"]["Bank_Details"]["IBan"],
        res["data"]["Bank_Details"]["Bankname"]);

    PayToThisVender.ProfilePic.addAll(List.from(res["data"]["image"]["data"]["data"]));
    PayToThisVender.VAT.addAll(List.from(res["data"]["Shop_Details"]["VAT"]["data"]["data"]));
    PayToThisVender.CR.addAll(List.from(res["data"]["Shop_Details"]["CR"]["data"]["data"]));
    PayToThisVender.GetImages();
    return true;
  }
  return false;
}