import 'package:emall_adminpanel/Screens/Auth/LoginScreen.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:emall_adminpanel/SettingsAndVariables/routes/Routes.dart';
import 'package:emall_adminpanel/localization/code/App_Localization.dart';
import 'package:emall_adminpanel/localization/code/Language_Constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      AppLanguage = locale.languageCode;
      _locale = locale;
    });
  }


  @override
  Widget build(BuildContext context) {
    @override
    void didChangeDependencies() {
      getLocale().then((locale) {
        setState(() {
          AppLanguage = locale.languageCode;
          this._locale = locale;
        });
      });
      super.didChangeDependencies();
    }

    if (this._locale == null) {
      didChangeDependencies();
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800])),
        ),
      );
    } else
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Emall Customer",
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', 'SA'),
        ],

        localizationsDelegates: [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: _locale,

        localeResolutionCallback: (locale, supportedLocales){
          for(var supportedLocale in supportedLocales){
            if(supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode){
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        theme: ThemeData(
          fontFamily: _locale.countryCode == "SA"? "mainTheme": "Regular",
        ),
        home: LoginScreen(),
        routes: routes,
      );
  }
}