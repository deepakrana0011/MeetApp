import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:meetapp/constants/color_constants.dart';
import 'package:meetapp/constants/image_constants.dart';
import 'package:meetapp/extensions/allExtensions.dart';
import 'package:meetapp/widgets/image_view.dart';
import 'package:nfc_manager/nfc_manager.dart';



Future<void> startSession({
  required BuildContext context,
  required Future<String?> Function(NfcTag) handleTag,
  ScreenScaler? scaler,
  String alertMessage = 'Hold your device near the item.',
}) async {
  if (!(await NfcManager.instance.isAvailable()))
    return showDialog(
      context: context,
      builder: (context) => _UnavailableDialog(),
    );

  if (Platform.isAndroid)
    return showDialog(
      context: context,
      builder: (context) => _AndroidSessionDialog(alertMessage, handleTag),
    );

  if (Platform.isIOS)
    return NfcManager.instance.startSession(
      alertMessage: alertMessage,
      onDiscovered: (tag) async {
        try {
          final result = await handleTag(tag);
          if (result == null) return;
          await NfcManager.instance.stopSession(alertMessage: result);
        } catch (e) {
          await NfcManager.instance.stopSession(errorMessage: '$e');
        }
      },
    );

  throw('unsupported platform: ${Platform.operatingSystem}');
}

class _UnavailableDialog extends StatelessWidget {



  ScreenScaler? scaler;




  @override
  Widget build(BuildContext context) {
    if (scaler == null) {
      scaler = new ScreenScaler()..init(context);
    }
    return  AlertDialog(

      buttonPadding: EdgeInsets.zero,

      titlePadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,

      title: Container(
        height: 50,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16)
            ),
            color: ColorConstants.colorButtonbgColor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error',
            ).mediumText(ColorConstants.whiteColor, scaler!.getTextSize(11),TextAlign.center)
          ],
        ),

      ),

      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Column(
          children: [

            SizedBox(
              height: scaler!.getHeight(0.5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageView(path:
                ImageConstants.ic_alert
                )
              ],
            ),
            SizedBox(
              height: scaler!.getHeight(0.5),
            ),
            Padding(
                padding: scaler!.getPaddingLTRB(2, 0, 2, 0),
                child: Text(
                  'NFC may not be supported or may be temporarily turned off.'
                ).appBarText(ColorConstants.colorTextAppBar, scaler!.getTextSize(10.5))
            ),


          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Container(
            height: 50,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)
                ),
                color: ColorConstants.border
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'GOT IT',
                ).appBarText(ColorConstants.colorTextAppBar, scaler!.getTextSize(11.5))
              ],
            ),
          ),
        )

      ],
    );

  }
}

class _AndroidSessionDialog extends StatefulWidget {
  _AndroidSessionDialog(this.alertMessage, this.handleTag);
  final String alertMessage;
  final Future<String?> Function(NfcTag tag) handleTag;

  @override
  State<StatefulWidget> createState() => _AndroidSessionDialogState();
}

class _AndroidSessionDialogState extends State<_AndroidSessionDialog> {
  String? _alertMessage;

  String? _errorMessage;
  ScreenScaler? scaler;


  @override
  void initState() {
    super.initState();
    NfcManager.instance.startSession(
      onDiscovered: (tag) async {
        try {
          final result = await widget.handleTag(tag);
          if (result == null) return;
          await NfcManager.instance.stopSession();
          setState(() => _alertMessage = result);
        } catch (e) {
          await NfcManager.instance.stopSession().catchError((_) { /* no op */ });
          setState(() => _errorMessage = '$e');
        }
      },
    ).catchError((e) => setState(() => _errorMessage = '$e'));
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession().catchError((_) { /* no op */ });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (scaler == null) {
      scaler = new ScreenScaler()..init(context);
    }
    return  AlertDialog(
      insetPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,

      titlePadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,

      title: Container(
        height: 50,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16)
            ),
            color: ColorConstants.colorButtonbgColor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _errorMessage?.isNotEmpty == true ? 'Error' :
              _alertMessage?.isNotEmpty == true ? 'Success' :
              'Ready to scan',
            ).mediumText(ColorConstants.whiteColor, scaler!.getTextSize(10.5),TextAlign.center)
          ],
        ),

      ),

      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Column(
          children: [

            SizedBox(
              height: scaler!.getHeight(0.5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageView(path:
                ImageConstants.ic_alert
                )
              ],
            ),
            SizedBox(
              height: scaler!.getHeight(0.5),
            ),
            Padding(
                padding: scaler!.getPaddingLTRB(2, 0, 2, 0),
                child: Text(
                  _errorMessage?.isNotEmpty == true ? _errorMessage! :
                  _alertMessage?.isNotEmpty == true ? _alertMessage! :
                  widget.alertMessage,
                ).appBarText(ColorConstants.colorTextAppBar, scaler!.getTextSize(10.5))
            ),


          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Container(
            height: 50,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)
                ),
                color: ColorConstants.border
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _errorMessage?.isNotEmpty == true ? 'GOT IT' :
                  _alertMessage?.isNotEmpty == true ? 'OK' :
                  'CANCEL',
                ).appBarText(ColorConstants.colorTextAppBar, scaler!.getTextSize(11.5))
              ],
            ),
          ),
        )

      ],
    );
  }
}



