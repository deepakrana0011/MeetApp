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
import 'package:meetapp/provider/login_provider.dart';
import 'package:meetapp/view/base_view.dart';
import 'package:meetapp/extensions/allExtensions.dart';
import 'package:meetapp/widgets/roundCornerShape.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            body: BaseView<LoginProvider>(
                onModelReady: (provider) {

                },
                builder: (context, provider, _) {
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Container(
                          color: ColorConstants.colorbackground,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
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
                                          textInputAction: TextInputAction.next,
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
                                    Padding(
                                      padding: scaler!.getPaddingLTRB(6, 1, 6, 0),
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
                                                  _passwordVisible =
                                                      !_passwordVisible;
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
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: scaler!.getHeight(0.5),
                              ),
                              Padding(
                                padding: scaler!.getPaddingLTRB(0, 0, 7, 0),
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
                                              'Forgot Password?',
                                            ).mediumText(
                                                ColorConstants.colorButtonbgColor,
                                                scaler!.getTextSize(10),
                                                TextAlign.center),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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
                                     provider.login(
                                       context,
                                       _emailController.text.trim(),
                                       _passwordController.text.trim()
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
                                                  'Login',
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
                                height: scaler!.getHeight(1),
                              ),
                              Padding(
                                padding: scaler!.getPaddingLTRB(0, 0.5, 0, 1.5),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(RoutesConstants.signup);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account?",
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
                                              'Sign up',
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
                      ]),
                    ),
                  );
                })));
  }
}
