import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:meetapp/constants/color_constants.dart';

import 'package:meetapp/constants/image_constants.dart';
import 'package:meetapp/provider/contact_detail_provider.dart';
import 'package:meetapp/provider/contacts_provider.dart';

import 'package:meetapp/view/base_view.dart';
import 'package:meetapp/extensions/allExtensions.dart';
import 'package:meetapp/widgets/imagePickerDialog.dart';
import 'package:meetapp/widgets/image_view.dart';
import 'package:meetapp/widgets/roundCornerShape.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uni_links/uni_links.dart';

class ContactDetail extends StatefulWidget {
  @override
  _ContactDetailState createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  ScreenScaler? scaler;
  List<String> writeIcons = [
    ImageConstants.ic_instagram,
    ImageConstants.ic_facebook,
    ImageConstants.ic_twitter,
    ImageConstants.ic_whatsapp,
    ImageConstants.ic_phone,
    ImageConstants.ic_email,
    ImageConstants.ic_snapchat,
    ImageConstants.ic_tiktok,
  ];
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
          backgroundColor: ColorConstants.whiteColor,
          key: _scaffoldKey,
          body: BaseView<ContactDetailProvider>(
            onModelReady: (provider) {

            },
            builder: (context, provider, _) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: ColorConstants.colorbackground,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: scaler!.getPaddingLTRB(2, 1, 0, 0),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_back_outlined,
                                      color: ColorConstants.colorButtonbgColor,
                                      size: 25,
                                    )),
                              ),
                              Spacer(),
                              Padding(
                                padding: scaler!.getPaddingLTRB(0, 1, 3, 0),
                                child: GestureDetector(
                                    onTap: () {
                                      Share.share(
                                          'hey! check out this new app https://play.google.com/store/search?q=pub%3ADivTag&c=apps');
                                    },
                                    child: Icon(
                                      Icons.share,
                                      color: ColorConstants.colorButtonbgColor,
                                      size: 25,
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                overflow: Overflow.visible,
                                children: [
                                  CircleAvatar(
                                      radius: 50,
                                      backgroundColor:
                                          ColorConstants.whiteColor,
                                      child: ImageView(
                                        width: scaler!.getWidth(25),
                                        radius: scaler!.getWidth(14),
                                        height: scaler!.getWidth(25),
                                        circleCrop: true,
                                        path:
                                            ImageConstants.ic_contact_profile1,
                                        fit: BoxFit.cover,
                                      )),
                                ],
                              ),
                            ],
                          ),
                          Text('John Smith').regularText(
                              ColorConstants.colorTextAppBar,
                              scaler!.getTextSize(12)),
                          Text('I am a developer').regularText(
                              ColorConstants.colorTextAppBar,
                              scaler!.getTextSize(11)),
                          Padding(
                            padding: scaler!.getPaddingLTRB(0, 2, 0, 0),
                            child: SizedBox(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorConstants.whiteColor),
                                    color: ColorConstants.whiteColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: Column(
                                  children: [
                                    Padding(
                                        padding:
                                            scaler!.getPaddingLTRB(3, 1, 3, 2),
                                        child: ListView.builder(
                                            physics: ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: writeitems.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Padding(
                                                padding: scaler!.getPaddingLTRB(
                                                    0, 0.5, 0, 0),
                                                child: Container(
                                                  child: RoundCornerShape(
                                                    radius: 4,
                                                    bgColor: ColorConstants
                                                        .colorbackground,
                                                    child: ListTile(
                                                      onTap: () {},
                                                      leading: ImageView(
                                                        path: writeIcons[index],
                                                      ),
                                                      title: Text(
                                                              writeitems[index])
                                                          .menuItemText(
                                                              ColorConstants
                                                                  .colorBlack,
                                                              scaler!
                                                                  .getTextSize(
                                                                      10)),

                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )
      ),
    );
  }


}

//
