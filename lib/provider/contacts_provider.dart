import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/model/GetTapUserResponse.dart';
import 'package:meetapp/provider/base_provider.dart';
import 'package:meetapp/service/FetchDataExpection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactsProvider extends BaseProvider{
  List<Datum> users = [];
  List username=[];
  List userpic=[];
  List tapid=[];


  Future<bool> getUsers(BuildContext context) async {
    setState(ViewState.Busy);
    try {
      var model = await api.getUsers();
      users = model.data;
     users.forEach((element) {
       username.add(element.tapUserid.firstName +" "+ element.tapUserid.lastName);
       username=username;
       userpic.add(element.tapUserid.profilePic);
       userpic=userpic;
      tapid.add(element.tapUserid.id);
      tapid=tapid;
      print(tapid);




     });

      print(users.length);


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