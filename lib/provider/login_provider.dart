import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meetapp/constants/route_constants.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/helper/shared_pref.dart';
import 'package:meetapp/provider/base_provider.dart';
import 'package:meetapp/provider/save_token.dart';
import 'package:meetapp/service/FetchDataExpection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

import '../locator.dart';

class LoginProvider extends BaseProvider{
  bool _isPasswordVisible = false;
  SaveToken saveToken= locator<SaveToken>();

  bool get isPasswordVisible => _isPasswordVisible;

  Future<bool> login(BuildContext context, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    SharedPref.prefs!.setString(SharedPref.Email,email);

    try {
      var model = await api.login(context,email,password);
      if(model.success){
        saveToken.registerToken=model.token;
        saveToken.id=model.data!.id;
        if(model.data!.verifyStatus==1){
          Navigator.pushNamedAndRemoveUntil(context, "dashboard", (Route<dynamic> route) => false);

        }
        else{

          Navigator.pushNamedAndRemoveUntil(context, "verification", (Route<dynamic> route) => false);
        }


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
      DialogHelper.showMessage(context, 'Internet connection');
      return false;
    }


  }

  Future<void> getLinks(BuildContext context) async {
    if(SharedPref.prefs?.getString(SharedPref.TOKEN) == null){
      getLinksStream().listen(( event) {
        final link=  event.split('/');
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(RoutesConstants.login,
          );
        });

      });
    }

  }

}