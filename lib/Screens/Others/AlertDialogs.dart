import 'package:emall_adminpanel/Api/SubCategory/AddNewSubCategory.dart';
import 'package:emall_adminpanel/SettingsAndVariables/Toast/ToastMessages.dart';
import 'package:emall_adminpanel/localization/Variables/Language_Codes.dart';
import 'package:emall_adminpanel/localization/code/Language_Constraints.dart';
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
                 Text(Translate(context, OkToAddSubCategoryLanguageCode)):
                 Text(Translate(context, WaitLoadingLanguageCode)),
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
                   child: Text(Translate(context, CancelLanguageCode)),
                 ),
                 TextButton(
                   onPressed: (){
                     setState(() {isAdding = true;});
                     AddNewSubCategory(url).then((value){
                       if(value) ShowToast(Translate(context, AddedSuccessfullyLanguageCode), context);
                       else ShowToast(Translate(context, ErrorinAddingLanguageCode), context);
                       Navigator.of(context).pop();
                     });
                   },
                   child: Text(Translate(context, OkLanguageCode)),
                 )
               ],
             ),
           );
          }
        );
      }
  );
}