import 'dart:ui';
import 'package:clipboard/clipboard.dart';
import 'package:emall_adminpanel/Api/Secrets/Secrets.dart';
import 'package:emall_adminpanel/Api/Venders/MarkValidate.dart';
import 'package:emall_adminpanel/Api/Venders/Validation.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Toast/ToastMessages.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:emall_adminpanel/SettingsAndVariables/routes/RouteCodes.dart';
import 'package:emall_adminpanel/localization/Variables/Language_Codes.dart';
import 'package:emall_adminpanel/localization/code/Language_Constraints.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:url_launcher/url_launcher.dart';

class Validation extends StatefulWidget {
  @override
  _ValidationState createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {

  HDTRefreshController _hdtRefreshController = HDTRefreshController();
  bool isValidating = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 200,
      height: MediaQuery.of(context).size.height,
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 100,
        rightHandSideColumnWidth: 2250,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: AllVendersList.length,
        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
        enablePullToRefresh: true,
        refreshIndicator: const WaterDropHeader(),
        refreshIndicatorHeight: 60,
        onRefresh: () async {
          await GetAllNonValdatingVenders();
          if(this.mounted)
          setState(() {});
          _hdtRefreshController.refreshCompleted();
        },
        htdRefreshController: _hdtRefreshController,
      ),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget(Translate(context, IDLanguageCode), 200),
      _getTitleItemWidget(Translate(context, ValidationLanguageCode), 100),
      _getTitleItemWidget(Translate(context, AllInfoLanguageCode), 100),
      _getTitleItemWidget(Translate(context, NameLanguageCode), 100),
      _getTitleItemWidget(Translate(context, EmailLanguageCode),200),
      _getTitleItemWidget(Translate(context, VATLanguageCode),100),
      _getTitleItemWidget(Translate(context, CRLanguageCode),100),
      _getTitleItemWidget(Translate(context, ProfileLanguageCode), 100),
      _getTitleItemWidget(Translate(context, ShopInfoLanguageCode), 100),
      _getTitleItemWidget(Translate(context, MobileLanguageCode), 100),
      _getTitleItemWidget(Translate(context, ShopNameLanguageCode), 100),
      _getTitleItemWidget(Translate(context, AddressLanguageCode), 100),
      _getTitleItemWidget(Translate(context, CityLanguageCode), 100),
      _getTitleItemWidget(Translate(context, PostalCodeLanguageCode), 100),
      _getTitleItemWidget(Translate(context, StateLanguageCode), 100),
      _getTitleItemWidget(Translate(context, CountryLanguageCode), 100),
      _getTitleItemWidget(Translate(context, BankInfoLanguageCode), 100),
      _getTitleItemWidget(Translate(context, BankHolderNameLanguageCode), 150),
      _getTitleItemWidget(Translate(context, AccountNumberLanguageCode), 150),
      _getTitleItemWidget(Translate(context, IBanLanguageCode), 150),
      _getTitleItemWidget(Translate(context, BankNameLanguageCode), 100),
    ];
  }


  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
      ),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return InkWell(
      onTap: (){
        FlutterClipboard.copy(AllVendersList[index].ID).then(( value ) => ShowToast(Translate(context, CopiedLanguageCode), context));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
        ),
        child: Text(AllVendersList[index].ID,overflow: TextOverflow.ellipsis,),
        width: 200,
        height: 52,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        _ValidateUser(AllVendersList[index].ID),
        _CopyTheData("All",index),
        _dataTableBlock(AllVendersList[index].Name,100),
        _dataTableBlock(AllVendersList[index].Email,200),
        _ShowImage(AllVendersList[index].VATImage,AllVendersList[index].ID,"A"),
        _ShowImage(AllVendersList[index].CRImage,AllVendersList[index].ID,"B"),
        _ShowImage(AllVendersList[index].ProfilePicImage,AllVendersList[index].ID,"C"),
        _CopyTheData("Shop",index),
        _dataTableBlock(AllVendersList[index].Mobile,100),
        _dataTableBlock(AllVendersList[index].Shopname,100),
        _dataTableBlock(AllVendersList[index].Address,100),
        _dataTableBlock(AllVendersList[index].City,100),
        _dataTableBlock(AllVendersList[index].PostalCode,100),
        _dataTableBlock(AllVendersList[index].State,100),
        _dataTableBlock(AllVendersList[index].Country,100),
        _CopyTheData("Bank",index),
        _dataTableBlock(AllVendersList[index].BankHoldername,150),
        _dataTableBlock(AllVendersList[index].AccountNumber,150),
        _dataTableBlock(AllVendersList[index].IBan,150),
        _dataTableBlock(AllVendersList[index].BankName,100),
      ],
    );
  }

  Widget _ValidateUser(String ID){
    return InkWell(
      onTap: () async {
        ShowDialog(ID);
      },
      child: Container(
        width: 100,
        height: 52,
        decoration: BoxDecoration(
            border: Border.all(width: 0.5),
        ),
        child: Center(
          child: Text(Translate(context, ValidateLanguageCode),style: TextStyle(
              color: DarkBlue,
            decoration: TextDecoration.underline,
          ),),
        ),
      ),
    );
  }

  Widget _ShowImage(var image,String id,String extra){
    return InkWell(
      onTap: (){
        setState(() {
          HeroTag = id + extra;
          HeroImage = image;
        });
        Navigator.pushNamed(context, FullImageRouteCode);
      },
      child: Hero(
        tag: id + extra,
        child: Container(
          width: 100,
          height: 52,
          decoration: BoxDecoration(
              border: Border.all(width: 0.5),
            image: DecorationImage(image: image)
          ),
        ),
      ),
    );
  }

  Widget _CopyTheData(String ThisText,int index){
    return InkWell(
      onTap: (){
        String data = "";
        String PersonalInfo;
        String ShopInfo;
        String BankInfo;

        PersonalInfo = "Name: " + AllVendersList[index].Name + " \n" +
            "Email: " + AllVendersList[index].Email + " \n" +
            "Mobile: " + AllVendersList[index].Mobile + " \n" +
            "ID: " + AllVendersList[index].ID + " \n";

        ShopInfo = "ShopName: " + AllVendersList[index].Name + " \n" +
            "Address: " + AllVendersList[index].Address + " \n" +
            "City: " + AllVendersList[index].City + " \n" +
            "PostalCode: " + AllVendersList[index].PostalCode + " \n" +
            "State: " + AllVendersList[index].State + " \n" +
            "Country: " + AllVendersList[index].Country + " \n";

        BankInfo = "BankHolder Name: " + AllVendersList[index].BankHoldername + " \n" +
            "Account Number: " + AllVendersList[index].AccountNumber + " \n" +
            "IBan: " + AllVendersList[index].IBan + " \n" +
            "BankName: " + AllVendersList[index].BankName + " \n";

        if(ThisText == "All") data = PersonalInfo + ShopInfo + BankInfo;
        else if(ThisText == "Shop") data = ShopInfo;
        else data = BankInfo;

        FlutterClipboard.copy(data).then(( value ) => ShowToast(Translate(context, CopiedLanguageCode), context));
      },
      child: Container(
        width: 100,
          height: 52,
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
          ),
          child: Icon(Icons.copy)
      ),
    );
  }

  Widget _dataTableBlock(String text,double width){
    return InkWell(
      onTap: (){
        FlutterClipboard.copy(text).then(( value ) => ShowToast(Translate(context, CopiedLanguageCode), context));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
        ),
        child: Text(text,overflow: TextOverflow.ellipsis),
        width: width,
        height: 52,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
      ),
    );
  }


  void ShowDialog(String id){

    if(isValidating)
    MarkVenderValidate(id).then((value){
      if(value){
        GetAllNonValdatingVenders().then((value){
          if(value) ShowToast(Translate(context, ValidationCompleteLanguageCode), context);
          else ShowToast(Translate(context, ErrorReloadingLanguageCode), context);
          if(this.mounted)
          setState(() {isValidating = false;});
          Navigator.of(context).pop();
        });
      }
      else{
        if(this.mounted)
        setState(() {isValidating = false;});
        ShowToast(Translate(context, ErrorValidatingLanguageCode), context);
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
                (!isValidating)?
                Text(Translate(context, OkToValidateUserLanguageCode)):
                Text(Translate(context, WaitLoadingLanguageCode)),
              ],
            ),
            content: (isValidating)?Container(
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
                    setState(() {isValidating = true;});
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

}