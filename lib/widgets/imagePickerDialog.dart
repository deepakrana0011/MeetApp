
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:meetapp/constants/color_constants.dart';
import 'package:meetapp/widgets/roundCornerShape.dart';
import 'package:meetapp/extensions/allExtensions.dart';


class CustomDialog extends StatelessWidget {
  final VoidCallback galleryClick;
  final VoidCallback cameraClick;
  final VoidCallback cancelClick;

  CustomDialog(
      {required this.galleryClick,
      required this.cameraClick,
      required this.cancelClick});

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = new ScreenScaler()..init(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: RoundCornerShape(
        bgColor: Colors.white,
        radius: 16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Ink(
              decoration: BoxDecoration(
                  color: ColorConstants.colorButtonbgColor,
                  shape: BoxShape.rectangle,
                  borderRadius: scaler.getBorderRadiusCircularLR(16, 16, 0, 0)),
              child: Padding(
                padding: scaler.getPaddingAll(10),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Choose from",
                    ).mediumText(ColorConstants.whiteColor,
                        scaler.getTextSize(11), TextAlign.center)),
              ),
            ),
            GestureDetector(
              onTap: galleryClick,
              child: Padding(
                padding: scaler.getPaddingAll(8),
                child: Text("Phone gallery",style: TextStyle(color: ColorConstants.colorButtonbgColor,fontSize: scaler.getTextSize(11)),),

              ),
            ),
            Divider(
              height: 1.0,
              color: Colors.black,
            ),
            GestureDetector(
              onTap: cameraClick,
              child: Padding(
                padding: scaler.getPaddingAll(8),
                child: Text("Camera",style: TextStyle(color: ColorConstants.colorButtonbgColor,fontSize: scaler.getTextSize(11)),),
              ),
            ),
            Divider(
              height: 1.0,
              color: Colors.black,
            ),
            GestureDetector(
              onTap: cancelClick,
              child: Padding(
                padding: scaler.getPaddingAll(8),
                child: Text("Cancel",style: TextStyle(color: ColorConstants.colorButtonbgColor,fontSize: scaler.getTextSize(11)),
              ),
            ),
            )],
        ),
      ),
    );
  }
}
