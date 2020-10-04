import 'package:flutter/material.dart';
import 'package:lets_chat/helper/helperfunction.dart';
import 'package:lets_chat/services/auth.dart';
import 'package:lets_chat/services/database.dart';
import 'package:lets_chat/views/chatroomscreen.dart';
import 'package:lets_chat/views/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:lets_chat/widgets/widget.dart';
class Signup extends StatefulWidget {
  final Function toggle;
  Signup({this.toggle});
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isLoading = false;
  final formkey = GlobalKey<FormState>();
  TextEditingController usernameeditingcontroller = new TextEditingController();
  TextEditingController emaileditingcontroller = new TextEditingController();
  TextEditingController passwordeditingcontroller = new TextEditingController();


  Authmethods authmethods= new Authmethods();
  Databasemethods databasemethods = new Databasemethods();
  // Helperfunction helperfunction = new Helperfunction();

  Signmeup() async{

    if(formkey.currentState.validate()){
      Map<String,String> Userinfomap = {
        "name" : usernameeditingcontroller.text,
        "email" : emaileditingcontroller.text
      };
      
      Helperfunction.Saveuseremailsharedpreference(emaileditingcontroller.text);
      Helperfunction.Saveusernamesharedpreference(usernameeditingcontroller.text);
        setState(() {
          isLoading = true;
        });
        
       await authmethods.Signupwithemailandpassword(emaileditingcontroller.text, passwordeditingcontroller.text).then((val){
          databasemethods.Upoaduserinfo(Userinfomap);
          Helperfunction.Saveuserloggedinsharedpreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context)=> Chatroom(),
        ));
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarmain(context),
      body:  isLoading? Container(
        child: Center(child: CircularProgressIndicator()),
      ) :SingleChildScrollView(
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
                          return val.isEmpty || val.length<2 ? "Provide a Genuine Username" : null;
                        },
                          controller: usernameeditingcontroller,
                          style: simpletextfield,
                          decoration: Textfielddecoration('Username')
                      ),
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
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                // Container(
                //   alignment: Alignment.centerRight,
                //   child: Container(
                //     padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                //
                //     child: Text('Forgot Password?.',style: simpletextfield,),
                //   ),
                // ),
                SizedBox(height: 8,),
                GestureDetector(
                  onTap: (){
                      Signmeup();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        const Color(0xff007eff),
                        const Color(0xff2a75bc)
                      ]),
                      borderRadius: BorderRadius.circular(30),

                    ),
                    child: Text('Sign Up',style: buttontextstyle),
                  ),
                ),
                SizedBox(height: 16,),
                // Container(
                //   alignment: Alignment.center,
                //   width: MediaQuery.of(context).size.width,
                //   padding: EdgeInsets.symmetric(vertical: 20),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(30),
                //
                //   ),
                //   child: Text('Sign In With Google',style: TextStyle(
                //     color: Colors.black87,
                //     fontSize: 17,
                //   ),),
                // ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an Account?. ',style: buttontextstyle,),

                    GestureDetector(
                      onTap: (){
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(' Sign In',style: TextStyle(
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
