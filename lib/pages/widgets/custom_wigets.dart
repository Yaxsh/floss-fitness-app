import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../const/constants.dart';

class CustomWidgets{

  static getAppBar(){
    return AppBar(title:
      const Text(
        Constants.titleOfApp, style: TextStyle(color: Colors.black, letterSpacing: 1.5),
      ),
    );
  }

  static getSetRow(){
    return Row(
      children: const [
        //todo: replace with Expanded/Flexible
        SizedBox(
          width: 20,
          child: TextField(
            keyboardType: TextInputType.number,
          ),
        ),
        Text("kg x "),
        SizedBox(
          width: 20,
          child: TextField(keyboardType: TextInputType.number),
        ),
        Text("reps."),
      ],
    );
  }
}