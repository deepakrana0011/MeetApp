import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/helper/shared_pref.dart';
import 'package:meetapp/model/GetProfileResponse.dart';
import 'package:meetapp/provider/base_provider.dart';
import 'package:meetapp/service/FetchDataExpection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends BaseProvider{
  late GetProfileResponse profile;
  List date=[];
  List date2=[];
  var datetime;
  double? lat;
  double? long;


  Future<bool> getProfile(BuildContext context) async {


    setState(ViewState.Busy);
    try {
      var model = await api.getProfileResponse();
      profile = model;
      getDateTime(context);

      setState(ViewState.Idle);
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

  void getDateTime(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    date= formattedDate.split('-');
    date2=profile.data.dob.split('-');
   datetime=int.parse(date[0])-int.parse(date2[2]);
   print(datetime);


  }

  Future<bool> updateLocation(BuildContext context) async {
    setState(ViewState.Busy);

    try {
      var model = await api.updateLocation(context, lat, long);
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
      lat=value.latitude;
      long=value.longitude;
     updateLocation(context);
    });
  }

}