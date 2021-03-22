import 'package:emall_adminpanel/Api/SubCategory/AddNewSubCategory.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Toast/ToastMessages.dart';
import 'package:flutter/material.dart';

void AddSubCategoryDialog(String url,BuildContext context){
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
                 Text('Press Ok To Add SubCategory'):
                 Text('Wait loading...'),
               ],
             ),
             content: (isAdding)?Container(
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
                     setState(() {isAdding = true;});
                     AddNewSubCategory(url).then((value){
                       if(value) ShowToast("Added Successfully", context);
                       else ShowToast("Error in Adding", context);
                       Navigator.of(context).pop();
                     });
                   },
                   child: Text('Ok'),
                 )
               ],
             ),
           );
          }
        );
      }
  );
}