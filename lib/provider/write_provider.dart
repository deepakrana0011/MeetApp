import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/model/Links.dart';
import 'package:meetapp/provider/base_provider.dart';
import 'package:meetapp/service/FetchDataExpection.dart';

class WriteProvider extends BaseProvider {
  List<Datum> links = [];
  List<String> writeitems = [
    'Instagram',
    'Facebook',
    'Twitter',
    'Whatsapp',
    'Phone',
    'Email',
    'Snapchat',
    'TikTok',
  ];
  final link = new TextEditingController();
  List types = [];
  List linkText = [];

  Future<bool> getLinks(BuildContext context) async {
    setState(ViewState.Busy);
    try {
      var model = await api.getLinks();
      links = model.data;
      links.forEach((element) {
        types.add(element.type);
        linkText.add(element.link);
      });

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

  Future<bool> createProfile(BuildContext context, String writeitem,
      String link) async {
    setState(ViewState.Busy);

    try {
      var model = await api.createLink(context, writeitem, link);
      if (model.success) {
        setState(ViewState.Idle);
        return true;
      } else {
        DialogHelper.showMessage(context, model.message);
        setState(ViewState.Idle);
        return false;
      }
    } on FetchDataException catch (c) {
      print(c.toString());
      setState(ViewState.Idle);
      DialogHelper.showMessage(context, c.toString());
      return false;
    } on SocketException catch (c) {
      setState(ViewState.Idle);
      DialogHelper.showMessage(context, 'internet connection');
      return false;
    }
  }

  void getLinkText(BuildContext context, writeitem) {
    link.clear();

    for(var i=0;i<types.length;i++){
      if(writeitem==types[i]){


        link.text=linkText[i];

      }
      else{

      }
    }

  }

 Future<bool> updateProfile(BuildContext context,  writeitem,  String link) async {
   setState(ViewState.Busy);

   try {
     var model = await api.updateLink(context, writeitem, link);
     if (model.success) {
       setState(ViewState.Idle);
       return true;
     } else {
       DialogHelper.showMessage(context, model.message);
       setState(ViewState.Idle);
       return false;
     }
   } on FetchDataException catch (c) {
     print(c.toString());
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

