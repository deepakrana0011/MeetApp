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
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/helper/keyboard_helper.dart';
import 'package:meetapp/provider/login_provider.dart';
import 'package:meetapp/provider/verification_provider.dart';
import 'package:meetapp/view/base_view.dart';
import 'package:meetapp/extensions/allExtensions.dart';
import 'package:meetapp/widgets/roundCornerShape.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  ScreenScaler? scaler;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final codecontrolller = TextEditingController();
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
            body: BaseView<VerificationProvider>(
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
                            Text('Enter your verification code here').regularText(ColorConstants.colorTextAppBar, scaler!.getTextSize(11)),
                            Padding(
                              padding: scaler!.getPaddingLTRB(6, 3, 6, 0),
                              child: Container(
                                child: TextFormField(

                                  cursorColor:
                                  ColorConstants.colorButtonbgColor,
                                  controller: codecontrolller,
                                  style: ViewDecoration.textFieldStyle(
                                      scaler!.getTextSize(10)),
                                  obscureText: !_passwordVisible,
                                  decoration: ViewDecoration
                                      .inputDecorationWithCurveandColor(
                                    "Enter your verification code",
                                    scaler!,

                                  ),
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.number,

                                ),
                              ),
                            ),
                            Padding(
                              padding: scaler!.getPaddingLTRB(0, 1, 7, 0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(RoutesConstants.forgot);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    Padding(
                                      padding:
                                      scaler!.getPaddingLTRB(0, 0, 0, 0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Send again the code ',
                                          ).regularText(
                                              ColorConstants.colorverificationresendText,
                                              scaler!.getTextSize(10),
                                            decoration: TextDecoration.underline
                                              ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //Spacer(),
                            Padding(
                              padding: scaler!.getPaddingLTRB(6, 12, 6, 0),
                              child:
                              GestureDetector(
                                onTap: () {
                                  if(codecontrolller.text==''){
                                    DialogHelper.showMessage(context, 'Please enter verification code');
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
                                                'Verify',
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
