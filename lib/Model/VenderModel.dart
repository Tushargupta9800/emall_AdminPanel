import 'dart:typed_data';

import 'package:flutter/material.dart';

class VenderModel{

  String Name = "name";
  String Email;
  String Password;
  String Mobile;
  List<int> ProfilePic = [];
  MemoryImage ProfilePicImage;
  String Token;

  String Shopname;
  String Address;
  String City;
  String PostalCode;
  String State;
  String Country;
  List<int> VAT = [];
  MemoryImage VATImage;
  List<int> CR = [];
  MemoryImage CRImage;

  String BankHoldername;
  String AccountNumber;
  String IBan;
  String BankName;

  bool Validation = false;

  void step1Completed(String NAME, String EMAIL, String PASSWORD,String Number){
    this.Name = NAME;
    this.Email = EMAIL;
    this.Password = PASSWORD;
    this.Mobile = Number;
  }

  void step2Completed(String SHOPNAME,String AdDDRESS, String CITY, String POSTLCODE, String STATE, String COUNTRY){
    this.Shopname = SHOPNAME;
    this.Address = AdDDRESS;
    this.City =CITY;
    this.PostalCode = POSTLCODE;
    this.State = STATE;
    this.Country = COUNTRY;

  }

  void step3Completed(String BANKHOLDERNAME,String ACCOUNTNUMBER,String IBAN, String BANKNAME){
    this.BankHoldername = BANKHOLDERNAME;
    this.AccountNumber = ACCOUNTNUMBER;
    this.IBan = IBAN;
    this.BankName = BANKNAME;
  }

  void GetImages(){
    ProfilePicImage = MemoryImage(Uint8List.fromList(ProfilePic));
    VATImage = MemoryImage(Uint8List.fromList(VAT));
    CRImage = MemoryImage(Uint8List.fromList(CR));
  }
}