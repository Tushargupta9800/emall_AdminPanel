import 'package:emall_adminpanel/Api/DeliveryCharges/ChangeDeliveryCharges.dart';
import 'package:emall_adminpanel/Api/DeliveryCharges/GetDeliveryCharges.dart';
import 'package:emall_adminpanel/Api/Products/HalfCompleted.dart';
import 'package:emall_adminpanel/Api/Products/Sales.dart';
import 'package:emall_adminpanel/Api/Products/orders.dart';
import 'package:emall_adminpanel/Api/Secrets/Secrets.dart';
import 'package:emall_adminpanel/Api/SubCategory/DeleteSubCategory.dart';
import 'package:emall_adminpanel/Api/SubCategory/SubCategory.dart';
import 'package:emall_adminpanel/Api/Venders/Validation.dart';
import 'package:emall_adminpanel/Screens/HomePage/DrawerPages/Orders.dart';
import 'package:emall_adminpanel/Screens/HomePage/DrawerPages/Sales.dart';
import 'package:emall_adminpanel/Screens/HomePage/DrawerPages/Validation.dart';
import 'package:emall_adminpanel/Screens/HomePage/DrawerPages/VenderPayments.dart';
import 'package:emall_adminpanel/Screens/Others/AlertDialogs.dart';
import 'package:emall_adminpanel/Screens/Others/Loading.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Settings.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Toast/ToastMessages.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:emall_adminpanel/SettingsAndVariables/routes/RouteCodes.dart';
import 'package:emall_adminpanel/localization/Variables/Language_Codes.dart';
import 'package:emall_adminpanel/localization/code/Language_Constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String hover = "";
  String SubPageCode = ValidationSubPagecode;
  var color = Colors.blue[800];
  String DeliveryCharges = "0.0";
  TextEditingController DeliveryChargesController = TextEditingController();
  TextEditingController EnglishController = TextEditingController();
  TextEditingController ArabicController = TextEditingController();
  bool loading = true;
  bool isDeleting = false;

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
            DeliveryChargesController.clear();
            setState(() {loading = true;});
            GetDeliveryCharges().then((value) {
              setState(() {loading = false;});
            if (value != -1) ShowDialogForCharges(value);
            else ShowToast(Translate(context, ErrorTryAgainLanguageCode), context);});}

          else if(Where == VenderPaymentSubPageCode) {
            setState(() {SubPageCode = VenderPaymentSubPageCode;});
            setState(() {loading = true;
              HalfCompleted().then((value) {
                if(this.mounted)
                setState(() {loading = false;});});});}

          else if(Where == SalesSubPageCode){
            setState(() {SubPageCode = SalesSubPageCode;});
            setState(() {loading = true;
              AdminSales().then((value) {
                if(this.mounted)
                setState(() {loading = false;});});});}

          else if(Where == OrderSubPageCode){
            setState(() {SubPageCode = OrderSubPageCode;});
            setState(() {loading = true;
              AllOrders().then((value) {
                if(this.mounted)
                setState(() {loading = false;});});});}

          else if(Where == ValidationSubPagecode){
            setState(() {SubPageCode = ValidationSubPagecode;});
            setState(() {loading = true;});
            GetAllNonValdatingVenders().then((value){
              if(this.mounted)
              setState(() {loading = false;});});}

          else if(Where == NewSubCategorySubPageCode){
            EnglishController.clear();
            ArabicController.clear();
            setState(() {loading = true;});
            AllSubCategories().then((value){
              if(value) ShowDialogForSubCategory();
              else ShowToast(Translate(context, ErrorTryAgainLanguageCode), context);
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
                      color: (
                          (Where == ValidationSubPagecode && SubPageCode == ValidationSubPagecode) ||
                          (Where == OrderSubPageCode && SubPageCode == OrderSubPageCode) ||
                          (Where == SalesSubPageCode && SubPageCode == SalesSubPageCode) ||
                          (Where == VenderPaymentSubPageCode && SubPageCode == VenderPaymentSubPageCode))?Grey:White,
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
  void initState() {

    GetAllNonValdatingVenders().then((value){
      if(this.mounted)
      setState(() {loading = false;});});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: DarkBlue,
            title: Text(Translate(context, AdminDashBoardLanguageCode),
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
                              child: Text(Translate(context, AdminNameLanguageCode),style: TextStyle(color: White),)
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
                                  DrawerTile(Translate(context, ValidationLanguageCode),ValidationSubPagecode),
                                  DrawerTile(Translate(context, OrdersLanguageCode),OrderSubPageCode),
                                  DrawerTile(Translate(context, VenderPaymentsLanguageCode),VenderPaymentSubPageCode),
                                  DrawerTile(Translate(context, SalesLanguageCode),SalesSubPageCode),
                                  DrawerTile(Translate(context, SubCategoryLanguageCode),NewSubCategorySubPageCode),
                                  DrawerTile(Translate(context, LanguageLanguageCode),LanguageSubPageCode),
                                  DrawerTile(Translate(context, DeliveryChargesLanguageCode),DeliveryChargesSubPageCode),
                                  DrawerTile(Translate(context, LogoutLanguageCode),LogoutSubPageCode),
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
                      child: ReturnTheSubPage(SubPageCode),
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
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          bool isAdding = false;
          return  StatefulBuilder(
              builder: (context,setState){
                return AlertDialog(
                  title: Column(
                    children: [
                      (!isAdding)?
                      Column(
                        children: [
                          Text(Translate(context, OldChargesLanguageCode) + ": " + value.toString() + " SAR"),
                          Text(Translate(context, EnterNewChargesLanguageCode)),
                        ],
                      ):
                      Text(Translate(context, WaitLoadingLanguageCode)),
                    ],
                  ),
                  content: (isAdding)?Container(
                    width: 50,
                    height: 50,
                    child: Center(child: CircularProgressIndicator(),),
                  ):
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: DeliveryChargesController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(Translate(context, CancelLanguageCode)),
                          ),
                          TextButton(
                            onPressed: (){
                              setState((){
                                isAdding = true;
                              });
                              if(DeliveryChargesController.text.length > 0)
                                ChangeDeliveryCharges(ChangeDeliveryChargesUrl + double.parse(DeliveryChargesController.text).toString()).then((value){
                                  Navigator.of(context).pop();
                                });
                            },
                            child: Text(Translate(context, ChangeLanguageCode)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
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
            title: Text(Translate(context, SubCategoryLanguageCode)),
            content: Container(
              height: MediaQuery.of(context).size.height/2,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    for(int i=0;i<AllSubCategoryList.length;i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AllSubCategoryList[i].SubCategory),
                          InkWell(
                            onTap: (){
                              Navigator.of(context).pop();
                              ShowDialog(AllSubCategoryList[i].id);
                            },
                            child: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    SizedBox(height: 10,),
                    Text(Translate(context, NewSubCategoryLanguageCode)),
                    TextField(
                      controller: EnglishController,
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                        hintText: Translate(context, InEnglishLanguageCode),
                        contentPadding:
                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      ),
                    ),
                    TextField(
                      controller: ArabicController,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        hintText: Translate(context, InArabicLanguageCode),
                        contentPadding:
                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(Translate(context, CancelLanguageCode)),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  if(ArabicController.text.length > 0  && EnglishController.text.length > 0)
                    AddSubCategoryDialog(AddSubCategoriesUrl + EnglishController.text + "/" + ArabicController.text,context);
                },
                child: Text(Translate(context, AddLanguageCode)),
              ),
            ],
          );
        }
    );
  }

  void ShowDialog(String id){

    if(isDeleting)
      DeleteSubCategory(id).then((value){
        if(value){
          ShowToast(Translate(context, SubCatDeletedLanguageCode), context);
          if(this.mounted)
          setState(() {isDeleting = false;});
          Navigator.of(context).pop();
        }
        else{
          if(this.mounted)
          setState(() {isDeleting = false;});
          ShowToast(Translate(context, ErrorDeletingLanguageCode), context);
          Navigator.of(context).pop();
        }
      });

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return  AlertDialog(
            title: Column(
              children: [
                (!isDeleting)?
                Text(Translate(context, OkToDeleteSubCategoryLanguageCode)):
                Text(Translate(context, WaitLoadingLanguageCode)),
              ],
            ),
            content: (isDeleting)?Container(
              width: 50,
              height: 50,
              child: Center(child: CircularProgressIndicator(),),
            ):
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(Translate(context, CancelLanguageCode)),
                ),
                TextButton(
                  onPressed: (){
                    setState(() {isDeleting = true;});
                    Navigator.of(context).pop();
                    ShowDialog(id);
                  },
                  child: Text(Translate(context, OkLanguageCode)),
                )
              ],
            ),
          );
        }
    );
  }

  Widget ReturnTheSubPage(String Code){
    if(Code == ValidationSubPagecode) return Validation();
    else if(Code == OrderSubPageCode) return Orders();
    else if(Code == VenderPaymentSubPageCode) return VenderPayments();
    else return Sales();
  }

}
