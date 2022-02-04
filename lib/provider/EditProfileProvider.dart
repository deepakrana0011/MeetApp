import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meetapp/constants/color_constants.dart';
import 'package:meetapp/enum/viewstate.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/helper/shared_pref.dart';
import 'package:meetapp/provider/base_provider.dart';
import 'package:meetapp/service/FetchDataExpection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileProvider extends BaseProvider{
  final fnamecontroller = TextEditingController();
  final lnamecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final desccontroller = TextEditingController();
  final emailController = TextEditingController();
  final datetime=new TextEditingController();
  String file='';


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
      var pickedImage = await picker.getImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setImage(File(pickedImage.path));
        //setImage(File(pickedImage.path));
      }
    } else {
      var pickedImage = await picker.getImage(source: ImageSource.gallery);


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

  void getUserInfo(BuildContext context) {
    setState(ViewState.Busy);
   fnamecontroller.text = SharedPref.prefs!.getString(SharedPref.FIRST_NAME);
    lnamecontroller.text = SharedPref.prefs!.getString(SharedPref.LAST_NAME);
    datetime.text = SharedPref.prefs!.getString(SharedPref.AGE);
    desccontroller.text = SharedPref.prefs!.getString(SharedPref.DESCRIPTION);
    emailController.text= SharedPref.prefs!.getString(SharedPref.Email);
    file= SharedPref.prefs!.getString(SharedPref.profile_pic);
    print(file);

    setState(ViewState.Idle);
  }

  Future<bool> update(BuildContext context, String fname, String lname, String age, String description, String email, String file)async {
    print(file);

    setState(ViewState.Busy);

    try {
      var model = await api.updateUser(context,fname,lname,age,description,email,file);
      if(model.success){


        setState(ViewState.Idle);
        DialogHelper.showMessage(context, model.message);
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



}