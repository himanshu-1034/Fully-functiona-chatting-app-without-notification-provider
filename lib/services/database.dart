import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Databasemethods{
  Getusersbyusername(String username) async{
   return await FirebaseFirestore.instance.collection('users').where('name', isEqualTo: username ).get();

  }

  Getusersbyemail(String email) async{
    return await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email ).get();

  }

  Upoaduserinfo(Usermap){
    FirebaseFirestore.instance.collection('users').add(
      Usermap
    ).catchError((e){
      debugPrint(e.toString());
    });

  }

  Createchatroom(String chatroomid,chatroommap){
    FirebaseFirestore.instance.collection('chatroom').doc(chatroomid).set(chatroommap).catchError((e){
      debugPrint(e.toString());
    });
  }

  Addconversationmessages(String chatroomid,messagemap){
    FirebaseFirestore.instance.collection('chatroom').doc(chatroomid).collection('chats').add(messagemap);
  }


  Getconversationmessages(String chatroomid) async{
   return await FirebaseFirestore.instance.collection('chatroom').doc(chatroomid).collection('chats').orderBy("time",descending: false).snapshots();
  }

  Getchatrooms(String username) async{
    return await FirebaseFirestore.instance.collection('chatroom').where('users',arrayContains: username).snapshots();
  }

}