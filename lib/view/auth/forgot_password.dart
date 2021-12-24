import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:meetapp/constants/color_constants.dart';
import 'package:meetapp/constants/decoration.dart';
import 'package:meetapp/constants/image_constants.dart';
import 'package:meetapp/constants/route_constants.dart';
import 'package:meetapp/constants/validations.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/helper/keyboard_helper.dart';
import 'package:meetapp/provider/forgot_provider.dart';
import 'package:meetapp/provider/login_provider.dart';
import 'package:meetapp/view/base_view.dart';
import 'package:meetapp/extensions/allExtensions.dart';
import 'package:meetapp/widgets/roundCornerShape.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  ScreenScaler? scaler;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _passwordVisible = false;
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
            body: BaseView<ForgotProvider>(
                onModelReady: (provider) {},
                builder: (context, provider, _) {
                  return SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Container(
                        color: ColorConstants.colorbackground,
                        width: MediaQuery.of(context).size.width,
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
                              height: scaler!.getHeight(8.3),
                            ),
                            Image.asset(
                              ImageConstants.ic_logo,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: scaler!.getPaddingLTRB(0, 2, 0, 0),
                              child: SizedBox(
                                height: scaler!.getHeight(2.48),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: ColorConstants.whiteColor,
                                      border: Border.all(
                                          color: ColorConstants.whiteColor),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: ColorConstants.whiteColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                topLeft: Radius.circular(16))),
                        child: Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: scaler!.getPaddingLTRB(6, 2, 6, 0),
                                    child: Container(
                                      child: TextFormField(
                                        cursorColor:
                                        ColorConstants.colorButtonbgColor,
                                        controller: _emailController,
                                        style: ViewDecoration.textFieldStyle(
                                            scaler!.getTextSize(10)),
                                        decoration: ViewDecoration
                                            .inputDecorationWithCurve(
                                            "Email", scaler!),
                                        textInputAction: TextInputAction.done,
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return 'Empty email';
                                          } else if (!Validations
                                              .emailValidation(value)) {
                                            return 'Invalid email';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            Padding(
                              padding: scaler!.getPaddingLTRB(6, 2, 6, 0),
                              child:provider.state == ViewState.Busy?
                              CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.colorButtonbgColor)

                              ):
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    KeyboardHelper.hideKeyboard(context);
                                    provider
                                        .forgotpassword(
                                        context,
                                        _emailController.text.trim(),




                                    ).then((value) {
                                      if(value){


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
                                                'Submit',
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
                    ]),
                  );
                })));
  }
}
