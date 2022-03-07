//@dart=2.11
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meetapp/constants/color_constants.dart';
import 'package:meetapp/constants/route_constants.dart';
import 'package:meetapp/helper/shared_pref.dart';
import 'package:meetapp/locator.dart';
import 'package:meetapp/router.dart' as router;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'helper/method_channel_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MethodChannelCall.initMethodChannel();

  // await Firebase.initializeApp();
  SharedPref.prefs = await SharedPreferences.getInstance();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: ColorConstants.whiteColor));

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());

  setupLocator();
}

class MyApp extends StatefulWidget {
  MakeRoutes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('token');
  }

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  SharedPreferences prefs;

  MaterialColor color = const MaterialColor(0xFF7ac142, <int, Color>{
    50: Color(0xFF1C67D3),
    100: Color(0xFF1C67D3),
    200: Color(0xFF1C67D3),
    300: Color(0xFF1C67D3),
    400: Color(0xFF1C67D3),
    500: Color(0xFF1C67D3),
    600: Color(0xFF1C67D3),
    700: Color(0xFF1C67D3),
    800: Color(0xFF1C67D3),
    900: Color(0xFF1C67D3),
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: "Meet App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: color,
          textSelectionTheme: TextSelectionThemeData(
              cursorColor: ColorConstants.colorButtonbgColor),
        ),
        onGenerateRoute: router.Router.generateRoute,
        initialRoute: SharedPref.prefs?.getString(SharedPref.TOKEN) == null ||
                SharedPref.prefs?.getString(SharedPref.TOKEN).isEmpty
            ? RoutesConstants.login
            : RoutesConstants.dashboard);
  }
}
