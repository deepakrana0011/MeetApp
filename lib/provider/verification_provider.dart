import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/provider/base_provider.dart';
import 'package:meetapp/service/FetchDataExpection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationProvider extends BaseProvider{
  Future<bool> verifyCode(BuildContext context, int code) async{
    setState(ViewState.Busy);
    try {
      var model = await api.verify(context,code);
      if(model.success){

        Navigator.pushNamedAndRemoveUntil(context, "dashboard", (Route<dynamic> route) => false);
        DialogHelper.showMessage(context, model.message);

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

  Future<bool> resendCode(BuildContext context) async{
    setState(ViewState.Busy);
    try {
      var model = await api.resend(context);
      if(model.success==true){


        DialogHelper.showMessage(context, model.message);

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





}