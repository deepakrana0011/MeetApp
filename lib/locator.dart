import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meetapp/provider/EditProfileProvider.dart';
import 'package:meetapp/provider/contact_detail_provider.dart';
import 'package:meetapp/provider/contacts_provider.dart';
import 'package:meetapp/provider/dashboard_provider.dart';
import 'package:meetapp/provider/forgot_provider.dart';
import 'package:meetapp/provider/login_provider.dart';
import 'package:meetapp/provider/maps_provider.dart';
import 'package:meetapp/provider/privacy_policy_provider.dart';
import 'package:meetapp/provider/profile_provider.dart';
import 'package:meetapp/provider/save_token.dart';
import 'package:meetapp/provider/sign_up_provider.dart';
import 'package:meetapp/provider/verification_provider.dart';
import 'package:meetapp/provider/write_provider.dart';
import 'package:meetapp/service/Api.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton<SaveToken>(() => SaveToken());

  locator.registerFactory(() => LoginProvider());
  locator.registerFactory(() => SignUpProvider());
  locator.registerFactory(() => DashBoardProvider());
  locator.registerFactory(() => ProfileProvider());
  locator.registerFactory(() => WriteProvider());
  locator.registerFactory(() => MapsProvider());
  locator.registerFactory(() => ForgotProvider());
  locator.registerFactory(() => EditProfileProvider());
  locator.registerFactory(() => PrivacyPolicyProvider());
  locator.registerFactory(() => VerificationProvider());
  locator.registerFactory(() => ContactsProvider());
  locator.registerFactory(() => ContactDetailProvider());


  locator.registerLazySingleton<Dio>(() {
    Dio dio = new Dio();
    //dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    // dio.interceptors.add(AuthInterceptor());
    return dio;
  });
}