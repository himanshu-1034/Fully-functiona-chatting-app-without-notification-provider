import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/helper/authenticate.dart';
import 'package:lets_chat/helper/helperfunction.dart';
import 'package:lets_chat/views/chatroomscreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userisloggedin=false;
  @override
  void initState() {
    getloggedinstaate();
    super.initState();

  }

  getloggedinstaate() async{
    await Helperfunction.Getuserloggedinsharedpeference().then((val){
        setState(() {
          userisloggedin = val;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LETS CHAT',
      theme: ThemeData(
        primaryColor: Color(0xff145c9e),
        scaffoldBackgroundColor: Color(0xff1f1f1f),

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:userisloggedin != null ? userisloggedin ? Chatroom():Authenticate() : Container(
        child:Center(child:Authenticate())
      ),
    );
  }
}

