import 'package:flutter/material.dart';
import 'package:lets_chat/helper/constants.dart';
import 'package:lets_chat/services/database.dart';
import 'package:lets_chat/widgets/widget.dart';

class Conversationscreen extends StatefulWidget {
 final String chatroomid;
  Conversationscreen({this.chatroomid});
  @override
  _ConversationscreenState createState() => _ConversationscreenState();
}

class _ConversationscreenState extends State<Conversationscreen> {

  TextEditingController sendmessageeditincontroller = new TextEditingController();
  Stream chatmessagestream;
  Widget Chatmessagelist(){
      return StreamBuilder(
        stream: chatmessagestream,
        builder: (context,snapshot){
          return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context,index){
              return Messagetile(message: snapshot.data.docs[index].data()["message"],issentbyme: snapshot.data.docs[index].data()["sendby"] == Constants.myName,);
            },
          ): Container();
        },
      );
  }
  Databasemethods databasemethods = new Databasemethods();
  Sendmessage(){
    if(sendmessageeditincontroller.text.isNotEmpty){
      Map<String,dynamic> messagemap = {
        "message" : sendmessageeditincontroller.text,
        "sendby" : Constants.myName,
        "time" : DateTime.now().millisecondsSinceEpoch
      };
      databasemethods.Addconversationmessages(widget.chatroomid,messagemap);
      sendmessageeditincontroller.text="";
    }
  }

  @override
  void initState() {
    databasemethods.Getconversationmessages(widget.chatroomid).then((val){
        setState(() {
          chatmessagestream = val;
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarmain(context),
      body: Container(
        child: Stack(
          children: [
            Chatmessagelist(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0x54ffffff),
                padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                child: Row(
                  children: [
                    Expanded(child: TextField(
                      controller: sendmessageeditincontroller,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,

                        hintText: 'Enter message.....',
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                    ),),
                    GestureDetector(
                      onTap: (){
                       Sendmessage();
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

                          child: Image.asset('assets/images/send.png')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Messagetile extends StatelessWidget {
  final String message;
  final bool issentbyme;
  Messagetile({this.message,this.issentbyme});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: issentbyme ? 0 : 24,right: issentbyme ? 24 : 0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: issentbyme ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        decoration: BoxDecoration(

          gradient: LinearGradient(colors:issentbyme ? [Color(0xff007ef4),Color(0xff2a75bc)] : [Color(0x1affffff),Color(0x1bffffff)] ),
          borderRadius: issentbyme ? BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomLeft: Radius.circular(23)
          ) : BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomRight: Radius.circular(23),
          ),

        ),
        child: Text(message,style: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
        ),
      ),
    );
  }
}
