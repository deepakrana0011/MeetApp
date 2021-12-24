import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/provider/base_provider.dart';
import 'package:meetapp/service/FetchDataExpection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotProvider extends BaseProvider{
  Future<bool> forgotpassword(BuildContext context, String email) async {
    setState(ViewState.Busy);

    try {
      var model = await api.forgot(context,email);
      if(model.success==true){
        DialogHelper.showMessage(context, model.message);

        setState(ViewState.Idle);
        return true;
      }else{
        setState(ViewState.Idle);
        DialogHelper.showMessage(context, model.message);

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