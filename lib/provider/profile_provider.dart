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
import 'package:meetapp/helper/shared_pref.dart';
import 'package:meetapp/locator.dart';
import 'package:meetapp/model/GetProfileResponse.dart';
import 'package:meetapp/provider/base_provider.dart';
import 'package:meetapp/provider/save_token.dart';
import 'package:meetapp/service/FetchDataExpection.dart';


//import 'package:uni_links/uni_links.dart';
import 'package:uni_links2/uni_links.dart';

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

  Future<Position> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    getLngLt(context);

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void getLngLt(context) {
    Geolocator.getCurrentPosition().then((value) {
      lat = value.latitude;
      long = value.longitude;
      updateLocation(context);
    });
  }

  Future<void> getLinks(BuildContext context) async {
    _sub = uriLinkStream.listen((event) {
   try{
  final List link = event.toString().split('/');
  var tapid = link[5];

  WidgetsBinding.instance?.addPostFrameCallback((_) {
    Navigator.of(context)
        .pushNamed(RoutesConstants.deeplink, arguments: tapid);
  });
    }
    on FetchDataException catch (c){
      DialogHelper.showMessage(context, c.toString());

    }

    });

    try {
      final initialLink = await getInitialUri();
      final link = initialLink.toString().split('/');

      var tapid = link[5];

      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context)
            .pushNamed(RoutesConstants.deeplink, arguments: tapid);
      });
    } on Exception {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }


}
