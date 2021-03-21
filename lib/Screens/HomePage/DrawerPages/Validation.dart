import 'package:clipboard/clipboard.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Toast/ToastMessages.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class Validation extends StatefulWidget {
  @override
  _ValidationState createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {

  HDTRefreshController _hdtRefreshController = HDTRefreshController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 200,
      height: MediaQuery.of(context).size.height,
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 100,
        rightHandSideColumnWidth: 2150,
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
          //Do sth
          // await Future.delayed(const Duration(milliseconds: 500));
          // _hdtRefreshController.refreshCompleted();
        },
        htdRefreshController: _hdtRefreshController,
      ),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('ID', 200),
      _getTitleItemWidget('All Info', 100),
      _getTitleItemWidget('Name', 100),
      _getTitleItemWidget('Email',200),
      _getTitleItemWidget('VAT',100),
      _getTitleItemWidget('CR',100),
      _getTitleItemWidget('Profile', 100),
      _getTitleItemWidget('Shop Info', 100),
      _getTitleItemWidget('Mobile', 100),
      _getTitleItemWidget('ShopName', 100),
      _getTitleItemWidget('Address', 100),
      _getTitleItemWidget('City', 100),
      _getTitleItemWidget('Postal Code', 100),
      _getTitleItemWidget('State', 100),
      _getTitleItemWidget('Country', 100),
      _getTitleItemWidget('Bank Info', 100),
      _getTitleItemWidget('BankHolder Name', 150),
      _getTitleItemWidget('Account Number', 150),
      _getTitleItemWidget('IBan', 150),
      _getTitleItemWidget('BankName', 100),
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
        FlutterClipboard.copy(AllVendersList[index].ID).then(( value ) => ShowToast("Copied", context));
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
        _CopyTheData("All",index),
        _dataTableBlock(AllVendersList[index].Name,100),
        _dataTableBlock(AllVendersList[index].Email,200),
        _ShowImage(AllVendersList[index].VATImage),
        _ShowImage(AllVendersList[index].CRImage),
        _ShowImage(AllVendersList[index].ProfilePicImage),
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

  Widget _ShowImage(var image){
    return Container(
      width: 100,
      height: 52,
      decoration: BoxDecoration(
          border: Border.all(width: 0.5),
        image: DecorationImage(image: image)
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
            "Mobile: " + AllVendersList[index].Mobile + " \n " +
            "ID: " + AllVendersList[index].ID + " \n";

        ShopInfo = "ShopName: " + AllVendersList[index].Name + " \n" +
            "Address: " + AllVendersList[index].Address + " \n" +
            "City: " + AllVendersList[index].City + " \n" +
            "PostalCode: " + AllVendersList[index].PostalCode + " \n" +
            "State: " + AllVendersList[index].State + " \n" +
            "Country: " + AllVendersList[index].Country + " \n";

        BankInfo = "BankHolder Name: " + AllVendersList[index].BankHoldername + " \n" +
            "Account Number: " + AllVendersList[index].AccountNumber + " \n" +
            "IBan: " + AllVendersList[index].IBan + " \n " +
            "BankName: " + AllVendersList[index].BankName + " \n";

        if(ThisText == "All") data = PersonalInfo + ShopInfo + BankInfo;
        else if(ThisText == "Shop") data = ShopInfo;
        else data = BankInfo;

        FlutterClipboard.copy(data).then(( value ) => ShowToast("Copied", context));
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
        FlutterClipboard.copy(text).then(( value ) => ShowToast("Copied", context));
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

}