import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/helper/authenticate.dart';
import 'package:lets_chat/helper/constants.dart';
import 'package:lets_chat/helper/helperfunction.dart';
import 'package:lets_chat/services/database.dart';
import 'package:lets_chat/views/conversationscreen.dart';
import 'package:lets_chat/views/searchscreen.dart';
import 'package:lets_chat/widgets/widget.dart';
import 'package:lets_chat/services/auth.dart';
class Chatroom extends StatefulWidget {
  @override
  _ChatroomState createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  Authmethods authmethods = new Authmethods();
  Databasemethods databasemethods = new Databasemethods();
Stream chatroomstream;
  Widget Chatroomlist(){
    return StreamBuilder(
      stream: chatroomstream,
      builder: (context,snapshot){
        return snapshot.hasData ? ListView.builder(
          itemBuilder: (context,index){
            return Chatroomstile(username: snapshot.data.docs[index].data()["chatroomid"].toString().replaceAll('_', "").replaceAll(Constants.myName, ""), chatroomid: snapshot.data.docs[index].data()["chatroomid"],);
          },
          itemCount: snapshot.data.docs.length,
        ) : Container();
      },
    );
  }


  @override
  void initState() {
    Getuserinfo();
    // TODO: implement initState


    super.initState();
  }


  Getuserinfo() async{
    Constants.myName = await Helperfunction.Getusernamesharedpeference();
    databasemethods.Getchatrooms(Constants.myName).then((val){
      setState(() {
        chatroomstream = val;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Image.asset('assets/images/logo.png',height: 100,),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              authmethods.Signout();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=> Authenticate()
              ));
            },
              child: Container(padding:EdgeInsets.symmetric(horizontal: 16) ,child: Icon(Icons.exit_to_app))),
        ],
      ),
      body: Chatroomlist(),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=>Searchscreen()
        ));
      },
        child: Icon(Icons.search),
      ) ,
    );
  }
}



class Chatroomstile extends StatelessWidget {
  final String username;
  final String chatroomid;
  Chatroomstile({this.username,this.chatroomid});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Conversationscreen(chatroomid: chatroomid,)
        ));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40)
              ),
              child: Text(username.substring(0,1).toUpperCase()),
            ),
            SizedBox(width: 12,),
            Text(username,style: buttontextstyle,),
          ],
        ),
      ),
    );
  }
}
