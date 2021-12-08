import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:meetapp/constants/api_constants.dart';
import 'package:meetapp/constants/color_constants.dart';

import 'package:meetapp/constants/image_constants.dart';
import 'package:meetapp/enum/viewstate.dart';

import 'package:meetapp/provider/profile_provider.dart';
import 'package:meetapp/view/base_view.dart';
import 'package:meetapp/extensions/allExtensions.dart';
import 'package:meetapp/widgets/image_view.dart';
import 'package:meetapp/widgets/roundCornerShape.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

          body: BaseView<ProfileProvider>(
            onModelReady: (provider) {
              provider.determinePosition(context);

              provider.getProfile(context);



            },
            builder: (context, provider, _) {
              return provider.state == ViewState.Busy
                  ? Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.colorButtonbgColor)
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: scaler!.getHeight(2),
                          ),
                          Padding(
                            padding: scaler!.getPaddingLTRB(3, 0, 3, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: RoundCornerShape(
                                bgColor: ColorConstants.whiteColor,
                                radius: 16,
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),

                                      child: ImageView(
                                        path: ApiConstants.IMAGE_URL +
                                            provider.profile!.data
                                                .profilePic,
                                        height: scaler!.getHeight(28),
                                        width: MediaQuery.of(context).size.width,
                                        radius: 16,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    SizedBox(
                                      height: scaler!.getHeight(1),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(provider.profile!.data.firstName +
                                                ' ' +
                                                provider.profile!.data.lastName)
                                            .appBarText(
                                                ColorConstants.colorwritebutton,
                                                scaler!.getTextSize(11))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Age : ' +
                                                provider.datetime.toString())
                                            .mediumText(
                                                ColorConstants.colorTextAppBar,
                                                scaler!.getTextSize(11),
                                                TextAlign.center)
                                      ],
                                    ),
                                    SizedBox(
                                      height: scaler!.getHeight(1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: scaler!.getHeight(0.4),
                          ),
                          Padding(
                            padding: scaler!.getPaddingLTRB(3, 0, 3, 0),
                            child: Container(
                              padding:
                                  scaler!.getPaddingLTRB(0.5, 0.5, 0.5, 0.5),
                              width: MediaQuery.of(context).size.width,
                              child: RoundCornerShape(
                                  bgColor: ColorConstants.whiteColor,
                                  radius: 16,
                                  child: Padding(
                                    padding:
                                        scaler!.getPaddingLTRB(1.5, 1, 1.5, 1),
                                    child:
                                        Text(provider.profile!.data.description)
                                            .mediumText(
                                                ColorConstants
                                                    .colorprofileTextColor,
                                                scaler!.getTextSize(9.7),
                                                TextAlign.left),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    );
            },
          )),
    );
  }
}

//
