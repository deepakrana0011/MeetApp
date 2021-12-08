import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meetapp/constants/color_constants.dart';
import 'package:meetapp/constants/image_constants.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/provider/maps_provider.dart';
import 'package:meetapp/provider/write_provider.dart';
import 'package:meetapp/view/base_view.dart';
import 'package:meetapp/extensions/allExtensions.dart';
import 'package:meetapp/widgets/image_view.dart';
import 'package:meetapp/widgets/roundCornerShape.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  ScreenScaler? scaler;












  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    if (scaler == null) {
      scaler = new ScreenScaler()..init(context);
    }
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConstants.colorbackground,
          key: _scaffoldKey,

          body: BaseView<MapsProvider>(
            onModelReady: (provider) {
              provider.getLngLt(context);
              provider.getLocations(context);
            },
            builder: (context, provider, _) {
              return provider.state == ViewState.Busy
                  ? Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.colorButtonbgColor)
                ),
              ):GoogleMap(
                mapType: MapType.normal,
                  mapToolbarEnabled: false,


                  markers: Set<Marker>.of(provider.markers),
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(provider.lat,provider.long),
                    zoom: 20,
                  ));
            },
          )),
    );
  }


}

//
