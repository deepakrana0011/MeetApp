import 'package:flutter/src/widgets/framework.dart';
import 'package:meetapp/provider/base_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardProvider extends BaseProvider{


  Future<void> getToken(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
  }


}