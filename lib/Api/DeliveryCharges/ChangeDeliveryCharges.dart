import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> ChangeDeliveryCharges(url) async {
  var response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    },
  );
  Map<dynamic, dynamic> res = await jsonDecode(response.body.toString());
  if(res["error"] == null) return true;
  return false;
}