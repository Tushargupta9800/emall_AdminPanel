import 'package:clipboard/clipboard.dart';
import 'package:emall_adminpanel/Api/Products/HalfCompleted.dart';
import 'package:emall_adminpanel/Api/Venders/DonePayment.dart';
import 'package:emall_adminpanel/Api/Venders/GetInfo.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Settings.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Toast/ToastMessages.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class VenderPayments extends StatefulWidget {
  @override
  _VenderPaymentsState createState() => _VenderPaymentsState();
}

class _VenderPaymentsState extends State<VenderPayments> {
  HDTRefreshController _hdtRefreshController = HDTRefreshController();
  bool isShowing = true;

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
        itemCount: AllVenderPaymentLeftList.length,
        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
        enablePullToRefresh: true,
        refreshIndicator: const WaterDropHeader(),
        refreshIndicatorHeight: 60,
        onRefresh: () async {
          await HalfCompleted();
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
      _getTitleItemWidget('Payment Sent?', 200),
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
        FlutterClipboard.copy(AllVenderPaymentLeftList[index].ID).then(( value ) => ShowToast("Copied", context));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
        ),
        child: Text(AllVenderPaymentLeftList[index].ID,overflow: TextOverflow.ellipsis,),
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
        _OrderComplition(AllVenderPaymentLeftList[index].VenderId,AllVenderPaymentLeftList[index].ID),
        _CopyTheData("All", index),
        _CopyTheData("Price", index),
        _dataTableBlock(AllVenderPaymentLeftList[index].TransactionId,200),
        _PriceHandler(AllVenderPaymentLeftList[index].ProductPrice.toString(),100,true),
        _PriceHandler(AllVenderPaymentLeftList[index].Tax.toString(),100,true),
        _PriceHandler(AllVenderPaymentLeftList[index].DeliveryCharges.toString(),150,AllVenderPaymentLeftList[index].isit),
        _PriceHandler(AllVenderPaymentLeftList[index].Total.toString(),100,AllVenderPaymentLeftList[index].isit),
        _CopyTheData("Customer", index),
        _dataTableBlock(AllVenderPaymentLeftList[index].date,250),
        _dataTableBlock(AllVenderPaymentLeftList[index].address,300),
        _dataTableBlock(AllVenderPaymentLeftList[index].mobile,100),
        _dataTableBlock(AllVenderPaymentLeftList[index].state,100),
        _dataTableBlock(AllVenderPaymentLeftList[index].country,100),
        _CopyTheData("Product", index),
        _dataTableBlock(AllVenderPaymentLeftList[index].productId,100),
        _ColorTile(AllVenderPaymentLeftList[index].color,100),
        _dataTableBlock(AllVenderPaymentLeftList[index].size,100),
        _dataTableBlock(AllVenderPaymentLeftList[index].quantity,100),
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

  Widget _OrderComplition(String ID,String orderId){
    return InkWell(
      onTap: () async {
        getAllVenderInfo(ID,orderId);
      },
      child: Container(
        width: 200,
        height: 52,
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
        ),
        child: Center(
          child: Text("Mark Payment Sent",style: TextStyle(
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
        String PriceData = "Transaction Id: " + AllVenderPaymentLeftList[index].TransactionId + " \n" +
            "Product Price: " + AllVenderPaymentLeftList[index].ProductPrice.toString() + "SAR" + " \n" +
            "Tax: " + AllVenderPaymentLeftList[index].Tax.toString() + "SAR" + " \n" +
            "Delivery Charges: " + AllVenderPaymentLeftList[index].DeliveryCharges.toString() + "SAR" + " \n" +
            "Total: " + AllVenderPaymentLeftList[index].Total.toString() + "SAR" + " \n";

        String CustomerData = "Date Of Order: " + AllVenderPaymentLeftList[index].date + " \n" +
            AllVenderPaymentLeftList[index].address + " \n" +
            "Mobile: " + AllVenderPaymentLeftList[index].mobile + " \n" +
            "State: " + AllVenderPaymentLeftList[index].state + " \n" +
            "Country: " + AllVenderPaymentLeftList[index].country + " \n";

        String ProductData = "Transaction Id: " + AllVenderPaymentLeftList[index].productId + " \n" +
            "Color: " + AllVenderPaymentLeftList[index].color + " \n" +
            "Size: " + AllVenderPaymentLeftList[index].size + " \n" +
            "Quantity: " + AllVenderPaymentLeftList[index].quantity + " \n";

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

  void getAllVenderInfo(String VenderId,String id){

    setState(() {isShowing = true;});

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          bool isAdding = false;
          return  StatefulBuilder(
              builder: (context,setState){
                if(isShowing){
                  GetInfo(VenderId).then((value){
                    setState(() {isShowing = false;});
                  });
                }
                return AlertDialog(
                  title: Column(
                    children: [
                      (!isAdding && !isShowing)?
                      Text('Press Ok To Mark Payment Sent'):
                      Text('Wait loading...'),
                    ],
                  ),
                  content: (isAdding || isShowing)?Container(
                    width: 50,
                    height: 50,
                    child: Center(child: CircularProgressIndicator(),),
                  ):
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PrintVenderBankInfo("Name",PayToThisVender.Name),
                      PrintVenderBankInfo("ID",PayToThisVender.ID),
                      PrintVenderBankInfo("Mobile",PayToThisVender.Mobile),
                      PrintVenderBankInfo("Email",PayToThisVender.Email),
                      PrintVenderBankInfo("Bank Holder Name",PayToThisVender.BankHoldername),
                      PrintVenderBankInfo("BankName", PayToThisVender.BankName),
                      PrintVenderBankInfo("Account Number", PayToThisVender.AccountNumber),
                      PrintVenderBankInfo("IBan", PayToThisVender.IBan),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: (){
                              setState(() {isAdding = true;});
                              MarkVenderPaymentComplete(id).then((value){
                                if(value){
                                  HalfCompleted().then((value) {
                                    if(value) ShowToast("Done Marking", context);
                                    else ShowToast("Error Reloading", context);
                                    setState((){});
                                    Navigator.of(context).pop();
                                  });
                                }
                                else{
                                  Navigator.of(context).pop();
                                  ShowToast("Error in marking", context);
                                }
                              });
                            },
                            child: Text('Ok'),
                          )
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

  Widget PrintVenderBankInfo(String text1,String text){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(text1 + ": "),
            Text(text),
          ],
        ),
        SizedBox(width: 10,),
        InkWell(
          onTap: (){
            FlutterClipboard.copy(text).then((value) => ShowToast("Copied", context));
          },
          child: Icon(Icons.copy),
        ),
      ],
    );
  }

}
