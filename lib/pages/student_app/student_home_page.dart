import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dayuwen/common/redux/app_state.dart';
import 'package:flutter_dayuwen/pages/login/app_login_manager.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class StudentHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentHomeState();
  }
}

class _StudentHomeState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {

    return WebviewScaffold(
      cookies: [
        {'k': 'token', 'v': AppLoginManager.instance.loginModel.token},
        {'k': 'identity', 'v': "${AppLoginManager.instance.loginModel.userType}"},
        {'k': 'platform', 'v': "2"},
      ],
      userAgent: "|appVersion=1.0.2",
      url: AppLoginManager.instance.configModel.h5Url.studentUrl,
    );
  }
}

//class _StudentHomeState extends State<StudentHomePage> {
//  WebViewController webViewController;
//
//  @override
//  Widget build(BuildContext context) {
//    return StoreBuilder<AppState>(builder: (context, store) {
//      return Scaffold(
//        body: WebView(
//          initialUrl: AppLoginManager.instance.configModel.h5Url.studentUrl,
//          javascriptMode: JavascriptMode.unrestricted,
//          onWebViewCreated: (controller) {
//            webViewController = controller;
//            webViewController.evaluateJavascript(_getCookie());
//          },
//          onPageFinished: (url){
//            webViewController.evaluateJavascript(_getCookie());
//            print("加载完成:$url");
//          },
//          navigationDelegate: (NavigationRequest request) {
//            //对于需要拦截的操作 做判断
//            if(request.url.startsWith("myapp://")) {
//              print("即将打开 ${request.url}");
//              //做拦截处理
//              //pushto....
//              return NavigationDecision.prevent;
//            }
//
//            //不需要拦截的操作
//            return NavigationDecision.navigate;
//          },
//          javascriptChannels: <JavascriptChannel>[
//            /// js 调用Flutter 只有postMessage或者拦截url
//            JavascriptChannel(
//                name: "message",
//                onMessageReceived: (JavascriptMessage message) {
//                  print("参数： ${message.message}");
//                }
//            ),
//          ].toSet(),
//
//        ),
//      );
//    });
//  }
//
//  String _getCookie() {
//    String cookie = "document.cookie= '${AppLoginManager.instance.loginModel.token}';document.cookie= 'identity=${AppLoginManager.instance.loginModel.userType}';document.cookie= 'platform=2'";
//    print("设置的cookie:$cookie");
//    return cookie;
//  }
//}