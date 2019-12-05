import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dayuwen/common/redux/app_state.dart';
import 'package:flutter_dayuwen/pages/login/app_login_manager.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class StudentHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentHomeState();
  }
}

class _StudentHomeState extends State<StudentHomePage> {


  FlutterWebviewPlugin webviewPlugin = FlutterWebviewPlugin();
  IjkMediaController audioController = IjkMediaController();

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
      if (parameter != null) {
        _handleJSCall(parameter);
      }
    });


    super.initState();
  }

  ///
  /// @name _handleJSCall
  /// @description 处理js调用flutter
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-12-03
  ///
  _handleJSCall(Map parameter) {
    String method = parameter['method'];
    Map argument = parameter['argument'];
    /// {method: AV.playAVPlayMusicWithParmas, argument: {"data":{"type":"localmp3","resouceUrl":"readrule","abserveMethod":"addObserverAVPlayerFinished"}}}

    if (method != null && method == "AV.playAVPlayMusicWithParmas") {
      if (argument != null) {
        Map data = argument["data"];
        if (data != null) {
          String type = data["type"];
          String resouceUrl = data["resouceUrl"];
          String abserveMethod = data["abserveMethod"];
          if (type != null && type == "localmp3") {
            if (resouceUrl != null) {
              String path = "lib/resouces/$resouceUrl.mp3";
              startPlayer(path);
            }
          }

        }
      }
    }

  }

  void startPlayer(String path) async{

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
