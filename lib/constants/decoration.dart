
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:meetapp/constants/image_constants.dart';


import 'color_constants.dart';

class ViewDecoration{
  static InputDecoration inputDecorationWithCurve(
      String fieldname, ScreenScaler scaler,{IconData? prefixIcon,Widget? suffixIcon}) {
    return InputDecoration(


        prefixIcon: prefixIcon==null?null:suffixIcon,
        suffixIcon: suffixIcon==null?null:suffixIcon,


        hintText: fieldname,
        filled: true,
        hintStyle: textRegular(ColorConstants.colorHintTextColor, scaler.getTextSize(9.5)),
        isDense: true,
        contentPadding: suffixIcon==null?scaler.getPaddingLTRB(1.7, 1.5, 1,0.5):scaler.getPaddingLTRB(1, 0.4, 0.4, 1),
        fillColor: ColorConstants.whiteColor,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.border, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.gray, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorConstants.border, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(0))),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 0.7),
            borderRadius: BorderRadius.all(Radius.circular(4))));
  }
  static InputDecoration inputDecorationWithCurveandColor(
      String fieldname, ScreenScaler scaler,{IconData? prefixIcon,Widget? suffixIcon}) {
    return InputDecoration(


        suffixIcon: suffixIcon,


        hintText: fieldname,
        filled: true,
        hintStyle: textRegular(ColorConstants.colorHintTextColor, scaler.getTextSize(9.5)),
        isDense: true,
        contentPadding: suffixIcon==null?scaler.getPaddingLTRB(1.7, 1.5, 1, 0.5):scaler.getPaddingLTRB(1, 0.4, 0.4, 1),
        fillColor: ColorConstants.whiteColor,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.border, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.border, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorConstants.border, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4))));
  }
  static InputDecoration inputDecorationWithCurveandColorForage(
      String fieldname, ScreenScaler scaler,{IconData? prefixIcon,Widget? suffixIcon}) {
    return InputDecoration(

        prefixIcon: prefixIcon==null?null:suffixIcon,
        suffixIcon: Icon(Icons.arrow_drop_down),


        hintText: fieldname,
        filled: true,
        hintStyle: textRegular(ColorConstants.colorHintTextColor, scaler.getTextSize(9.5)),
        isDense: true,
        contentPadding: suffixIcon==null?scaler.getPaddingLTRB(1.7, 1.5, 1, 0.5):scaler.getPaddingLTRB(1, 0.4, 0.4, 1),
        fillColor: ColorConstants.whiteColor,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.border, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.border, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorConstants.border, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4))));
  }




  static InputDecoration inputDecorationWithCurveMultiline(
      String fieldname, ScreenScaler scaler,{IconData? icon,IconData? suffix, VoidCallback? suffixClick}) {
    return InputDecoration(
        prefixIcon: icon==null?null:Icon(
          icon,
          size: scaler.getTextSize(12),
          color: ColorConstants.gray,
        ),

        suffixIcon: suffix==null?null:IconButton(
          icon: Icon(suffix,size: scaler.getTextSize(12),color: ColorConstants.gray),
          onPressed: suffixClick,
        ),
        hintText: fieldname,
        fillColor: ColorConstants.gray,
        filled: true,
        hintStyle: textRegular(Colors.grey, scaler.getTextSize(10)),
        isDense: true,
        contentPadding: icon==null?scaler.getPaddingLTRB(1, 1, 0.5, 1):scaler.getPaddingLTRB(0.4, 0.4, 0.4, 0.4),


        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorConstants.gray, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(8))));
  }

  static TextStyle textMedium(Color color, double textSize) {
    return TextStyle(
        color: color,
        fontFamily: "popins",
        fontWeight: FontWeight.w500,
        fontSize: textSize);
  }


  static TextStyle textSemiMedium(Color color, double textSize) {
    return TextStyle(
        color: color,
        fontFamily: "popins",
        fontWeight: FontWeight.w700,
        fontSize: textSize);
  }

  static TextStyle textFieldStyle(double size) {
    return TextStyle(
        color: ColorConstants.colorTextAppBar,
        fontFamily: "popins",
        fontWeight: FontWeight.w400,
        fontSize: size);
  }

  static TextStyle appBarTitleStyle(double textSize) {
    return TextStyle(
        color: Colors.white,
        fontFamily: "popins",
        fontWeight: FontWeight.w500,
        fontSize: textSize);
  }

  static TextStyle textRegular(Color color, double textSize) {
    return TextStyle(
        color: color,
        fontFamily: "popins",
        fontWeight: FontWeight.w400,
        fontSize: textSize);
  }



}