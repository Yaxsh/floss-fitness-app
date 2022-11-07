import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../const/constants.dart';

class CustomAppBar{

  static getAppBar(){
    return AppBar(title:
      const Text(
        Constants.titleOfApp, style: TextStyle(color: Colors.black, letterSpacing: 1.5),
      ),
    );
  }
}