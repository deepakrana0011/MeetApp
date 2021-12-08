import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meetapp/constants/image_constants.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/helper/shared_pref.dart';
import 'package:meetapp/model/GetLocationResponse.dart';
import 'package:meetapp/provider/base_provider.dart';
import 'package:meetapp/service/FetchDataExpection.dart';

class MapsProvider extends BaseProvider {
  List<Datum> locations = [];
  List<Marker> markers = [];
  List latitudes = [];
  List longitudes = [];
  double lat = 0.11;
  double long = 0.23;
  BitmapDescriptor? myIcon;

  void getLngLt(context) {

    setState(ViewState.Busy);
    Geolocator.getCurrentPosition().then((value) {
      lat = value.latitude;
      long = value.longitude;
      print(long);
      setState(ViewState.Idle);
    });
  }

  Future<bool> getLocations(BuildContext context) async {
    print(SharedPref.prefs?.getString(SharedPref.USER_ID));
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(100, 100)),
        'images/ic_map.png')
        .then((d) {
      myIcon = d;
    });

    setState(ViewState.Busy);
    try {
      var model = await api.getLocationResponse();
      locations = model.data;
      for(var i=0;i<locations.length;i++){
        markers.add(Marker(markerId: MarkerId(i.toString()),position: LatLng(locations[i].latitude,locations[i].longitude),
          visible: true,
          icon: locations[i].id!= SharedPref.prefs?.getString(SharedPref.USER_ID)? myIcon as BitmapDescriptor:
          BitmapDescriptor.defaultMarker,
        ),
        );
      }

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













  void onMapCreated(GoogleMapController controller) {


    markers.add(Marker(markerId: MarkerId("id-1"),position: LatLng(30.7089889,76.6837099),


      visible: true,
      icon: BitmapDescriptor.defaultMarker,
    ),


    );

  }
}