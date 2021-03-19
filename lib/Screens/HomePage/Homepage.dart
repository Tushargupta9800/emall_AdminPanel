import 'package:emall_adminpanel/SettingsAndVariables/Settings.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String hover = "";
  var color = Colors.blue[800];

  Widget DrawerTile(String text){

    void _updateLocation(PointerEvent details) {
      setState(() {
        hover = text;
        color = Colors.blue[800];
      });
    }

    void _updateLocationexit(PointerEvent details) {
      setState(() {
        hover = "";
        color = Colors.blue[800];
      });
    }

    return MouseRegion(

      onHover: _updateLocation,
      onExit: _updateLocationexit,

      child: InkWell(
        onTap: (){

        },

        child: Container(
          color: (hover == text)?color:Colors.transparent,
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text(text,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: White,
                ),
                // style: mystyle(20.0, FontWeight.w400, Colors.white),
              ),
              SizedBox(height: 10,),
              Container(
                width: 200,
                height: 1,
                color: Grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: DarkBlue,
            title: Text("Admin DashBoard",
              style: TextStyle(
                color: White
              ),),
          ),
          body: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Row(
                  children: [
                    Container(
                      width: 200,
                      height: MediaQuery.of(context).size.height,
                      color: DarkBlue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            width: 100,
                            height: 100,
                            child: Image.asset("Assets/images/background/noimage.png",),
                          ),
                          Container(
                            height: 20,
                              child: Text("Admin Name",style: TextStyle(color: White),)
                          ),
                          Container(
                            width: 200,
                            margin: EdgeInsets.symmetric(vertical: 20),
                            height: MediaQuery.of(context).size.height - 250,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 1,
                                    color: Grey,
                                  ),
                                  DrawerTile("Validation"),
                                  DrawerTile("Orders"),
                                  DrawerTile("Vender Payments"),
                                  DrawerTile("Sales"),
                                  DrawerTile("New SubCategory"),
                                  DrawerTile("Language"),
                                  DrawerTile("Logout"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width-200,
                      height: MediaQuery.of(context).size.height,
                      color: Red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
