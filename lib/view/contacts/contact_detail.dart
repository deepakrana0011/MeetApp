import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:mailto/mailto.dart';
import 'package:meetapp/constants/api_constants.dart';
import 'package:meetapp/constants/color_constants.dart';

import 'package:meetapp/constants/image_constants.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/helper/shared_pref.dart';
import 'package:meetapp/locator.dart';
import 'package:meetapp/provider/ShareLink.dart';
import 'package:meetapp/provider/contact_detail_provider.dart';
import 'package:meetapp/provider/contacts_provider.dart';

import 'package:meetapp/view/base_view.dart';
import 'package:meetapp/extensions/allExtensions.dart';
import 'package:meetapp/widgets/imagePickerDialog.dart';
import 'package:meetapp/widgets/image_view.dart';
import 'package:meetapp/widgets/roundCornerShape.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../dynamic_links_api.dart';

class ContactDetail extends StatefulWidget {
  final tapid;

  const ContactDetail({Key? key, this.tapid}) : super(key: key);

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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ShareLink shareLink = locator<ShareLink>();

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
              if (SharedPref.prefs?.getString(SharedPref.USER_ID) !=
                  widget.tapid) {
                provider.saveTapUser(context, widget.tapid);
              }
              provider.getUserDetail(context, widget.tapid);
            },
            builder: (context, provider, _) {
              return provider.state == ViewState.Busy
                  ? Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              ColorConstants.colorButtonbgColor)),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            color: ColorConstants.colorbackground,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          scaler!.getPaddingLTRB(2, 1, 0, 0),
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Icon(
                                            Icons.arrow_back_outlined,
                                            color: ColorConstants
                                                .colorButtonbgColor,
                                            size: 25,
                                          )),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding:
                                          scaler!.getPaddingLTRB(0, 1, 3, 0),
                                      child: GestureDetector(
                                          onTap: () async {
                                            Share.share(ApiConstants.NFC_URL +
                                                widget.tapid);
                                          },
                                          child: Icon(
                                            Icons.share,
                                            color: ColorConstants
                                                .colorButtonbgColor,
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
                                              path: ApiConstants.IMAGE_URL +
                                                  provider.profilepic,
                                              fit: BoxFit.cover,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(provider.username).regularText(
                                    ColorConstants.colorTextAppBar,
                                    scaler!.getTextSize(12)),
                                Text(provider.description).regularText(
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
                                              padding: scaler!
                                                  .getPaddingLTRB(3, 1, 3, 2),
                                              child: ListView.builder(
                                                  physics:
                                                      ClampingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      provider.userlinks.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Padding(
                                                      padding: scaler!
                                                          .getPaddingLTRB(
                                                              0, 0.5, 0, 0),
                                                      child: Container(
                                                        child: RoundCornerShape(
                                                          radius: 4,
                                                          bgColor: ColorConstants
                                                              .colorbackground,
                                                          child: ListTile(
                                                            onTap: () {
                                                              provider.launchLink(
                                                                  provider.userlinktype[
                                                                      index],
                                                                  provider.links[
                                                                      index]);
                                                            },
                                                            leading: ImageView(
                                                                path: provider.userlinktype[
                                                                            index] ==
                                                                        'Instagram'
                                                                    ? ImageConstants
                                                                        .ic_instagram
                                                                    : provider.userlinktype[index] ==
                                                                            'Facebook'
                                                                        ? ImageConstants
                                                                            .ic_facebook
                                                                        : provider.userlinktype[index] ==
                                                                                'Twitter'
                                                                            ? ImageConstants.ic_twitter
                                                                            : provider.userlinktype[index] == 'Whatsapp'
                                                                                ? ImageConstants.ic_whatsapp
                                                                                : provider.userlinktype[index] == 'Phone'
                                                                                    ? ImageConstants.ic_phone
                                                                                    : provider.userlinktype[index] == 'Email'
                                                                                        ? ImageConstants.ic_email
                                                                                        : provider.userlinktype[index] == 'Snapchat'
                                                                                            ? ImageConstants.ic_snapchat
                                                                                            : ImageConstants.ic_tiktok),
                                                            title: Text(
                                                                    provider.userlinktype[
                                                                        index])
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
                                                  })),
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
          )),
    );
  }
}

//
