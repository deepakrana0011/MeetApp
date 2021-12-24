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

    prefs?.setString(TOKEN, null);
    prefs?.setString(FIRST_NAME, null);
    prefs?.setString(USER_ID, null);
    prefs?.setString(profile_pic, null);
    prefs?.setString(LAST_NAME, null);
    prefs?.setString(AGE, null);
    prefs?.setString(DESCRIPTION, null);
    prefs?.setString(Email, null);


  }

}