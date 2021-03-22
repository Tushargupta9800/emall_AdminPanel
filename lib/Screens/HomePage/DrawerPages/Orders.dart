import 'package:clipboard/clipboard.dart';
import 'package:emall_adminpanel/Api/Products/OrderCompleted.dart';
import 'package:emall_adminpanel/Api/Products/orders.dart';
import 'package:emall_adminpanel/Api/Secrets/Secrets.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Settings.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Toast/ToastMessages.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  HDTRefreshController _hdtRefreshController = HDTRefreshController();
  bool isCompleted = false;

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
        rightHandSideColumnWidth: 2500,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: AllOrdersList.length,
        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
        enablePullToRefresh: true,
        refreshIndicator: const WaterDropHeader(),
        refreshIndicatorHeight: 60,
        onRefresh: () async {
          await AllOrders();
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
      _getTitleItemWidget('Completed?', 200),
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
        FlutterClipboard.copy(AllOrdersList[index].ID).then(( value ) => ShowToast("Copied", context));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
        ),
        child: Text(AllOrdersList[index].ID,overflow: TextOverflow.ellipsis,),
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
        _OrderComplition(AllOrdersList[index].ID),
        _CopyTheData("All", index),
        _CopyTheData("Price", index),
        _dataTableBlock(AllOrdersList[index].TransactionId,200),
        _PriceHandler(AllOrdersList[index].ProductPrice.toString(),100,true),
        _PriceHandler(AllOrdersList[index].Tax.toString(),100,true),
        _PriceHandler(AllOrdersList[index].DeliveryCharges.toString(),150,AllOrdersList[index].isit),
        _PriceHandler(AllOrdersList[index].Total.toString(),100,AllOrdersList[index].isit),
        _CopyTheData("Customer", index),
        _dataTableBlock(AllOrdersList[index].date,250),
        _dataTableBlock(AllOrdersList[index].address,300),
        _dataTableBlock(AllOrdersList[index].mobile,100),
        _dataTableBlock(AllOrdersList[index].state,100),
        _dataTableBlock(AllOrdersList[index].country,100),
        _CopyTheData("Product", index),
        _dataTableBlock(AllOrdersList[index].productId,100),
        _ColorTile(AllOrdersList[index].color,100),
        _dataTableBlock(AllOrdersList[index].size,100),
        _dataTableBlock(AllOrdersList[index].quantity,100),
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

  Widget _OrderComplition(String ID){
    return InkWell(
      onTap: () async {
        ShowDialog(ID);
      },
      child: Container(
        width: 200,
        height: 52,
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
        ),
        child: Center(
          child: Text("Mark Complete",style: TextStyle(
            color: DarkBlue,
            decoration: TextDecoration.underline,
          ),),
        ),
      ),
    );
  }

  Widget _CopyTheData(String ThisText,int index){
    return InkWell(
      onTap: (){
        String data;
        String PriceData = "Transaction Id: " + AllOrdersList[index].TransactionId + " \n" +
            "Product Price: " + AllOrdersList[index].ProductPrice.toString() + "SAR" + " \n" +
            "Tax: " + AllOrdersList[index].Tax.toString() + "SAR" + " \n" +
            "Delivery Charges: " + AllOrdersList[index].DeliveryCharges.toString() + "SAR" + " \n" +
            "Total: " + AllOrdersList[index].Total.toString() + "SAR" + " \n";

        String CustomerData = "Date Of Order: " + AllOrdersList[index].date + " \n" +
            AllOrdersList[index].address + " \n" +
            "Mobile: " + AllOrdersList[index].mobile + " \n" +
            "State: " + AllOrdersList[index].state + " \n" +
            "Country: " + AllOrdersList[index].country + " \n";

        String ProductData = "Transaction Id: " + AllOrdersList[index].productId + " \n" +
            "Color: " + AllOrdersList[index].color + " \n" +
            "Size: " + AllOrdersList[index].size + " \n" +
            "Quantity: " + AllOrdersList[index].quantity + " \n";

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

  void ShowDialog(String id){

    if(isCompleted)
      MarkOrderComplete(id).then((value){
        if(value){
          AllOrders().then((value){
            if(value) ShowToast("Order Mark Complete", context);
            else ShowToast("Error in Reloading", context);
            setState(() {isCompleted = false;});
            Navigator.of(context).pop();
          });
        }
        else{
          setState(() {isCompleted = false;});
          ShowToast("Error in Marking", context);
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
                Text('Press Ok To Mark Complete'),
              ],
            ),
            content: (isCompleted)?Container(
              width: 50,
              height: 50,
              child: Center(child: CircularProgressIndicator(),),
            ):
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: (){
                    setState(() {isCompleted = true;});
                    Navigator.of(context).pop();
                    ShowDialog(id);
                  },
                  child: Text('Ok'),
                )
              ],
            ),
          );
        }
    );
  }

}
