import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/helper/helperfunction.dart';
import 'package:lets_chat/services/auth.dart';
import 'package:lets_chat/services/database.dart';
import 'package:lets_chat/views/chatroomscreen.dart';
import 'package:lets_chat/views/forgetpassword.dart';
import 'package:lets_chat/widgets/widget.dart';
class Signin extends StatefulWidget {
  final Function toggle;
  Signin({this.toggle});

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  Authmethods authmethods = new Authmethods();
  final formkey = GlobalKey<FormState>();
  TextEditingController emaileditingcontroller = new TextEditingController();
  TextEditingController passwordeditingcontroller = new TextEditingController();
  bool isloading = false;
  Databasemethods databasemethods = new Databasemethods();
  QuerySnapshot snapshot;
  SignIn() async{
    if(formkey.currentState.validate()){
      Helperfunction.Saveuseremailsharedpreference(emaileditingcontroller.text);
      databasemethods.Getusersbyemail(emaileditingcontroller.text).then((val){
        snapshot = val;
        Helperfunction.Saveusernamesharedpreference(snapshot.docs[0].data()['name']);
      });
      setState(() {
        isloading = true;
      });

    await authmethods.Signinwithemailandpassword(emaileditingcontroller.text, passwordeditingcontroller.text).then((val){
        if(val != null){

          Helperfunction.Saveuserloggedinsharedpreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context)=> Chatroom()
          ));
        }
      });
    }
    else{
      setState(() {
        isloading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarmain(context),
      body: isloading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                          validator: (val){
                            return RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(val) ? null : "Enter correct email";
                          },
                          controller: emaileditingcontroller,
                          style: simpletextfield,
                          decoration: Textfielddecoration('Email')
                      ),
                      TextFormField(
                          obscureText: true,
                          validator: (val){
                            return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(val) ?null: "Password must contain lower case,upper case,number and 1 special character";
                          },
                          controller: passwordeditingcontroller,
                          style: simpletextfield,
                          decoration: Textfielddecoration('Password')
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

                    child: GestureDetector(onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgotpassword()));
                    },child: Text('Forgot Password?.',style: simpletextfield,)),
                  ),
                ),
                SizedBox(height: 8,),
                GestureDetector(
                  onTap: (){
                    SignIn();
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
                    child: Text('Sign In',style: buttontextstyle),
                  ),
                ),
                SizedBox(height: 16,),
                // GestureDetector(
                //   onTap: (){
                //     authmethods.Signinwithgoogle(context);
                //   },
                //   child: Container(
                //     alignment: Alignment.center,
                //     width: MediaQuery.of(context).size.width,
                //     padding: EdgeInsets.symmetric(vertical: 20),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(30),
                //
                //     ),
                //     child: Text('Sign In With Google',style: TextStyle(
                //       color: Colors.black87,
                //       fontSize: 17,
                //     ),),
                //   ),
                // ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Text('Don\'t have an Account?. ',style: buttontextstyle,),
                    GestureDetector(
                      onTap: (){
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(' Register Now.',style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          decoration: TextDecoration.underline,
                        ),),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
