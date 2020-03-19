import 'package:flutter/material.dart';
class Validators{
   final GlobalKey passwordKey;
   bool _formWasEdited;

  Validators(_formWasEdited,{this.passwordKey}){
     this._formWasEdited =_formWasEdited ;
  }


  String validateName(String value,{String errorMsg}) {
    _formWasEdited = true;
    if (value.isEmpty)
      return errorMsg??'Name is required.';
    final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return  errorMsg??'Please enter only alphabetical characters.';
    return null;
  }

   String validateDateTime(DateTime value,{String errorMsg}) {
     _formWasEdited = true;
     if (value==null)
       return errorMsg??'Name is required.';
     return null;
   }

  String validateEmail(String value) {
    _formWasEdited = true;
    if (value.isEmpty)
      return 'Email is required.';
    return null;
  }

  String validatePhoneNumber(String value) {
    _formWasEdited = true;
    final RegExp phoneExp = new RegExp(r'^\d\d\d\d\d\d\d\d\d\d\d$');
    if (!phoneExp.hasMatch(value))
      return '########### - Enter a NG phone number.';
    return null;
  }

  String validatePassword(String value) {
    _formWasEdited = true;
    //final FormFieldState<String> passwordField = passwordKey.currentState;
    if (value == null || value.isEmpty)
      return 'Please enter a password.';
    return null;
  }


}