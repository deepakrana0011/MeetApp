
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meetapp/constants/color_constants.dart';
import 'package:meetapp/constants/decoration.dart';
import 'package:meetapp/constants/route_constants.dart';
import 'package:meetapp/constants/validations.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/helper/keyboard_helper.dart';
import 'package:meetapp/provider/sign_up_provider.dart';
import 'package:meetapp/view/base_view.dart';
import 'package:meetapp/extensions/allExtensions.dart';
import 'package:meetapp/widgets/imagePickerDialog.dart';
import 'package:meetapp/widgets/image_view.dart';
import 'package:meetapp/widgets/roundCornerShape.dart';
import 'package:permission_handler/permission_handler.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  ScreenScaler? scaler;
  final _formKey = GlobalKey<FormState>();
  final fnamecontroller = TextEditingController();
  final lnamecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final desccontroller = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _passwordVisible = false;
  bool checkboxValue =false;
  bool privacypolicy=true;


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
          body: BaseView<SignUpProvider>(
            onModelReady: (provider) {
              provider.determinePosition(context);
            },
            builder: (context, provider, _) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: ColorConstants.colorbackground,
                      child: Column(
                        children: [
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
                             provider.file==''?     CircleAvatar(
                                      radius: 50,
                                      backgroundColor:
                                          ColorConstants.whiteColor,
                                      child: Icon(
                                        Icons.person,
                                        size: 80,
                                        color: ColorConstants.colorTextAppBar,
                                      )):
                             CircleAvatar(
                                 radius: 50,
                                 backgroundColor:
                                 ColorConstants.whiteColor,

                                 child: ImageView(
                                   width: scaler!.getWidth(25),
                                   radius: scaler!.getWidth(14),
                                   height: scaler!.getWidth(25),
                                   circleCrop: true,
                                 path: provider.file,fit: BoxFit.cover,
                                 ))
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
                              padding: scaler!.getPaddingLTRB(6, 0, 6, 0),
                              child: Container(
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.sentences,
                                  cursorColor:
                                  ColorConstants.colorButtonbgColor,
                                  controller: fnamecontroller,
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
                                  controller: lnamecontroller,
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
                                  maxLines: 4,
                                  controller: desccontroller,
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
                                  cursorColor:
                                      ColorConstants.colorButtonbgColor,
                                  controller: _emailController,
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
                            Padding(
                              padding: scaler!.getPaddingLTRB(6, 0.8, 6, 0),
                              child: Container(
                                child: TextFormField(
                                  cursorColor:
                                      ColorConstants.colorButtonbgColor,
                                  controller: _passwordController,
                                  style: ViewDecoration.textFieldStyle(
                                      scaler!.getTextSize(10)),
                                  obscureText: !_passwordVisible,
                                  decoration: ViewDecoration
                                      .inputDecorationWithCurveandColor(
                                    "Password",
                                    scaler!,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Color(0xff828282),
                                        size: 15,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return 'Empty password';
                                    } else if (value.length < 6) {
                                      return 'Enter a password with length at least 6 letters';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                        CheckboxListTile(
                          value: checkboxValue,

                          title: Transform.translate(
                            offset: const Offset(-15, 0),
                            child: Wrap(
                              children: [
                                new Text(
                                  'I agree to terms and conditions and ',
                                  
                                ).regularText(ColorConstants.colorTextAppBar, scaler!.getTextSize(9)),
                                 GestureDetector(
                                   onTap: (){
                                     Navigator.of(context).pushNamed(RoutesConstants.privacypolicy,
                                     arguments: privacypolicy);

                                   },
                                   child: Text(
                                     'Privacy & Policy',

                                   ).mediumText(ColorConstants.colorButtonbgColor, scaler!.getTextSize(9),TextAlign.left),
                                 )

                              ],
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: ColorConstants.colorButtonbgColor, onChanged: (bool? value) {
                          setState(() {
                            checkboxValue = value!;
                          });
                        },
                        ),
                            provider.state == ViewState.Busy
                                ? Padding(
                                  padding: scaler!.getPaddingLTRB(0, 0, 0, 0),
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.colorButtonbgColor)
                                  ),
                                ):  Padding(
                              padding: scaler!.getPaddingLTRB(6, 0, 6, 0),
                              child: GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).pushNamed(RoutesConstants.verification,
                                      );
                                 /* if(provider.file==''){
                                    DialogHelper.showMessage(context, 'Please select profile image');

                                  }
                                  else if(provider.status!=PermissionStatus.granted){

                                   provider.determinePosition(context);

                                  }
                                  else if(checkboxValue==false){
                                    DialogHelper.showMessage(context, 'Please agree to terms and conditions');
                                  }


                                  else if (_formKey.currentState!.validate()) {
                                    KeyboardHelper.hideKeyboard(context);
                                    provider
                                        .signup(
                                        context,
                                        fnamecontroller.text.trim(),
                                        lnamecontroller.text.trim(),
                                        provider.datetime.text.trim(),
                                        desccontroller.text.trim(),
                                        _emailController.text.trim(),
                                        _passwordController.text.trim(),
                                      provider.file,
                                      provider.lat,
                                      provider.long



                                    ).then((value) {
                                     if(value){
                                       DialogHelper.showMessage(context, "Registration successfully");
                                       Navigator.pushNamedAndRemoveUntil(context, "dashboard", (Route<dynamic> route) => false);

                                     }


                                    });
                                  }*/
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
                                                'SignUp',
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
                            SizedBox(
                              height: scaler!.getHeight(1.2),
                            ),
                            Padding(
                              padding: scaler!.getPaddingLTRB(0, 0, 0, 1.5),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(context, "login", (Route<dynamic> route) => false);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account?",
                                    ).mediumText(
                                        ColorConstants.colorTextAppBar,
                                        scaler!.getTextSize(11),
                                        TextAlign.center),
                                    Padding(
                                      padding:
                                          scaler!.getPaddingLTRB(0.5, 0, 0, 0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Login',
                                          ).mediumText(
                                              ColorConstants.colorButtonbgColor,
                                              scaler!.getTextSize(11.2),
                                              TextAlign.center),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
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
