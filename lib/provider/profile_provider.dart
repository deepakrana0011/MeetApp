import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:meetapp/constants/route_constants.dart';
import 'package:meetapp/constants/route_constants.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/helper/location_helper.dart';
import 'package:meetapp/helper/shared_pref.dart';
import 'package:meetapp/locator.dart';
import 'package:meetapp/model/GetProfileResponse.dart';
import 'package:meetapp/provider/base_provider.dart';
import 'package:meetapp/provider/save_token.dart';
import 'package:meetapp/service/FetchDataExpection.dart';

//import 'package:uni_links/uni_links.dart';
//import 'package:uni_links2/uni_links.dart';

class ProfileProvider extends BaseProvider {
  late GetProfileResponse profile;
  List date = [];
  List date2 = [];
  var datetime;
  double? lat;
  double? long;
  Uri? latestLink;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  SaveToken saveToken = locator<SaveToken>();
  late StreamSubscription _sub;
  List taplink = [];

  // DynamicLinksApi dynamicLinksApi = locator<DynamicLinksApi>();

  // ProfileProvider()
  // {
  //   dynamicLinksApi.handleDynamicLink();
  // }

  Future<bool> getProfile(BuildContext context) async {
    setState(ViewState.Busy);
    try {
      var model = await api.getProfileResponse();
      profile = model;
      SharedPref.prefs?.setString(SharedPref.FIRST_NAME, model.data.firstName);

      SharedPref.prefs?.setString(SharedPref.LAST_NAME, model.data.lastName);
      SharedPref.prefs
          ?.setString(SharedPref.profile_pic, model.data.profilePic);
      SharedPref.prefs
          ?.setString(SharedPref.DESCRIPTION, model.data.description);
      SharedPref.prefs?.setString(SharedPref.AGE, model.data.dob);
      SharedPref.prefs?.setString(SharedPref.Email, model.data.email);
      getDateTime(context);

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

  void getDateTime(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    date = formattedDate.split('-');
    date2 = profile.data.dob.split('-');
    datetime = int.parse(date[0]) - int.parse(date2[2]);
  }

  Future<bool> updateLocation(BuildContext context) async {
    try {
      var model = await api.updateLocation(context, lat, long);
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

  Future<void> determinePosition(BuildContext context) async {
    var value = await LocationHelper.getCurrentPosition();
    if (value != null) {
      updateLocation(context);
    }
  }

  void getLngLt(context) {
    Geolocator.getCurrentPosition().then((value) {
      lat = value.latitude;
      long = value.longitude;
      updateLocation(context);
    });
  }

/*Future<void> getLinks(BuildContext context) async {
    _sub = uriLinkStream.listen((event) {
   try {
    taplink= event.toString().split('/');
     if (taplink.isNotEmpty) {

       var tapid = taplink[5];

       WidgetsBinding.instance?.addPostFrameCallback((_) {
         Navigator.of(context)
             .pushNamed(RoutesConstants.deeplink, arguments: tapid);
       });
     }

   }

    on FetchDataException catch (c){
      DialogHelper.showMessage(context, c.toString());

    }

    });
    final initialLink = await getInitialUri();
    try {

      taplink= initialLink.toString().split('/');

      if (taplink.isNotEmpty) {

        var tapid = taplink[5];

        WidgetsBinding.instance?.addPostFrameCallback((_) {
          Navigator.of(context)
              .pushNamed(RoutesConstants.deeplink, arguments: tapid);
        });
      }
    } on Exception {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }*/

}
