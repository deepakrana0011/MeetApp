import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:meetapp/constants/color_constants.dart';
import 'package:meetapp/constants/image_constants.dart';
import 'package:meetapp/constants/route_constants.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/model/write_record.dart';
import 'package:meetapp/provider/nfc_sesson.dart';
import 'package:meetapp/provider/write_provider.dart';
import 'package:meetapp/view/base_view.dart';
import 'package:meetapp/extensions/allExtensions.dart';
import 'package:meetapp/widgets/image_view.dart';
import 'package:meetapp/widgets/roundCornerShape.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';

class Write extends StatefulWidget {
  @override
  _WriteState createState() => _WriteState();
}

class _WriteState extends State<Write> {
  ScreenScaler? scaler;
  Iterable<WriteRecord> ss = [];
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
  final _formKey = GlobalKey<FormState>();
  bool isAvailable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NfcManager.instance.isAvailable().then((bool value) {
      setState(() {
        isAvailable = value;
      });
      print(isAvailable);

    });
  }

  @override
  Widget build(BuildContext context) {
    if (scaler == null) {
      scaler = new ScreenScaler()..init(context);
    }
    return SafeArea(
      child: Scaffold(


          resizeToAvoidBottomInset: false,
          backgroundColor: ColorConstants.colorbackground,
          key: _scaffoldKey,
          body: BaseView<WriteProvider>(
            onModelReady: (provider) {
              provider.getLinks(context);
            },
            builder: (context, provider, _) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: scaler!.getHeight(1.5),
                    ),
                    Padding(
                        padding: scaler!.getPaddingLTRB(3, 0, 3, 0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: provider.writeitems.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: scaler!.getPaddingLTRB(0, 0.5, 0, 0),
                                child: Container(
                                  child: RoundCornerShape(
                                    radius: 4,
                                    bgColor: ColorConstants.whiteColor,
                                    child: ListTile(
                                      onTap: () {
                                        provider.getLinkText(context,
                                            provider.writeitems[index]);

                                        provider.link.text == ''
                                            ? DialogHelper
                                                .showDialogWithTwoButtonswithImage(
                                                    context,
                                                    provider.writeitems[index],
                                                    'Ok',
                                                    'Cancel',
                                                    scaler!,
                                                    writeIcons[index],
                                                    provider.link,
                                                    positiveButtonPress: () {
                                                if (provider.link.text == '') {
                                                  DialogHelper.showMessage(
                                                      context,
                                                      provider.writeitems[
                                                              index] +
                                                          ' cannot be empty');
                                                  return;
                                                }

                                                provider
                                                    .createProfile(
                                                        context,
                                                        provider
                                                            .writeitems[index],
                                                        provider.link.text)
                                                   ;
                                              }, negativeButtonPress: () {
                                                Navigator.pop(context);
                                              })
                                            : DialogHelper
                                                .showDialogWithTwoButtonswithImage(
                                                    context,
                                                    provider.writeitems[index],
                                                    'Update',
                                                    'Cancel',
                                                    scaler!,
                                                    writeIcons[index],
                                                    provider.link,
                                                    positiveButtonPress: () {
                                                if (provider.link.text == '') {
                                                  DialogHelper.showMessage(
                                                      context,
                                                      provider.writeitems[
                                                              index] +
                                                          ' cannot be empty');
                                                  return;
                                                }

                                                provider
                                                    .updateProfile(
                                                        context,
                                                        provider
                                                            .writeitems[index],
                                                        provider.link.text);

                                              }, negativeButtonPress: () {
                                                Navigator.pop(context);
                                              });
                                      },
                                      leading: ImageView(
                                        path: writeIcons[index],
                                      ),
                                      title: Text(provider.writeitems[index])
                                          .menuItemText(
                                              ColorConstants.colorBlack,
                                              scaler!.getTextSize(10)),
                                      trailing: ImageView(
                                          path:
                                              ImageConstants.ic_forward_arrow),
                                    ),
                                  ),
                                ),
                              );
                            })),
                    Padding(
                      padding: scaler!.getPaddingLTRB(3, 1.5, 3, 0.8),
                      child: GestureDetector(
                        onTap: () {
                          if (isAvailable) {
                            startSession(

                              context: context,


                              handleTag: (tag) => Provider.of<WriteProvider>(
                                      context,
                                      listen: false)
                                  .writeNdef(tag),


                            );
                          } else {
                            DialogHelper.showMessage(
                                context, 'NFC is not available on your device');
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: scaler!.getHeight(4),
                          child: RoundCornerShape(
                            bgColor: ColorConstants.colorButtonbgColor,
                            radius: 8,
                            child: Padding(
                              padding: scaler!.getPaddingLTRB(0, 0, 0, 0),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ImageView(path: ImageConstants.ic_download),
                                    Padding(
                                      padding:
                                          scaler!.getPaddingLTRB(1, 0, 0, 0),
                                      child: Text(
                                        'Download',
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
                    Padding(
                      padding: scaler!.getPaddingLTRB(3, 0, 3, 2),
                      child: GestureDetector(
                        onTap: () {

                          if (isAvailable) {
                            DialogHelper.showDialogWithTwoButtons(
                                context,
                                'Erase Data',
                                'Yes',
                                'Cancel',
                                'Are you sure you want to erase data from NFC ?',
                                positiveButtonPress: () {
                              startSession(
                                context: context,
                                handleTag: (tag) => Provider.of<WriteProvider>(
                                        context,
                                        listen: false)
                                    .cleardata(tag,context),
                              );
                              Navigator.pop(context);
                            }, negativeButtonPress: () {
                              Navigator.pop(context);
                            });
                          } else {

                            DialogHelper.showMessage(
                                context, 'NFC is not available on your device');
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: scaler!.getHeight(4),
                          decoration: BoxDecoration(
                              color: ColorConstants.whiteColor,
                              border: Border.all(
                                  color: ColorConstants.colorwritebutton,
                                  width: 0.6),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageView(path: ImageConstants.ic_erase),
                                Padding(
                                  padding: scaler!.getPaddingLTRB(1, 0, 0, 0),
                                  child: Text(
                                    'Erase',
                                  ).buttonText(
                                      ColorConstants.colorwritebutton,
                                      scaler!.getTextSize(11),
                                      TextAlign.center),
                                ),
                              ],
                            ),
                          ),
                        ),
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
