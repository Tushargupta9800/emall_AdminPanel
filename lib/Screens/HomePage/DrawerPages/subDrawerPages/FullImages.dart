import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:flutter/material.dart';

class FullImage extends StatefulWidget {
  @override
  _FullImageState createState() => _FullImageState();
}

class _FullImageState extends State<FullImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: DarkBlue,
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  constrained: false,
                  child: Container(
                    width: MediaQuery.of(context).size.width-100,
                    height: MediaQuery.of(context).size.height-100,
                    child: Hero(
                      tag: HeroTag,
                      child: Container(
                        width: 100,
                        height: 52,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: HeroImage)
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Grey,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Icon(Icons.arrow_back,color: White,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
