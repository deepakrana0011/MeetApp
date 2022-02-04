/*
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:meetapp/constants/route_constants.dart';
import 'package:meetapp/locator.dart';
import 'package:meetapp/provider/ShareLink.dart';

import 'constants/api_constants.dart';
import 'helper/shared_pref.dart';

class DynamicLinksApi {
  var dynamicUrl ;
  final dynamicLinks = FirebaseDynamicLinks.instance;
  ShareLink shareLink= locator<ShareLink>();

  handleDynamicLink(BuildContext context) async {
    if (SharedPref.prefs?.getString(SharedPref.TOKEN) != null) {
      await dynamicLinks.getInitialLink();

      // this is background/foreground
      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
        final link = dynamicLinkData.link.toString().split('/');
        var tapid = link[5];
        print(tapid);
        // SharedPref.prefs?.getString(SharedPref.TOKEN) == null?
        // Navigator.pushNamedAndRemoveUntil(context, "login", (Route<dynamic> route) => false):
        Navigator.of(context)
            .pushNamed(RoutesConstants.deeplink, arguments: tapid);
      }).onError((error) {
        // Handle errors
      });

// this is for terminated state
      PendingDynamicLinkData? data = await dynamicLinks.getInitialLink();
      try {
        if (data != null) {
          final Uri deepLink = data.link;
          final link = deepLink.toString().split('/');
          var tapid = link[5];
          // if(SharedPref.prefs?.getString(SharedPref.TOKEN) == null){
          //   Navigator.pushNamedAndRemoveUntil(context, "login", (Route<dynamic> route) => false);
          // } else{
          Navigator.of(context)
              .pushNamed(RoutesConstants.deeplink, arguments: tapid);
          //  }
        }
      } catch (e) {
        print('No deepLink found');
      }
    } else {
      await dynamicLinks.getInitialLink();

      // this is background/foreground
      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
        final link = dynamicLinkData.link.toString().split('/');
        var tapid = link[5];
        print(tapid);
        Navigator.pushNamedAndRemoveUntil(
            context, "login", (Route<dynamic> route) => false);
      }).onError((error) {
        // Handle errors
      });
    }
  }

  Future<Uri> createDynamicLink(id) async {

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://meettheringapp.page.link/',
      link: Uri.parse(ApiConstants.NFC_URL + id),
      androidParameters: AndroidParameters(
        packageName: 'com.meetmeyou.meetmeyou',
        minimumVersion: 1,
      ),
      */
/*iosParameters: IosParameters(
        bundleId: 'your_ios_bundle_identifier',
        minimumVersion: '1',
        appStoreId: 'your_app_store_id',
      ),*//*

    );
  dynamicUrl=  await dynamicLinks.buildLink(parameters);
  shareLink.link=dynamicUrl;
    print(dynamicUrl);
    return dynamicUrl;
  }

  void handleSuccessLinking(PendingDynamicLinkData data, context) {
    final Uri deepLink = data.link;

    if (deepLink != null) {
      var isRefer = deepLink.pathSegments.contains('refer');
      if (isRefer) {
        var code = deepLink.queryParameters['code'];
        print(code.toString());
        if (code != null) {
          final link = data.link.toString().split('/');
          var tapid = link[5];
          print(tapid);

          Navigator.of(context)
              .pushNamed(RoutesConstants.deeplink, arguments: tapid);
        }
      }
    }
  }
}
*/
