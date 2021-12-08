import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  static const TOKEN= "token";
  static const FIRST_NAME= "FIRST_NAME";
  static const USER_ID= "USER_ID";




  static SharedPreferences? prefs;

  static clearSharePref() async {

    prefs?.setString(TOKEN, null);
    prefs?.setString(FIRST_NAME, null);

  }

}