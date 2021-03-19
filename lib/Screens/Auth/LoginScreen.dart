import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode textSecondFocusNode = new FocusNode();
  String Email = "Email";
  String Password = "Password";
  String Login = "Login";
  String NoAccount = "Create Account?";
  String language = "English";
  bool loading = true;
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  Icon PasswordIcon = Icon(Icons.lock_outline);
  bool passwordobscure = true;

  String ValidEmail = "Enter a valid Email";
  String ErrorLogin = "Error In Login Try Again";

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
          // mainAxisAlignment: (languageEnglish)?MainAxisAlignment.start:MainAxisAlignment.end,
          children: [
            Text(text,
              // style: mystyle(15.0, FontWeight.w500,Colors.blue[800]),
            ),
            // HSpace(20.0),
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 20.0,right: 20.0),
          margin: EdgeInsets.symmetric(vertical: 8.0,horizontal: 5.0),
          // decoration: curveDecoration(20.0, Colors.white,800),
          child: TextField(
            controller: Controller,
            // textDirection: (languageEnglish)?TextDirection.ltr:TextDirection.rtl,
            style: TextStyle(fontSize: 20),
            decoration: new InputDecoration(
              suffixIcon: InkWell(
                onTap: (){
                  FocusScope.of(context).requestFocus(new FocusNode());
                  if(text == Password){
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
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Assets/images/background/background.png"),
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
                // decoration: curveDecoration(20.0, Colors.grey[100],800),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Text(Login,
                          // style: mystyle(25.0, FontWeight.w500,Colors.black),
                        )),
                        // VSpace(10.0),
                        InputText(Email, EmailController,TextInputType.emailAddress,false,Icon(Icons.email)),
                        InputText(Password, PasswordController,TextInputType.text,passwordobscure,PasswordIcon),
                        // VSpace(10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                // router.pop(context);
                                // router.navigateTo(context, "/auth/register", transition: TransitionType.fadeIn);
                              },
                              child: Text(NoAccount,
                                // style: mystyle(15.0, FontWeight.w500,Colors.blue[800]),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  // Vender.Email = EmailController.text;
                                  // Vender.Password = PasswordController.text;
                                  // loading = true;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 60),
                                padding: EdgeInsets.all(10.0),
                                // decoration: curveDecoration(10.0, Colors.blue,400),
                                child: Text(Login,
                                  // style: mystyle(15.0, FontWeight.w400,Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
