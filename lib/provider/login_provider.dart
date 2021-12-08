import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/helper/shared_pref.dart';
import 'package:meetapp/provider/base_provider.dart';
import 'package:meetapp/service/FetchDataExpection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends BaseProvider{
  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  Future<bool> login(BuildContext context, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);

    try {
      var model = await api.login(context,email,password);
      if(model.success){
        SharedPref.prefs?.setString(SharedPref.TOKEN, model.token);
        SharedPref.prefs?.setString(SharedPref.FIRST_NAME, model.data!.firstName);
        SharedPref.prefs?.setString(SharedPref.USER_ID, model.data!.id);
        setState(ViewState.Idle);
        return true;
      }else{
        DialogHelper.showMessage(context, model.message);
        setState(ViewState.Idle);
        return false;
      }

    } on FetchDataException catch (c) {

      setState(ViewState.Idle);
      DialogHelper.showMessage(context, c.toString());
      return false;
    } on SocketException catch (c) {
      setState(ViewState.Idle);
      DialogHelper.showMessage(context, 'internet connection');
      return false;
    }


  }
}