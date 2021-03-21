import 'dart:convert';
import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:emall_adminpanel/Api/Secrets/Secrets.dart';
import 'package:emall_adminpanel/Model/VenderModel.dart';
import 'package:http/http.dart' as http;

Future<bool> GetAllNonValdatingVenders() async {
  var response = await http.get(
    Uri.parse(GetAllNonvalidateUsersUrl),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    },
  );

  Map<dynamic, dynamic> res = jsonDecode(response.body.toString());

  if(res["error"] == null) {
    AllVendersList.clear();
    for(var ven in res["data"]) {
      VenderModel Vender = VenderModel();
      Vender.Validation = ven["validation"];
      Vender.step1Completed(
          ven["name"],
          ven["email"],
          ven["password"],
          ven["Mobile"],
          ven["_id"]
      );
      Vender.step2Completed(
          ven["Shop_Details"]["shopname"],
          ven["Shop_Details"]["address"],
          ven["Shop_Details"]["city"],
          ven["Shop_Details"]["postalcode"],
          ven["Shop_Details"]["state"],
          ven["Shop_Details"]["country"]);
      Vender.step3Completed(
          ven["Bank_Details"]["Bankholdername"],
          ven["Bank_Details"]["Accountnumber"],
          ven["Bank_Details"]["IBan"],
          ven["Bank_Details"]["Bankname"]);

      Vender.ProfilePic.addAll(List.from(ven["image"]["data"]["data"]));
      Vender.VAT.addAll(List.from(ven["Shop_Details"]["VAT"]["data"]["data"]));
      Vender.CR.addAll(List.from(ven["Shop_Details"]["CR"]["data"]["data"]));
      Vender.GetImages();

      AllVendersList.add(Vender);
    }
    return true;

  }
  return false;
}