
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:meetapp/constants/api_constants.dart';
import 'package:meetapp/constants/color_constants.dart';
import 'package:meetapp/constants/decoration.dart';
import 'package:meetapp/constants/validations.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/helper/keyboard_helper.dart';
import 'package:meetapp/provider/EditProfileProvider.dart';
import 'package:meetapp/view/base_view.dart';
import 'package:meetapp/extensions/allExtensions.dart';
import 'package:meetapp/widgets/imagePickerDialog.dart';
import 'package:meetapp/widgets/image_view.dart';
import 'package:meetapp/widgets/roundCornerShape.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ScreenScaler? scaler;
  final _formKey = GlobalKey<FormState>();


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
          body: BaseView<EditProfileProvider>(
            onModelReady: (provider) {
              provider.getUserInfo(context);
            },
            builder: (context, provider, _) {
              return
                SingleChildScrollView(
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
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Icon(Icons.arrow_back_outlined,color: ColorConstants.colorButtonbgColor,size: 25,)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: scaler!.getHeight(2),
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

                                      child:
                                      provider.file.contains('static')?ImageView(
                                        width: scaler!.getWidth(25),
                                        radius: scaler!.getWidth(14),
                                        height: scaler!.getWidth(25),
                                        circleCrop: true,
                                        path: ApiConstants.IMAGE_URL+provider.file,fit: BoxFit.cover,
                                      ):
                                      ImageView(
                                        width: scaler!.getWidth(25),
                                        radius: scaler!.getWidth(14),
                                        height: scaler!.getWidth(25),
                                        circleCrop: true,
                                        path: provider.file,fit: BoxFit.cover,
                                      )
                                  )
                                  ,
                                  Positioned(
                                      top: 60,
                                      left: 80,
                                      child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                context) =>
                                                    CustomDialog(
                                                      cameraClick: () {
                                                        provider.getImage(
                                                            context, 1);
                                                      },
                                                      galleryClick: () {
                                                        provider.getImage(
                                                            context, 2);
                                                      },
                                                      cancelClick: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ));
                                          },
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: ColorConstants
                                                .colorButtonbgColor,
                                          )))
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: scaler!.getPaddingLTRB(0, 2, 0, 0),
                            child: SizedBox(
                              height: scaler!.getHeight(2),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorConstants.whiteColor),
                                    color: ColorConstants.whiteColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: scaler!.getPaddingLTRB(6, 0.8, 6, 0),
                              child: Container(
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.sentences,
                                  cursorColor:
                                  ColorConstants.colorButtonbgColor,
                                  controller: provider.fnamecontroller,
                                  style: ViewDecoration.textFieldStyle(
                                      scaler!.getTextSize(10)),
                                  decoration:

                                  ViewDecoration.inputDecorationWithCurve(
                                      "First Name", scaler!),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return 'Empty name';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: scaler!.getPaddingLTRB(6, 0.8, 6, 0),
                              child: Container(
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.sentences,
                                  cursorColor:
                                  ColorConstants.colorButtonbgColor,
                                  controller: provider.lnamecontroller,
                                  style: ViewDecoration.textFieldStyle(
                                      scaler!.getTextSize(10)),
                                  decoration:
                                  ViewDecoration.inputDecorationWithCurve(
                                      "Last Name", scaler!),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return 'Empty Last name';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: scaler!.getPaddingLTRB(6, 0.8, 6, 0),
                              child: Container(
                                child: TextFormField(
                                  onTap: () {
                                    provider.selectAge(context);
                                  },
                                  readOnly: true,
                                  controller: provider.datetime,
                                  style: ViewDecoration.textFieldStyle(
                                      scaler!.getTextSize(10)),
                                  decoration: ViewDecoration
                                      .inputDecorationWithCurveandColorForage(
                                      "Age", scaler!),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return 'Empty age';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: scaler!.getPaddingLTRB(6, 0.8, 6, 0),
                              child: Container(
                                child: TextFormField(
                                  cursorColor:
                                  ColorConstants.colorButtonbgColor,
                                  maxLines: 5,
                                  controller: provider.desccontroller,
                                  style: ViewDecoration.textFieldStyle(
                                      scaler!.getTextSize(10)),
                                  decoration:
                                  ViewDecoration.inputDecorationWithCurve(
                                      "Description", scaler!),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return 'Empty description';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: scaler!.getPaddingLTRB(6, 0.8, 6, 0),
                              child: Container(
                                child: TextFormField(
                                  readOnly: true,
                                  cursorColor:
                                  ColorConstants.colorButtonbgColor,
                                  controller: provider.emailController,
                                  style: ViewDecoration.textFieldStyle(
                                      scaler!.getTextSize(10)),
                                  decoration:
                                  ViewDecoration.inputDecorationWithCurve(
                                      "Email", scaler!),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return 'Empty email';
                                    } else if (!Validations.emailValidation(
                                        value)) {
                                      return 'Invalid email';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),

                            provider.state == ViewState.Busy
                                ? Padding(
                              padding: scaler!.getPaddingLTRB(0, 1.5, 0, 0),
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.colorButtonbgColor)
                              ),
                            ):  Padding(
                              padding: scaler!.getPaddingLTRB(6, 1.5, 6, 0),
                              child: GestureDetector(
                                onTap: () async {

                                  if (_formKey.currentState!.validate()) {
                                    KeyboardHelper.hideKeyboard(context);
                                    provider
                                        .update(
                                        context,
                                       provider.fnamecontroller.text.trim(),
                                        provider.lnamecontroller.text.trim(),
                                        provider.datetime.text.trim(),
                                        provider.desccontroller.text.trim(),
                                        provider.emailController.text.trim(),
                                        provider.file,




                                    ).then((value) {
                                      if(value){

                                        Navigator.pushNamedAndRemoveUntil(context, "dashboard", (Route<dynamic> route) => false);
                                        DialogHelper.showMessage(context, "Updated successfully");

                                      }


                                    });
                                  }

                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: scaler!.getHeight(4),
                                  child: RoundCornerShape(
                                    bgColor: ColorConstants.colorButtonbgColor,
                                    radius: 8,
                                    child: Padding(
                                      padding:
                                      scaler!.getPaddingLTRB(0, 0, 0, 0),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: scaler!
                                                  .getPaddingLTRB(0.5, 0, 0, 0),
                                              child: Text(
                                                'Update',
                                              ).buttonText(
                                                  ColorConstants.whiteColor,
                                                  scaler!.getTextSize(11),
                                                  TextAlign.center),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
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
