import 'package:emall_adminpanel/Api/DeliveryCharges/GetDeliveryCharges.dart';
import 'package:emall_adminpanel/Api/Products/HalfCompleted.dart';
import 'package:emall_adminpanel/Api/Products/Sales.dart';
import 'package:emall_adminpanel/Api/Products/orders.dart';
import 'package:emall_adminpanel/Api/Secrets/Secrets.dart';
import 'package:emall_adminpanel/Api/SubCategory/SubCategory.dart';
import 'package:emall_adminpanel/Api/Venders/Validation.dart';
import 'package:emall_adminpanel/Screens/Others/Loading.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Settings.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Toast/ToastMessages.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:emall_adminpanel/SettingsAndVariables/routes/RouteCodes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String hover = "";
  var color = Colors.blue[800];
  String DeliveryCharges = "0.0";
  TextEditingController DeliveryChargesController = TextEditingController();
  TextEditingController EnglishController = TextEditingController();
  TextEditingController ArabicController = TextEditingController();
  bool loading = false;

  Widget DrawerTile(String text,String Where){

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
        onTap: () {
          if (Where == DeliveryChargesSubPageCode) {
            setState(() {loading = true;});
            GetDeliveryCharges().then((value) {
            if (value != -1) ShowDialogForCharges(value);
            else ShowToast("Error", context);});}

          else if(Where == VenderPaymentSubPageCode) {
            setState(() {loading = true;
              HalfCompleted().then((value) {
                setState(() {loading = false;});});});}

          else if(Where == SalesSubPageCode){
            setState(() {loading = true;
              Sales().then((value) {
                setState(() {loading = false;});});});}

          else if(Where == OrderSubPageCode){
            setState(() {loading = true;
              AllOrders().then((value) {
                setState(() {loading = false;});});});}

          else if(Where == ValidationSubPagecode){
            setState(() {loading = true;});
            GetAllNonValdatingVenders().then((value){
              setState(() {loading = false;});});}

          else if(Where == NewSubCategorySubPageCode){
            setState(() {loading = true;});
            AllSubCategories().then((value){
              if(value) ShowDialogForSubCategory();
              else ShowToast("Error", context);
            });
          }
          else if(Where == LanguageSubPageCode){
            setState(() {
              if(AppLanguage == "en") AppLanguage = "ar";
              else AppLanguage = "en";
              changeLanguage(AppLanguage, context);
            });
          }
          else if(Where == LogoutSubPageCode) Navigator.popAndPushNamed(context, LogoutRouteCode);
        },

        child: Container(
          color: (hover == text)?color:Colors.transparent,
          child: Column(
            children: [
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(text,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: White,
                    ),
                  ),
                  (Where == LanguageSubPageCode)?Text("  " + AppLanguage):Container(width: 0,)
                ],
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
                            child: Image.asset(NoImageImageCode,),
                          ),
                          Container(
                            height: 20,
                              child: Text("Admin Name",style: TextStyle(color: White),)
                          ),
                          Container(
                            width: 200,
                            margin: EdgeInsets.symmetric(vertical: 20),
                            height: MediaQuery.of(context).size.height - 230,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 1,
                                    color: Grey,
                                  ),
                                  DrawerTile("Validation",ValidationSubPagecode),
                                  DrawerTile("Orders",OrderSubPageCode),
                                  DrawerTile("Vender Payments",VenderPaymentSubPageCode),
                                  DrawerTile("Sales",SalesSubPageCode),
                                  DrawerTile("SubCategory",NewSubCategorySubPageCode),
                                  DrawerTile("Language",LanguageSubPageCode),
                                  DrawerTile("Delivery Charges",DeliveryChargesSubPageCode),
                                  DrawerTile("Logout",LogoutSubPageCode),
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
              Loadingscreen(loading, context),
            ],
          ),
        ),
    );
  }
  void ShowDialogForCharges(double value){
    setState(() {loading = false;});
    showDialog(
        context: context,
        builder: (BuildContext context){
          return  AlertDialog(
            title: Column(
              children: [
                Text('Old Delivery Charges: ' + value.toString() + " SAR"),
                Text('Enter new delivery Charges'),
              ],
            ),
            content: TextField(
              controller: DeliveryChargesController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  if(DeliveryChargesController.text.length > 0)
                  launch(ChangeDeliveryChargesUrl + double.parse(DeliveryChargesController.text).toString());
                },
                child: Text('Change'),
              ),
            ],
          );
        }
    );
  }

  void ShowDialogForSubCategory(){
    setState(() {loading = false;});
    showDialog(
        context: context,
        builder: (BuildContext context){
          return  AlertDialog(
            title: Text('SubCategories'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                for(int i=0;i<AllSubCategoryList.length;i++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AllSubCategoryList[i].SubCategory),
                      InkWell(
                        onTap: (){

                        },
                        child: Icon(Icons.delete),
                      ),
                    ],
                  ),
                SizedBox(height: 10,),
                Text('New SubCategory'),
                TextField(
                  controller: EnglishController,
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(
                    hintText: "In English",
                    contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  ),
                ),
                TextField(
                  controller: ArabicController,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintText: "In Arabic",
                    contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  if(ArabicController.text.length > 0  && EnglishController.text.length > 0)
                  launch(AddSubCategoriesUrl + EnglishController.text + "/" + ArabicController.text);
                },
                child: Text('Add'),
              ),
            ],
          );
        }
    );
  }
}
