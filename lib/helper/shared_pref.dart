import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  static const TOKEN= "token";
  static const FIRST_NAME= "FIRST_NAME";
  static const USER_ID= "USER_ID";
  static const profile_pic= "profile_pic";
  static const LAST_NAME= "LAST_NAME";
  static const AGE= "AGE";
  static const DESCRIPTION= "DESCRIPTION";
  static const Email= "Email";







  static SharedPreferences? prefs;

  static clearSharePref() async {
    prefs?.setString(TOKEN, "");
    prefs?.setString(FIRST_NAME, "");
    prefs?.setString(USER_ID, "");
    prefs?.setString(profile_pic, "");
    prefs?.setString(LAST_NAME, "");
    prefs?.setString(AGE, "");
    prefs?.setString(DESCRIPTION, "");
    prefs?.setString(Email, "");


  }

}