import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  static const TOKEN= "token";


  static SharedPreferences? prefs;

  static clearSharePref() async {

    prefs?.setString(TOKEN, null);

  }

}