import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:meetapp/constants/api_constants.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/helper/shared_pref.dart';
import 'package:meetapp/model/Links.dart';
import 'package:meetapp/model/write_record.dart';
import 'package:meetapp/provider/base_provider.dart';
import 'package:meetapp/service/FetchDataExpection.dart';
import 'package:nfc_manager/nfc_manager.dart';

class WriteProvider extends BaseProvider {
  List<Datum> links = [];




  ValueNotifier<dynamic> result = ValueNotifier(null);
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
        getLinks(context);

        Navigator.of(context).pop();
        DialogHelper.showMessage(
            context,
            'User Detail Created successfully');
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
      DialogHelper.showMessage(context, 'Internet connection');
      return false;
    }
  }

  void getLinkText(BuildContext context, writeitem) {
    getLinks(context);
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
       getLinks(context);

       Navigator.of(context).pop();
       DialogHelper.showMessage(
           context,
           'User Detail Updated successfully');

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
     DialogHelper.showMessage(context, 'Internet connection');
     return false;
   }

  }

  Future<String> writeNdef(NfcTag tag) async {

    var id=SharedPref.prefs?.getString(SharedPref.USER_ID);

      final tech = Ndef.from(tag);

      if (tech == null)
        throw('Tag is not ndef.');

      if (!tech.isWritable)
        throw('Tag is not ndef writable.');


      try {
        final message = NdefMessage(
            [

          NdefRecord.createUri(Uri.parse(ApiConstants.NFC_URL+id!)),
        ]);
        await tech.write(message);

      }on PlatformException catch (e) {
        throw(e.message ?? 'Some error has occurred.');
      }

    return '[Ndef - Write] is completed.';
  }

  Future<String> cleardata(NfcTag tag,BuildContext context) async{
    final tech = Ndef.from(tag);


    if (tech == null)
      throw('Tag is not ndef.');

    if (!tech.isWritable)
      throw('Tag is not ndef writable.');

    try {
      final message = NdefMessage(
          [
            NdefRecord.createText(''),
          ]);
      await tech.write(message);
      Navigator.of(context).pop();

    }on PlatformException catch (e) {
      throw(e.message ?? 'Some error has occurred.');
    }
    return '[Ndef - Tag] is clear.';
  }

}



