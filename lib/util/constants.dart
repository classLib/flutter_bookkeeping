import 'dart:ui';

import 'package:flutter/material.dart';

class Constants{
  static final hintTextStyle = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black12);
  static final editBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.grey));
  static final normalTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black);

  static var user_account = "user_account";
  static var user_password = "user_password";

  static String is_login = "is_login";
}