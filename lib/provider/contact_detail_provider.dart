import 'dart:async';
import 'dart:core';
import 'dart:core';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/provider/base_provider.dart';
import 'package:meetapp/service/FetchDataExpection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';


class ContactDetailProvider extends BaseProvider {


  String latestLink = 'Unknown';


  StreamSubscription? sub;

  Future<bool> saveTapUser(BuildContext context,id) async {
    try {
      var model = await api.saveTapUser(context, id);
      if (model.success) {

        return true;
      } else {
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

  Future<bool> getUserDetail(BuildContext context,id) async {
    setState(ViewState.Busy);
    try {
      var model = await api.getUserDetail(id);
      if(model.success){



        return true;
      }



      setState(ViewState.Idle);
      return true;
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