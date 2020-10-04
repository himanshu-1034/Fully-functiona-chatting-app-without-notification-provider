import 'package:shared_preferences/shared_preferences.dart';
class Helperfunction{
  static String sharedpreferenceuserloggedinkey = "ISLOGGEDIN";
  static String sharedpreferenceusernamekey = "USERNAMEKEY";
  static String sharedpreferenceuseremailkey = "USEREMAILKEY";

  static Future<bool> Saveuserloggedinsharedpreference(bool isuserloggedin) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedpreferenceuserloggedinkey, isuserloggedin);
  }

  static Future<bool> Saveusernamesharedpreference(String username) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedpreferenceusernamekey, username);
  }

  static Future<bool> Saveuseremailsharedpreference(String email) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedpreferenceuseremailkey, email);
  }

  static Future<bool> Getuserloggedinsharedpeference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(sharedpreferenceuserloggedinkey);
  }


  static Future<String> Getusernamesharedpeference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedpreferenceusernamekey);
  }


  static Future<String> Getuseremailsharedpeference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedpreferenceuseremailkey);
  }

}