import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:meetapp/constants/color_constants.dart';
import 'package:meetapp/constants/image_constants.dart';
import 'package:meetapp/extensions/allExtensions.dart';
import 'package:meetapp/provider/write_provider.dart';
import 'package:meetapp/widgets/image_view.dart';

class DialogHelper {
  static final border = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
  );



  static Future showDialogWithTwoButtons(
    BuildContext context,
    String title,
    String positiveButtonText,
    String negativeButtonText,
    String content, {
    required VoidCallback positiveButtonPress,
    required VoidCallback negativeButtonPress,
    barrierDismissible = true,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text(title, textAlign: TextAlign.center),
          content: Text(content),
          shape: border,
          actions: <Widget>[
            FlatButton(
              child: Text(negativeButtonText).mediumText(
                  ColorConstants.colorButtonbgColor, 18, TextAlign.center),
              textColor: Colors.black87,
              onPressed: () {
                if (negativeButtonPress != null) {
                  negativeButtonPress();
                } else {
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
            ),
            FlatButton(
              child: Text(positiveButtonText).mediumText(
                  ColorConstants.colorButtonbgColor, 18, TextAlign.center),
              onPressed: () {
                if (positiveButtonPress != null) {
                  positiveButtonPress();
                } else {
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
            )
          ],
        );
      },
    );
  }


  static Future showDialogWithTwoButtonswithImage(
      BuildContext context,
      String title,
      String positiveButtonText,
      String negativeButtonText,
      ScreenScaler scaler,
      String image,
      TextEditingController link,
       {
        required VoidCallback positiveButtonPress,
        required VoidCallback negativeButtonPress,
        barrierDismissible = true,
      }) {
    return showDialog(

        context: context,
        builder: (context) {
          return AlertDialog(

              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,

                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            topLeft: Radius.circular(16)),
                        color: ColorConstants.whiteColor,
                      ),
                      child: Center(
                          child:  Image.asset(ImageConstants.ic_title_logo,height: 50,)),
                    ),
                    SizedBox(
                      height: scaler.getHeight(0.5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageView(path:
                        image
                        )
                      ],
                    ),
                    SizedBox(
                      height: scaler.getHeight(0.5),
                    ),
                    Padding(
                      padding: scaler.getPaddingLTRB(2, 0, 2, 0),
                      child: TextFormField(

                        validator: (value){
                          if (value!.trim().isEmpty) {
                            return 'Empty field';
                          }

                        },
                        controller: link,

                        style: TextStyle(


                            color: ColorConstants
                                .colorTextLightGray,
                            fontSize:
                            scaler.getTextSize(10),
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,

                        decoration: InputDecoration(

                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorConstants.colorButtonbgColor),
                          ),

                          hintText:  title=='Whatsapp'|| title=='Phone'? 'Enter ' +title +' number':
                          'Enter '+   title +' id',
                          hintStyle: TextStyle(



                              color: ColorConstants
                                  .colorTextLightGray,
                              fontSize:
                              scaler.getTextSize(10),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            shape: border,
            actions: <Widget>[
              FlatButton(
                child: Text(negativeButtonText).mediumText(
                    ColorConstants.colorButtonbgColor, 18, TextAlign.center),
                textColor: Colors.black87,
                onPressed: () {
                  if (negativeButtonPress != null) {
                    negativeButtonPress();
                  } else {
                    Navigator.of(context, rootNavigator: true).pop();
                  }
                },
              ),
             FlatButton(
                child: Text(positiveButtonText).mediumText(
                    ColorConstants.colorButtonbgColor, 18, TextAlign.center),
                onPressed: () {
                  if (positiveButtonPress != null) {
                    positiveButtonPress();
                  } else {
                    Navigator.of(context, rootNavigator: true).pop();
                  }
                },
              )
            ],
          );
        });
  }

  static Future showDialogWithOneButton(
      BuildContext context,
      String title,
      String content, {
        required VoidCallback positiveButtonPress,
        barrierDismissible = true,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text(title, textAlign: TextAlign.center),
          content: Text(content),
          shape: border,
          actions: <Widget>[
            FlatButton(
              child: Text('ok'.toUpperCase()).mediumText(
                  ColorConstants.primaryColor, 18, TextAlign.center),
              onPressed: () {
                if (positiveButtonPress != null) {
                  positiveButtonPress();
                } else {
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
            )
          ],
        );
      },
    );
  }

  static showMessage(BuildContext context, String message) {
    Flushbar(
      message: message,
      backgroundColor: ColorConstants.colorButtonbgColor,
      duration: Duration(seconds: 2),
    )..show(context);
  }
}
