import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:flutter/material.dart';

Widget Loadingscreen(bool loading,BuildContext context){
  return (loading)?
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: White,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
      :Container(width: 0,);
}