import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:meetapp/constants/api_constants.dart';
import 'package:meetapp/constants/color_constants.dart';
import 'package:meetapp/extensions/allExtensions.dart';
import 'package:meetapp/provider/EditProfileProvider.dart';
import 'package:meetapp/view/base_view.dart';
import 'package:meetapp/widgets/roundCornerShape.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  final bool privacypolicy;

  const PrivacyPolicy({Key? key, required this.privacypolicy})
      : super(key: key);
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  ScreenScaler? scaler;
  int pos = 1;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    if (scaler == null) {
      scaler = new ScreenScaler()..init(context);
    }
    return IndexedStack(index: pos, children: <Widget>[
      WebView(
        navigationDelegate: (NavigationRequest request)  {
          if (request.url.contains("mailto:")) {
            launch(request.url);
            return NavigationDecision.navigate;
          }
          return NavigationDecision.navigate;
        },
        initialUrl: ApiConstants.privacy_policy,
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (value) {
          setState(() {
            pos = 1;
          });
        },
        onPageFinished: (value) {
          setState(() {
            pos = 0;
          });
        },
      ),
      Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  ColorConstants.colorButtonbgColor))),
    ]);
    /* return SafeArea(
      child: Scaffold(
          appBar:
          widget.privacypolicy?AppBar(


            backgroundColor: ColorConstants.whiteColor,
            title: Text('Privacy Policy').appBarText(
              ColorConstants.colorTextAppBar,
              scaler!.getTextSize(11),
            ),


            centerTitle: true,
          ):null,
          backgroundColor: ColorConstants.colorbackground,
          key: _scaffoldKey,
          body: BaseView<EditProfileProvider>(
            onModelReady: (provider) {
              provider.getUserInfo(context);
            },
            builder: (context, provider, _) {
              return
                SingleChildScrollView(
                  child: Column(
                    children: [
                    Padding(
                      padding: scaler!.getPaddingLTRB(3, 2, 3, 2),
                      child: RoundCornerShape(
                          child: Padding(
                            padding: scaler!.getPaddingLTRB(2, 1.5, 2, 1),
                            child: Text(
                                "A Privacy Policy is a legal document outlining how your organization collects, uses, and discloses personal information.A properly written Privacy Policy tells customers what data you collect about them when they engage with your business (e.g., through your website) or purchase one of your products/services, and why you're collecting that information. It also lets people know how long their information will be stored, who can access these records and more..In today's business world, companies depend heavily on data and information derived from it. Indeed, information is essential for all company employees, from the top executives to the operations level.Protecting data, especially private, personal information, is crucial in a complex world where so much depends upon it. The most important step for business owners to protect their customers' data is to create a concise and transparent Privacy Policy.So, a good Privacy Policy should outline what data is being collected and explain why you're collecting it, who has access to it, and the time frame during which you plan to store it. It should also include any third parties with whom your company shares personal or private information, as well as any steps taken to ensure the security of such information."
                            ).regularText(ColorConstants.colorTextAppBar,scaler!.getTextSize(10),),
                      ),
                          bgColor: ColorConstants.whiteColor, radius: 8),
                    )
                    ],
                  ),
                );
            },
          )),
    );*/
  }
}

//
