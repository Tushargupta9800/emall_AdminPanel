import 'package:emall_adminpanel/Api/Auth/Auth.dart';
import 'package:emall_adminpanel/Screens/Others/Loading.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Toast/ToastMessages.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:emall_adminpanel/SettingsAndVariables/routes/RouteCodes.dart';
import 'package:emall_adminpanel/localization/Variables/Language_Codes.dart';
import 'package:emall_adminpanel/localization/code/Language_Constraints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode textSecondFocusNode = new FocusNode();
  bool loading = false;
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  Icon PasswordIcon = Icon(Icons.lock_outline);
  bool passwordobscure = true;

  @override
  void dispose() {
    EmailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  @override
  initState(){
    super.initState();
  }

  Widget InputText(String text, TextEditingController Controller,var keyboardtype,bool obscure,var icon){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(text,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: DarkBlue,
              ),
            ),
            // HSpace(20.0),
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 20.0,right: 20.0),
          margin: EdgeInsets.symmetric(vertical: 8.0,horizontal: 5.0),
          decoration: BoxDecoration(
            color: White,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [BoxShadow(
              color: Colors.grey[800],
              blurRadius: 5.0,
            ),],
          ),
          child: TextField(
            controller: Controller,
            style: TextStyle(fontSize: 20),
            decoration: new InputDecoration(
              suffixIcon: InkWell(
                onTap: (){
                  FocusScope.of(context).requestFocus(new FocusNode());
                  if(text == Translate(context, PasswordLanguageCode)){
                    setState(() {
                      if(passwordobscure) PasswordIcon = Icon(Icons.lock_open);
                      else PasswordIcon = Icon(Icons.lock_outline);
                      passwordobscure = !passwordobscure;
                    });
                  }
                },
                child: icon,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            ),
            keyboardType: keyboardtype,
            obscureText: obscure,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenWidth = MediaQuery.of(context).size.width;
    ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(BackgroundImageCode),
            fit: BoxFit.fill,
          ),
          color: Colors.blue[300],
        ),
        child: Stack(
          children: [

            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                margin: EdgeInsets.all(20.0),
                width: (MediaQuery.of(context).size.width > 400)?400:MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: LightestGrey,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [BoxShadow(
                    color: Colors.grey[800],
                    blurRadius: 5.0,
                  ),],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Text(Translate(context, LoginLanguageCode),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Black,
                          ),
                        )),
                        SizedBox(height: 10.0,),
                        InputText(Translate(context, EmailLanguageCode), EmailController,TextInputType.emailAddress,false,Icon(Icons.email)),
                        InputText(Translate(context, PasswordLanguageCode), PasswordController,TextInputType.text,passwordobscure,PasswordIcon),
                        SizedBox(height: 10.0,),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                loading = true;
                              });
                                if(_ValidateCredentials()){
                                  //after login
                                  AuthAdmin(PasswordController.text).then((value){
                                    setState(() {loading = false;});
                                    if(value) Navigator.popAndPushNamed(context, HomePageRouteCode);
                                    else ShowToast(Translate(context, WrongPasswordLanguageCode), context);
                                  });
                                }
                                else{
                                  setState((){loading = false;});
                                  ShowToast(Translate(context, ErrorTryAgainLanguageCode), context);
                                }
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Blue,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                boxShadow: [BoxShadow(
                                  color: Colors.grey[400],
                                  blurRadius: 5.0,
                                ),],
                              ),
                              child: Text(Translate(context, LoginLanguageCode),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: White,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Loadingscreen(loading, context),
          ],
        ),
      ),
    );
  }

  bool _ValidateCredentials(){
    return (EmailController.text == "email" && PasswordController.text.length > 0);
  }

}
