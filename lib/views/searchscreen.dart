import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/helper/constants.dart';
import 'package:lets_chat/helper/helperfunction.dart';
import 'package:lets_chat/services/database.dart';
import 'package:lets_chat/views/conversationscreen.dart';
import 'package:lets_chat/widgets/widget.dart';
class Searchscreen extends StatefulWidget {
  @override
  _SearchscreenState createState() => _SearchscreenState();
}
String _myName;
class _SearchscreenState extends State<Searchscreen> {

  Databasemethods databasemethods = new Databasemethods();

  TextEditingController searchusernamecontroller = new TextEditingController();
  QuerySnapshot searchsnapshot;
  initiateSearch(){
    databasemethods.Getusersbyusername(searchusernamecontroller.text).then((val){
      setState(() {
        searchsnapshot=val;
      });

    });
  }


  Createchatroomandstartchat(String username){

   if(username != Constants.myName){
     String chatroomid = Getchatroomid(username, Constants.myName);

     List<String> users = [username, Constants.myName];
     Map<String,dynamic> chatroommap = {
       "users" : users,
       "chatroomid" : chatroomid
     };
     Databasemethods().Createchatroom(chatroomid,chatroommap);
     Navigator.push(context, MaterialPageRoute(
         builder: (context)=> Conversationscreen(chatroomid: chatroomid,)
     ));
   }else{
     debugPrint("you cannot send message to yourself");
   }

  }


  Widget Searchtile(String username,String useremail){
    return Container(padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username,style: buttontextstyle,),
              Text(useremail,style: buttontextstyle,)
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              Createchatroomandstartchat(username);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Text('Message',style: buttontextstyle,),
            ),
          ),
        ],
      ),
    );
  }



  Widget Searchlist(){
      return searchsnapshot!=null ? ListView.builder(itemBuilder:(context,index){
        // Map<String, String> data = searchsnapshot.docs[index].data();
        return Searchtile(
          searchsnapshot.docs[index].data()['name'],
          searchsnapshot.docs[index].data()['email']
        );
      } ,
      itemCount: searchsnapshot.docs.length,
        shrinkWrap: true,
      ) : Container();
  }
@override
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarmain(context),
      body: Container(
        child: Column(
          children: [
           Container(
             color: Color(0x54ffffff),
             padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
             child: Row(
               children: [
                 Expanded(child: TextField(
                   controller: searchusernamecontroller,
                   style: TextStyle(color: Colors.white),
                   decoration: InputDecoration(
                     border: InputBorder.none,

                     hintText: 'Search username.....',
                     hintStyle: TextStyle(
                       color: Colors.white54,
                     ),
                   ),
                 ),),
                 GestureDetector(
                   onTap: (){
                      initiateSearch();
                   },
                   child: Container(
                       height:40,
                       width: 40,
                       decoration: BoxDecoration(
                         gradient: LinearGradient(
                           colors: [
                             Color(0x36ffffff),
                             Color(0x0fffffff)
                           ]
                         ),
                         borderRadius: BorderRadius.circular(40),
                       ),
                       padding: EdgeInsets.all(12),

                       child: Image.asset('assets/images/search.png')),
                 ),
               ],
             ),
           ),
            Searchlist(),
          ],
        ),
      ),
    );
  }
}





Getchatroomid(String a,String b){
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";

  }else{
    return "$a\_$b";
  }
}