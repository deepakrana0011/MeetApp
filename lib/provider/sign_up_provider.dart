import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meetapp/constants/color_constants.dart';
import 'package:meetapp/constants/route_constants.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/helper/date_function.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/helper/shared_pref.dart';
import 'package:meetapp/locator.dart';
import 'package:meetapp/provider/base_provider.dart';
import 'package:meetapp/provider/save_token.dart';
import 'package:meetapp/service/FetchDataExpection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpProvider extends BaseProvider{
  bool _isPasswordVisible = false;
  File? _imageFile;
  String file='';
  double? lat;
  double? long;
  bool serviceEnabled=false;
  LocationPermission? permission;
  var status;

  bool get isPasswordVisible => _isPasswordVisible;
  final datetime=new TextEditingController();
  SaveToken saveToken= locator<SaveToken>();



  Future<void> selectAge(BuildContext context) async {

    showDatePicker(

        context: context,
        initialDate: DateTime(2010),

        firstDate: DateTime(1950),
        lastDate: DateTime(2015),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorConstants.colorButtonbgColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),

          ),
          child: child!,
        );
      },

    )

        .then((value) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(value!);
        datetime.text = formattedDate;
    });
  }

  Future getImage(BuildContext context, int type) async {

    Navigator.of(context).pop();

    final picker = ImagePicker();
    if (type == 1) {
      var pickedImage = await picker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setImage(File(pickedImage.path));
        //setImage(File(pickedImage.path));
      }
    } else {
      var pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        setImage(File(pickedImage.path));

        //setImage(File(pickedImage.path));
      }
    }
  }
  void setImage(File image) {
    file = image.path.toString();
    print(file);
    notifyListeners();
  }

  Future<bool> signup(BuildContext context, fname,lname, age, description, email, password, file,latitude,longitude) async {


      setState(ViewState.Busy);
       SharedPref.prefs!.setString(SharedPref.Email,email);

      try {
        var model = await api.signup(context,fname,lname,age,description,email, password,file,latitude,longitude);
        if(model.success){
          saveToken.registerToken=model.token;
          saveToken.id=model.data!.id;

          Navigator.pushNamedAndRemoveUntil(context, "verification", (Route<dynamic> route) => false);
          DialogHelper.showMessage(context, model.message);

          setState(ViewState.Idle);
          return true;
        }else{
          DialogHelper.showMessage(context, model.message);
          setState(ViewState.Idle);
          return false;
        }

      } on FetchDataException catch (c) {
        setState(ViewState.Idle);
        DialogHelper.showMessage(context, c.toString());
        return false;
      } on SocketException catch (c) {
        setState(ViewState.Idle);
        DialogHelper.showMessage(context, 'Internet connection');
        return false;
      }



  }


  Future<Position> determinePosition(BuildContext context) async {
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
       status= await Permission.location.request();

      if(status==PermissionStatus.granted){
        getLngLt();

      }
      else{
        showPermissionDialog(context);
      }




      // Use location.
    }
    else{
      showPermissionDialog(context);



    }








        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.







    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }


  void getLngLt() {
    Geolocator.getPositionStream().listen((event) {
      lat=event.latitude;
      long=event.longitude;
      print(long);


    });
  }

  void showPermissionDialog(BuildContext context) {
    DialogHelper.showDialogWithTwoButtons(
        context,
        'Required Permission',
        'Ok',
        'Cancel',
        'You have to give location permission to continue',
        positiveButtonPress: () {
          openAppSettings();
          Navigator.pop(context);


        }, negativeButtonPress: () {
      Navigator.pop(context);
    });
  }


  }








