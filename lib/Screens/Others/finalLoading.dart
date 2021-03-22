import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:flutter/material.dart';

Widget FinalLoadingscreen(bool loading,BuildContext context){
  return (loading)?
  Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    color: White,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          Text("Expired Login Again"),
        ],
      ),
    ),
  )
      :Container(width: 0,);
}