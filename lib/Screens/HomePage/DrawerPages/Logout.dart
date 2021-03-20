import 'dart:async';

import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:emall_adminpanel/SettingsAndVariables/routes/RouteCodes.dart';
import 'package:flutter/material.dart';

class Logout extends StatefulWidget {
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {

  Timer time;

  @override
  void initState() {
    time = new Timer.periodic(Duration(milliseconds: 800), (Timer t) {
      setState(() {
        Navigator.popAndPushNamed(context,LoginRouteCode);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    time.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 200,
      height: MediaQuery.of(context).size.height,
      color: White,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
