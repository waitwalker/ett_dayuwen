import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
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


  FlutterWebviewPlugin webviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {

    /// 监听url地址变化
    webviewPlugin.onUrlChanged.listen((String url){
      print("当前Webview地址:$url");
    });

    /// 监听页面状态改变
    webviewPlugin.onStateChanged.listen((WebViewStateChanged stateChanged){
      print("页面状态改变:${stateChanged.type}");
    });


    /// 监听Webview滚动
    webviewPlugin.onScrollYChanged.listen((double offsetY) {
      print("Y滚动距离:$offsetY");
    });

    webviewPlugin.onScrollXChanged.listen((double offsetX) {
      print("X滚动距离:$offsetX");
    });

    webviewPlugin.onJavascriptCalled.listen((Map parameter){
      print("onJavascriptCalled:$parameter");
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: WebviewScaffold(
          cookies: [
            {'k': 'token', 'v': AppLoginManager.instance.loginModel.token},
            {'k': 'identity', 'v': "${AppLoginManager.instance.loginModel.userType}"},
            {'k': 'platform', 'v': "2"},
          ],
          userAgent: "|appVersion=1.0.2",
          url: AppLoginManager.instance.configModel.h5Url.studentUrl,

        ),
    );
  }

  @override
  void dispose() {
    /// 释放
    webviewPlugin.close();
    super.dispose();
  }
}
