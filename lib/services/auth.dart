import 'dart:async';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lets_chat/helper/helperfunction.dart';
import 'package:lets_chat/modals/user.dart';
import 'package:lets_chat/services/database.dart';
import 'package:lets_chat/views/chatroomscreen.dart';

class Authmethods{
final FirebaseAuth _auth = FirebaseAuth.instance;
// Signinwithgoogle(BuildContext context) async{
//   final GoogleSignIn googleSignIn = new GoogleSignIn();
//   final GoogleSignInAccount googleSignInAccount= await googleSignIn.signIn();
//   final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
//   final AuthCredential authCredential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication.idToken,accessToken: googleSignInAuthentication.accessToken);
//   var result = await _auth.signInWithCredential(authCredential);
//   User firebaseuser = result.user;
//   if(result == null){
//
//   }else{
//
//     Map<String,String> userinfowithgoogle = {
//       "name" : firebaseuser.displayName,
//       "email" : firebaseuser.email
//     };
//     Helperfunction.Saveuseremailsharedpreference(firebaseuser.email);
//     Helperfunction.Saveusernamesharedpreference(firebaseuser.displayName);
//     Databasemethods().Upoaduserinfo(userinfowithgoogle);
//     Helperfunction.Saveuserloggedinsharedpreference(true);
//     Navigator.push(context, MaterialPageRoute(builder: (context) => Chatroom()));
//   }
//
// }


Userid _userfromfirebase(User user){
  return user!=null ? Userid(userid: user.uid): null ;
}
Future Signinwithemailandpassword(String email,String password) async{
  try{
    var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    User firebaseuser = result.user;
    return _userfromfirebase(firebaseuser);

  }catch(e){
    debugPrint(e.toString());
  }
}

Future Signupwithemailandpassword(String email,String password) async{
  try{
    var result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User firebaseuser = result.user;
    return _userfromfirebase(firebaseuser);
  }catch(e){
    debugPrint(e.toString());
  }
}

Future resetpassword(String email) async{
  try{
    return await _auth.sendPasswordResetEmail(email: email);
  }
  catch(e){
    debugPrint(e.toString());
  }
}

Future Signout() async{
  try{
  return await _auth.signOut();
  }catch(e){
    debugPrint(e.toString());
  }
}
}