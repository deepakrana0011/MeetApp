import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:meetapp/constants/color_constants.dart';

import 'package:meetapp/constants/image_constants.dart';
import 'package:meetapp/constants/route_constants.dart';
import 'package:meetapp/provider/contacts_provider.dart';

import 'package:meetapp/view/base_view.dart';
import 'package:meetapp/extensions/allExtensions.dart';
import 'package:meetapp/widgets/image_view.dart';
import 'package:meetapp/widgets/roundCornerShape.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  ScreenScaler? scaler;
  List<String> contacts = [
    ImageConstants.ic_contact_profile2,
    ImageConstants.ic_contact_profile1,
    ImageConstants.ic_contact_profile,
    ImageConstants.ic_contact_profile3,
    ImageConstants.ic_contact_profile4,
    ImageConstants.ic_contact_profile5,
    ImageConstants.ic_contact_profile6,
    ImageConstants.ic_contact_profile7
  ];

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
          body: BaseView<ContactsProvider>(
            onModelReady: (provider) {},
            builder: (context, provider, _) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: scaler!.getPaddingLTRB(3, 2, 3, 2),
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        physics: const ClampingScrollPhysics(),
                        mainAxisSpacing: 12,
                        shrinkWrap: true,
                        children: List.generate(
                          contacts.length,
                          (index) {
                            return GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushNamed(RoutesConstants.ContactDetail,
                                );
                              },
                              child: RoundCornerShape(
                                  bgColor: ColorConstants.whiteColor,
                                  radius: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        child: ImageView(
                                          path: contacts[index],
                                          height: scaler!.getHeight(9.2),
                                          width:
                                          MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: scaler!.getHeight(0.4),
                                      ),
                                      Padding(
                                          padding: scaler!
                                              .getPaddingLTRB(1.5, 0, 0, 0),
                                          child: Text('John Smith').mediumText(
                                              ColorConstants.colorTextAppBar,
                                              scaler!.getTextSize(9.5),
                                              TextAlign.left)
                                      ),
                                      Spacer(),
                                      Container(
                                          height: scaler!.getHeight(2.7),
                                          width:
                                          MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                Radius.circular(10)),
                                            color: ColorConstants
                                                .colorButtonbgColor,
                                          ),
                                          child: Padding(
                                            padding: scaler!
                                                .getPaddingLTRB(0, 0, 0, 0),
                                            child: Text('Open').regularText(
                                                ColorConstants.whiteColor,
                                                scaler!.getTextSize(10),
                                                textAlign: TextAlign.center),
                                          )
                                      )
                                    ],
                                  )),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}

//
