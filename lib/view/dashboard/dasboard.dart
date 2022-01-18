import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:meetapp/constants/color_constants.dart';
import 'package:meetapp/constants/image_constants.dart';
import 'package:meetapp/constants/route_constants.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/helper/shared_pref.dart';
import 'package:meetapp/locator.dart';
import 'package:meetapp/provider/dashboard_provider.dart';
import 'package:meetapp/provider/profile_provider.dart';
import 'package:meetapp/provider/save_token.dart';
import 'package:meetapp/view/base_view.dart';
import 'package:meetapp/extensions/allExtensions.dart';
import 'package:meetapp/view/contacts/contacts.dart';
import 'package:meetapp/view/maps/maps.dart';
import 'package:meetapp/view/privacy_policy/privacy_policy.dart';
import 'package:meetapp/view/profile/profile.dart';
import 'package:meetapp/view/write/write.dart';
import 'package:meetapp/widgets/image_view.dart';
import 'package:meetapp/widgets/roundCornerShape.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  SaveToken saveToken= locator<SaveToken>();
  ScreenScaler? scaler;
  int currentPosition = 0;
  List<String> menuitems = [
    'Profile',
    'Write',
    'Maps',
    'Contacts',
    'Privacy Policy',
    'Website',
    'SignOut'
  ];
  List<String> menuIcons = [
    ImageConstants.ic_profile_logo,
    ImageConstants.ic_write_logo,
    ImageConstants.ic_maps_logo,
    ImageConstants.ic_contacts,
    ImageConstants.ic_privacy,
    ImageConstants.ic_website,
    ImageConstants.ic_logout

  ];
  final List<Widget> _children = [
    Profile(),
    //NotificationPage(),
    Write(),
    Maps(),
    Contacts(),
    PrivacyPolicy(
      privacypolicy: false,
    )

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(
          ),
        ),
      ],
      child: Scaffold(
          backgroundColor: ColorConstants.colorbackground,
          key: _scaffoldKey,
          appBar: AppBar(


            backgroundColor: ColorConstants.whiteColor,
            title: Text(menuitems[currentPosition]).appBarText(
                ColorConstants.colorTextAppBar,
                scaler!.getTextSize(11),
                ),
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: ColorConstants.colorTextAppBar,
              ),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
            actions: [
              menuitems[currentPosition]=='Profile'?Padding(
                padding: scaler!.getPaddingLTRB(0, 0, 3, 0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context)
                        .pushNamed(RoutesConstants.editProfile);
                  },
                    child: Icon(Icons.edit,color: ColorConstants.colorTextAppBar,)),
              ):
                  SizedBox()
            ],
            centerTitle: true,
          ),
          drawer: _buildDrawer(scaler!),
          body: _children[currentPosition],
        ),
    );
  }
  _buildDrawer(ScreenScaler scaler) {
    return Consumer<ProfileProvider>(
      builder: (c, provider, _) => Drawer(
        child: Container(
          width: scaler.getWidth(55),
          color: ColorConstants.colorWhitishGray,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Padding(
              padding: scaler.getPaddingLTRB(2, 2, 1, 2),
              child: Column(
                children: <Widget>[
                  ImageView(
                    path: ImageConstants.ic_logo,
                    width: scaler.getWidth(25),
                    height: scaler.getWidth(20),
                    radius: scaler.getWidth(10),

                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: scaler.getHeight(1),
                  ),

                  SizedBox(
                    height: scaler.getHeight(2),
                  ),
                  ListView.builder(
                    itemBuilder: (context, position) {
                      return GestureDetector(
                        onTap: () {
                          if (position == 6) {
                            DialogHelper.showDialogWithTwoButtons(context, 'Signout', 'Yes', 'Cancel', 'Are you sure you want to signout?',
                                positiveButtonPress: (){
                                  _signOut();
                                }, negativeButtonPress: () {
                                  Navigator.pop(context);
                                });
                          }
                          else if(position ==5){
                            Navigator.pop(context);
                          }
                          else {
                            Navigator.pop(context);
                            setState(() {
                              currentPosition = position;
                            });
                          }
                        },
                        child: _buildRow(scaler, menuitems[position],
                            menuIcons[position]),
                      );
                    },
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: menuIcons.length,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildRow(ScreenScaler scaler, String title, String imagePath,
      {bool showBadge = false}) {
    return Padding(
      padding: scaler.getPaddingLTRB(0, 0.1, 0, 0.1),
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: scaler.getPaddingLTRB(2, 1, 2, 0),
          child: Row(children: [
           imagePath==ImageConstants.ic_logout? ImageView(
              path: imagePath,
              height: scaler.getHeight(2.0),
              width: scaler.getWidth(2),
             color: ColorConstants.colorButtonbgColor,
            ):ImageView(
             path: imagePath,
             height: scaler.getHeight(2.5),
             width: scaler.getWidth(3),
           ),
            SizedBox(
              width: scaler.getWidth(2),
            ),
            Text(title).regularText(
                ColorConstants.colorTextAppBar, scaler.getTextSize(11)),
          ]),
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    SharedPref.clearSharePref();

    Navigator.pushNamedAndRemoveUntil(context, "login", (Route<dynamic> route) => false);
    DialogHelper.showMessage(
        context, 'Signout successfully');
  }


}

//
