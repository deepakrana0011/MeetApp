import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meetapp/view/contacts/contact_detail.dart';

class MethodChannelHelper {
  static const MethodChannel channel = const MethodChannel('method_channal');
}
class MethodChannelCall{
  static initMethodChannel() async {
    MethodChannelHelper.channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'onTap':
          final link = call.arguments.toString().split('/');
          var tapid = link[5];

          Get.to(ContactDetail(
            tapid: tapid,
          ));

          return new Future.value("");
      }
    });
  }
}