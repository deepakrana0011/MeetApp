import 'dart:async';
import 'dart:core';
import 'dart:core';
import 'dart:io';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:mailto/mailto.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/provider/base_provider.dart';
import 'package:meetapp/service/FetchDataExpection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_intent/twitter_intent.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactDetailProvider extends BaseProvider {


  String latestLink = 'Unknown';
  String username='';
  String profilepic='';
  String description='';
  List userlinks=[];
  List userlinktype=[];
  List links=[];


  StreamSubscription? sub;

  Future<bool> saveTapUser(BuildContext context,id) async {
    try {
      var model = await api.saveTapUser(context, id);

      /*if (model.success) {

        return true;
      } else {
        DialogHelper.showMessage(context, model.message);
        setState(ViewState.Idle);
        return false;
      }*/
      return true;
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

        model.data.forEach((element) {

          username=element.firstName+" "+element.lastName;
          profilepic=element.profilePic;
          description=element.description;
          userlinks=element.userdetails;
        userlinks.forEach((element) {
        links.add(element.link);
        links=links;

          userlinktype.add(element.type);
          userlinktype=userlinktype;
        });
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


  launchLink(link,username) async {

    if(link=='Email'){
      final mailtoLink = Mailto(
        to: [username],

      );

      await launch('$mailtoLink');

    }
    else if(link=='Phone'){
      final url = "tel:"+username;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    else if(link=="Snapchat"){
      final url = 'https://snapchat.com/add/'+username ;
      if (await canLaunch(url)) {
        await launch(url,
        );
      } else {
        throw 'Could not launch $url';
      }
    }

    else if(link=="Whatsapp"){
      await FlutterLaunch.launchWhatsapp(phone: link, message: '');
    }
    else {
      final url = 'https://'+link+'.com/'+username+'/';
      if (await canLaunch(url)) {
        await launch(url,
        );
      } else {
        throw 'Could not launch $url';
      }
    }


  }

}