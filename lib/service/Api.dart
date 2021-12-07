import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meetapp/constants/api_constants.dart';
import 'package:meetapp/helper/dialog_helper.dart';
import 'package:meetapp/helper/shared_pref.dart';
import 'package:meetapp/jsonconvert.dart';
import 'package:meetapp/model/CreateLinkResponse.dart';
import 'package:meetapp/model/GetLocationResponse.dart';
import 'package:meetapp/model/GetProfileResponse.dart';
import 'package:meetapp/model/Links.dart';
import 'package:meetapp/model/LoginResponse.dart';
import 'package:meetapp/model/SignupResponse.dart';
import 'package:meetapp/model/UpdateLinkResponse.dart';
import 'package:meetapp/model/UpdateLocationResponse.dart';
import 'package:meetapp/service/FetchDataExpection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../locator.dart';

class Api {
  var client = new http.Client();
  Dio dio = locator<Dio>();

  Future<SignupResponse> signup(
      BuildContext context,
      String fname,
      String lname,
      String age,
      String description,
      String email,
      String password,
      String file,
      double latitude,
      double longitude) async {
    // dio.options.headers["Accept"] = "application/json";
    try {
      var map = {
        "firstName": fname,
        "lastName": lname,
        "email": email,
        "description": description,
        "password": password,
        "longitude": longitude,
        "latitude": latitude,
        "dob": age
      };
      if (file != null) {
        var image = MultipartFile.fromFileSync(file, filename: "image.png");
        var imageMap = {
          'profilePic': image,
        };
        map.addAll(imageMap);
      }
      var response = await dio.post(ApiConstants.BASE_URL + ApiConstants.SIGNUP,
          data: FormData.fromMap(map));
      // print(response.data);

      return SignupResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["error"];

        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<LoginResponse> login(
      BuildContext context, String email, String password) async {
    try {
      var map = {"email": email, "password": password};
      var response =
          await dio.post(ApiConstants.BASE_URL + ApiConstants.LOGIN, data: map);
      return LoginResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["error"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<GetProfileResponse> getProfileResponse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var headerMap = {
        "Content-Type": "application/json",
        "Authorization": prefs.getString('token'),
      };
      var options =
          BaseOptions(baseUrl: ApiConstants.BASE_URL, headers: headerMap);
      dio.options = options;
      var response =
          await dio.get(ApiConstants.BASE_URL + ApiConstants.USERPROFILE);
      return GetProfileResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["error"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<CreateLinkResponse> createLink(
      BuildContext context, String writeitem, String link) async {
    var map = <String, dynamic>{
      "type": writeitem,
      "link": link,
    };

    try {
      var headerMap = {
        "Content-Type": "application/json",
        "Authorization": SharedPref.prefs?.getString(SharedPref.TOKEN),
      };
      var options =
          BaseOptions(baseUrl: ApiConstants.BASE_URL, headers: headerMap);
      dio.options = options;

      var response = await dio
          .post(ApiConstants.BASE_URL + ApiConstants.CREATE_LINK, data: map);
      return CreateLinkResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["error"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

 Future<Links> getLinks() async {
    try {
      var headerMap = {
        "Content-Type": "application/json",
        "Authorization": SharedPref.prefs?.getString(SharedPref.TOKEN),
      };
      var options =
      BaseOptions(baseUrl: ApiConstants.BASE_URL, headers: headerMap);
      dio.options = options;
      var response =
      await dio.get(ApiConstants.BASE_URL + ApiConstants.GET_LINK);
     return Links.fromJson(jsonDecode(response.toString()));

    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["error"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

 Future<UpdateLinkResponse> updateLink(BuildContext context, writeitem,  link) async {
   var map = <String, dynamic>{
     "type": writeitem,
     "link": link,
   };

   try {
     var headerMap = {
       "Content-Type": "application/json",
       "Authorization": SharedPref.prefs?.getString(SharedPref.TOKEN),
     };
     var options =
     BaseOptions(baseUrl: ApiConstants.BASE_URL, headers: headerMap);
     dio.options = options;

     var response = await dio
         .put(ApiConstants.BASE_URL + ApiConstants.UPDATE_LINK, data: map);
     return UpdateLinkResponse.fromJson(json.decode(response.toString()));
   } on DioError catch (e) {
     if (e.response != null) {
       var errorData = jsonDecode(e.response.toString());
       var errorMessage = errorData["error"];
       throw FetchDataException(errorMessage);
     } else {
       throw SocketException("");
     }
   }
  }

  Future<GetLocationResponse> getLocationResponse() async {
    try {
      var headerMap = {
        "Content-Type": "application/json",
        "Authorization": SharedPref.prefs?.getString(SharedPref.TOKEN),
      };
      var options =
      BaseOptions(baseUrl: ApiConstants.BASE_URL, headers: headerMap);
      dio.options = options;
      var response =
      await dio.get(ApiConstants.BASE_URL + ApiConstants.GET_USERS_LOCATION);
      return GetLocationResponse.fromJson(jsonDecode(response.toString()));

    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["error"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<UpdateLocationResponse>updateLocation(BuildContext context, double? lat, double? long) async {
    var map = <String, dynamic>{
      "longitude": long,
      "latitude": lat,
    };

    try {
      var headerMap = {
        "Content-Type": "application/json",
        "Authorization": SharedPref.prefs?.getString(SharedPref.TOKEN),
      };
      var options =
      BaseOptions(baseUrl: ApiConstants.BASE_URL, headers: headerMap);
      dio.options = options;

      var response = await dio
          .put(ApiConstants.BASE_URL + ApiConstants.UPDATE_LOCATION, data: map);
      return UpdateLocationResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["error"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }
}
