
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meetapp/constants/color_constants.dart';
import 'package:meetapp/constants/route_constants.dart';
import 'package:meetapp/helper/shared_pref.dart';
import 'package:meetapp/locator.dart';
import 'package:meetapp/router.dart' as router;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPref.prefs = await SharedPreferences.getInstance();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: ColorConstants.colorbackground));

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
   MyApp()

  );

  setupLocator();
}

class MyApp extends StatelessWidget {
  SharedPreferences? prefs;




  @override

  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Meet App",
        debugShowCheckedModeBanner: false,


      theme: ThemeData(
        primarySwatch: color,
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: ColorConstants.colorButtonbgColor
        ),
      ),

      onGenerateRoute: router.Router.generateRoute,
      initialRoute:
      SharedPref.prefs?.getString(SharedPref.TOKEN) == null?
      RoutesConstants.login:
              RoutesConstants.dashboard

    );
  }

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

  MakeRoutes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('token');
  }
}
