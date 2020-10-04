import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/widgets/widget.dart';
class Forgotpassword extends StatefulWidget {
  @override
  _ForgotpasswordState createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController emaileditingcontroller;
  final formkey = GlobalKey<FormState>();
  String email = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarmain(context),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50,left: 20,right: 20,bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("We Will Mail You a Link ! Please enter your Email-ID",style:simpletextfield),
              Column(

                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:20),
                    child: Form(
                      key: formkey,
                      child: TextFormField(
                          validator: (val){
                              if(RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(val)){
                                email = val;
                                return null;
                              }
                              else{
                                return "please enter valid email";
                              }


                          },
                          controller: emaileditingcontroller,
                          style: simpletextfield,
                          decoration: Textfielddecoration('Email')
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if(formkey.currentState.validate()){
                         FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) => debugPrint("sent!"));
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors:[
                          const Color(0xff007eff),
                          const Color(0xff2a75bc)
                        ] ),
                        borderRadius: BorderRadius.circular(30),

                      ),
                      child: Text('Send reset E-mail',style: buttontextstyle),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
