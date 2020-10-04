import 'package:flutter/material.dart';
import 'package:lets_chat/views/signin.dart';
import 'package:lets_chat/views/signup.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showsignin = true;

  void Toggleview(){
    setState(() {
      showsignin = !showsignin;
    });
  }
  @override
  Widget build(BuildContext context) {
     if(showsignin){
      return Signin(toggle: Toggleview,);
    }else{
       return Signup(toggle: Toggleview,);
    }
  }
}
