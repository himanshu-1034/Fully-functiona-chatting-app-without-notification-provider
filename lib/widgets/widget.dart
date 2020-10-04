import 'package:flutter/material.dart';
Widget Appbarmain(BuildContext context){
  return AppBar(
title: Padding(
  padding: const EdgeInsets.only(top: 60),
  child:   Image.asset('assets/images/logo.png',height: 100,),
),
    // elevation: ,
    centerTitle: false,
  );
}

InputDecoration Textfielddecoration(String title){
  return InputDecoration(
    hintText: title,
    hintStyle: TextStyle(
        color: Colors.white54
    ),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white)
    ),
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white54)
    ),
  );
}
const TextStyle simpletextfield = TextStyle(color: Colors.white,fontSize: 16);
const TextStyle buttontextstyle = TextStyle(color: Colors.white,fontSize: 17);