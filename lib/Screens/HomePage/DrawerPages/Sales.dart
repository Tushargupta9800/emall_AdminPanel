import 'package:clipboard/clipboard.dart';
import 'package:emall_adminpanel/Api/Products/Sales.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Settings.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Toast/ToastMessages.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class Sales extends StatefulWidget {
  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  HDTRefreshController _hdtRefreshController = HDTRefreshController();

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
        rightHandSideColumnWidth: 2300,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: AllCompletedOrderList.length,
        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
        enablePullToRefresh: true,
        refreshIndicator: const WaterDropHeader(),
        refreshIndicatorHeight: 60,
        onRefresh: () async {
          await AdminSales();
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
      _getTitleItemWidget('ID', 200),
      _getTitleItemWidget('All Info', 100),
      _getTitleItemWidget('Price Info', 100),
      _getTitleItemWidget('Transaction ID', 200),
      _getTitleItemWidget('Product Price', 100),
      _getTitleItemWidget('Tax', 100),
      _getTitleItemWidget('Delivery Charges', 150),
      _getTitleItemWidget('Total Paid', 100),
      _getTitleItemWidget('Customer Info', 100),
      _getTitleItemWidget('Date And Time', 250),
      _getTitleItemWidget('Address', 300),
      _getTitleItemWidget('Mobile', 100),
      _getTitleItemWidget('State', 100),
      _getTitleItemWidget('Country', 100),
      _getTitleItemWidget('Product Info', 100),
      _getTitleItemWidget('Product Id', 100),
      _getTitleItemWidget('Color', 100),
      _getTitleItemWidget('Size', 100),
      _getTitleItemWidget('Quantity', 100),
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
        FlutterClipboard.copy(AllCompletedOrderList[index].ID).then(( value ) => ShowToast("Copied", context));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
        ),
        child: Text(AllCompletedOrderList[index].ID,overflow: TextOverflow.ellipsis,),
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
        _CopyTheData("All", index),
        _CopyTheData("Price", index),
        _dataTableBlock(AllCompletedOrderList[index].TransactionId,200),
        _PriceHandler(AllCompletedOrderList[index].ProductPrice.toString(),100,true),
        _PriceHandler(AllCompletedOrderList[index].Tax.toString(),100,true),
        _PriceHandler(AllCompletedOrderList[index].DeliveryCharges.toString(),150,AllCompletedOrderList[index].isit),
        _PriceHandler(AllCompletedOrderList[index].Total.toString(),100,AllCompletedOrderList[index].isit),
        _CopyTheData("Customer", index),
        _dataTableBlock(AllCompletedOrderList[index].date,250),
        _dataTableBlock(AllCompletedOrderList[index].address,300),
        _dataTableBlock(AllCompletedOrderList[index].mobile,100),
        _dataTableBlock(AllCompletedOrderList[index].state,100),
        _dataTableBlock(AllCompletedOrderList[index].country,100),
        _CopyTheData("Product", index),
        _dataTableBlock(AllCompletedOrderList[index].productId,100),
        _ColorTile(AllCompletedOrderList[index].color,100),
        _dataTableBlock(AllCompletedOrderList[index].size,100),
        _dataTableBlock(AllCompletedOrderList[index].quantity,100),
      ],
    );
  }

  Widget _PriceHandler(String text,double width,bool isit){
    return InkWell(
      onTap: (){
        FlutterClipboard.copy(text).then(( value ) => ShowToast("Copied", context));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
        ),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: (isit)?Colors.black:Colors.red
          ),
        ),
        width: width,
        height: 52,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget _CopyTheData(String ThisText,int index){
    return InkWell(
      onTap: (){
        String data;
        String PriceData = "Transaction Id: " + AllCompletedOrderList[index].TransactionId + " \n" +
            "Product Price: " + AllCompletedOrderList[index].ProductPrice.toString() + "SAR" + " \n" +
            "Tax: " + AllCompletedOrderList[index].Tax.toString() + "SAR" + " \n" +
            "Delivery Charges: " + AllCompletedOrderList[index].DeliveryCharges.toString() + "SAR" + " \n" +
            "Total: " + AllCompletedOrderList[index].Total.toString() + "SAR" + " \n";

        String CustomerData = "Date Of Order: " + AllCompletedOrderList[index].date + " \n" +
            AllCompletedOrderList[index].address + " \n" +
            "Mobile: " + AllCompletedOrderList[index].mobile + " \n" +
            "State: " + AllCompletedOrderList[index].state + " \n" +
            "Country: " + AllCompletedOrderList[index].country + " \n";

        String ProductData = "Transaction Id: " + AllCompletedOrderList[index].productId + " \n" +
            "Color: " + AllCompletedOrderList[index].color + " \n" +
            "Size: " + AllCompletedOrderList[index].size + " \n" +
            "Quantity: " + AllCompletedOrderList[index].quantity + " \n";

        if(ThisText == "All") data = PriceData + CustomerData + ProductData;
        else if(ThisText == "Price") data = PriceData;
        else if(ThisText == "Customer") data = CustomerData;
        else data = ProductData;

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

  Widget _ColorTile(String text,double width){
    return InkWell(
      onTap: (){
        FlutterClipboard.copy(text).then(( value ) => ShowToast("Copied", context));
      },
      child: Container(
        width: width,
        height: 52,
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.5,color: DarkBlue),
              color: HexColor.fromHex(text),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            width: 40,
            height: 40,
          ),
        ),
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
