import 'dart:convert';

import 'package:emall_adminpanel/Api/Secrets/Secrets.dart';
import 'package:emall_adminpanel/Model/SubCategoryModel.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:http/http.dart' as http;

Future<bool> AllSubCategories() async {
  var response = await http.get(
    Uri.parse(SubCategoryUrl),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    },
  );

  Map<dynamic, dynamic> res = await jsonDecode(response.body.toString());

  if(res["error"] == null){
    AllSubCategoryList.clear();
    for(int i=0;i<res["data"].length;i++){
      SubCategoryModel NewSubCategory = SubCategoryModel();
      NewSubCategory.SubCategory = res["data"][i]["Subcategory"];
      NewSubCategory.id = res["data"][i]["_id"];
      AllSubCategoryList.add(NewSubCategory);
    }
    return true;
  }

  return false;
}