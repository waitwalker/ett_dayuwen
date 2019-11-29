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
          /// js调用flutter
          javascriptChannels: <JavascriptChannel>[
            _baseJavascriptChannel(context),
            _xianshengJavascriptChannel(context),
            _avJavascriptChannel(context),
          ].toSet(),

        ),
    );
  }

  /// base channel
  JavascriptChannel _baseJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'base',
      onMessageReceived: (JavascriptMessage message) {

      },
    );
  }

  /// xiansheng channel
  JavascriptChannel _xianshengJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'xiansheng',
      onMessageReceived: (JavascriptMessage message) {

      },
    );
  }

  /// AV channel
  JavascriptChannel _avJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'AV',
      onMessageReceived: (JavascriptMessage message) {

      },
    );
  }
}
