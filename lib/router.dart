import 'package:flutter/material.dart';
import 'package:meetapp/view/auth/forgot_password.dart';
import 'package:meetapp/view/auth/login.dart';
import 'package:meetapp/view/auth/sign_up.dart';
import 'package:meetapp/view/dashboard/dasboard.dart';
import 'package:meetapp/view/maps/maps.dart';
import 'package:meetapp/view/profile/edit_profile.dart';
import 'package:meetapp/view/profile/profile.dart';
import 'package:meetapp/view/write/write.dart';
import 'constants/route_constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesConstants.login:
        return MaterialPageRoute(
            builder: (_) => LoginPage(), settings: settings);


      case RoutesConstants.signup:
        return MaterialPageRoute(
            builder: (_) => SignUp(), settings: settings);


      case RoutesConstants.dashboard:
        return MaterialPageRoute(
            builder: (_) => DashBoard(), settings: settings);


      case RoutesConstants.profile:
        return MaterialPageRoute(
            builder: (_) => Profile(), settings: settings);


      case RoutesConstants.write:
        return MaterialPageRoute(
            builder: (_) => Write(), settings: settings);


      case RoutesConstants.maps:
        return MaterialPageRoute(
            builder: (_) => Maps(), settings: settings);

      case RoutesConstants.forgot:
        return MaterialPageRoute(
            builder: (_) => ForgotPassword(), settings: settings);

      case RoutesConstants.editProfile:
        return MaterialPageRoute(
            builder: (_) => EditProfile(), settings: settings);


      default:
      //return MaterialPageRoute(builder: (_) =>  Testing());
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));

    }
  }
}