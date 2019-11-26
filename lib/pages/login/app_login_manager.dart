import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dayuwen/common/database/database_manager.dart';
import 'package:flutter_dayuwen/common/network/network_manager.dart';
import 'package:flutter_dayuwen/dao/dao_manager.dart';
import 'package:flutter_dayuwen/models/interface_config_mode.dart';
import 'package:package_info/package_info.dart';

import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';


///
/// @name AppLoginManager
/// @description 登录管理
/// @author lca
/// @date 2019-10-25
///
class AppLoginManager {

  ///
  /// @name instance
  /// @description 单例模式
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-28
  ///
  factory AppLoginManager() => _getInstance();
  static AppLoginManager get instance => AppLoginManager._getInstance();
  static AppLoginManager _instance;
  AppLoginManager._internal() {
    // 初始化
  }
  static AppLoginManager _getInstance() {
    if (_instance == null) {
      _instance = new AppLoginManager._internal();
    }
    return _instance;
  }


  /// 配置model
  Result configModel;

  /// 登录 model
//  Data loginModel;
//
//  ///
//  /// @name routeToPage
//  /// @description 登录后的路由页
//  /// @parameters
//  /// @return
//  /// @author lca
//  /// @date 2019-10-29
//  ///
//  routeToPage(BuildContext context, Map<String,dynamic> parameters) async {
//    /// 显示加载圈
//    _showLoading(context);
//    var response = await DaoManager.loginFetch(parameters);
//    if (response.result && response.model != null) {
//      AppLoginManager.instance.loginModel = response.model.data;
//      AppLoginManager.instance.loginModel.password = parameters["pwd"];
//      Navigator.of(context).pop();
//      _enterToApp(context, response.model.data);
//
//      _writeUserDataToCache();
//    } else {
//      print("登录异常,请稍候重试");
//    }
//    print(response);
//  }
//
//  ///
//  /// @name _enterToApp
//  /// @description 进入app
//  /// @parameters
//  /// @return
//  /// @author lca
//  /// @date 2019-10-29
//  ///
//  _enterToApp(BuildContext context,Data model) {
//    if (model.uType == 1 || model.uType == 2) {
//      /// 教师
//      Navigator.pushNamedAndRemoveUntil(context, "/teacher_home", (Route<dynamic> route) => false);
//      print("教师加载完成");
//    } else if (model.uType == 3 || model.uType == 4) {
//      /// 学生
//      Navigator.pushNamedAndRemoveUntil(context, "/student_home", (Route<dynamic> route) => false);
//    } else if (model.uType == 5 || model.uType == 5) {
//      /// 家长
//      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: TeacherHomePage()));
//    }
//  }

  ///
  /// @name _showLoading
  /// @description 显示加载圈
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-29
  ///
  _showLoading(BuildContext context) {
    showDialog(context: context,builder: (context) {
      return Center(
        child: Container(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  ///
  /// @name _hideLoading
  /// @description 隐藏加载圈
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-11-26
  ///
  _hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

//  ///
//  /// @name _writeUserDataToCache
//  /// @description 写入用户数据
//  /// @parameters
//  /// @return
//  /// @author lca
//  /// @date 2019-10-31
//  ///
//  _writeUserDataToCache() async {
//    if (AppLoginManager.instance.loginModel != null) {
//      var result = await DataBaseManager.instance.queryLoginModelByJid(AppLoginManager.instance.loginModel.jid.toString());
//      if (result == null) {
//        LoginDatabaseModel loginDatabaseModel = LoginDatabaseModel();
//        loginDatabaseModel.jid = AppLoginManager.instance.loginModel.jid.toString();
//        loginDatabaseModel.account = AppLoginManager.instance.loginModel.userName;
//        loginDatabaseModel.password = AppLoginManager.instance.loginModel.password;
//        loginDatabaseModel.loginType = AppLoginManager.instance.loginModel.uType;
//        String dateStr = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd, '  ', h, ':', nn, ':', ss, ' ', am]);
//        loginDatabaseModel.currentLoginTime = dateStr;
//        loginDatabaseModel.lastLoginTime = "空";
//        var insertResult = await DataBaseManager.instance.insertLoginModel(loginDatabaseModel);
//        print(insertResult);
//        if (insertResult == 1) {
//          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//          sharedPreferences.setBool("autoLogin", true);
//          sharedPreferences.setString("jid", AppLoginManager.instance.loginModel.jid.toString());
//        }
//      } else {
//        LoginDatabaseModel loginDatabaseModel = result;
//        loginDatabaseModel.lastLoginTime = loginDatabaseModel.currentLoginTime;
//        String dateStr = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd, '  ', h, ':', nn, ':', ss, ' ', am]);
//        loginDatabaseModel.currentLoginTime = dateStr;
//        var updateResult = await DataBaseManager.instance.updateLoginModel(loginDatabaseModel);
//        print(updateResult);
//
//        if (updateResult == 1) {
//          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//          sharedPreferences.setBool("autoLogin", true);
//          sharedPreferences.setString("jid", AppLoginManager.instance.loginModel.jid.toString());
//        }
//      }
//    }
//  }
//
//  ///
//  /// @name exitApp
//  /// @description 退出APP
//  /// @parameters
//  /// @return
//  /// @author lca
//  /// @date 2019-10-31
//  ///
//  exitApp(BuildContext context) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    sharedPreferences.setBool("autoLogin", false);
//    Navigator.pushNamedAndRemoveUntil(context, "/login", (Route<dynamic> route)=>false);
//  }
//
//  ///
//  /// @name readUserData
//  /// @description 读取用户数据
//  /// @parameters
//  /// @return
//  /// @author lca
//  /// @date 2019-10-31
//  ///
//  Future<Map<String,String>> readUserData() async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String jid = sharedPreferences.getString("jid");
//    if (jid != null) {
//      LoginDatabaseModel loginDatabaseModel = await DataBaseManager.instance.queryLoginModelByJid(jid);
//      if (loginDatabaseModel != null) {
//        Map <String,String> map = {
//          "uName":loginDatabaseModel.account,
//          "pwd":loginDatabaseModel.password,
//        };
//        return map;
//      }
//    }
//    return null;
//  }

  ///
  /// @name autoLogin
  /// @description 自动登录
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-31
  ///
  autoLogin(BuildContext context) async {
    Map<String,dynamic> map = {
      "imgPrefixUrl":"http://cdn.yuwenclub.com/",
      "server_url":{
        "apiServer":"https://api.yuwenclub.com"
      },
      "musicTimeout":"5",
      "xianshengTimeout":"30",
      "h5_url":{
        "teacherUrl" : "https://app-t.yuwenclub.com/#/",
        "studentUrl" : "https://app.yuwenclub.com",
        "userAgreementUrl" : "https://m.yuwenclub.com/terms.html",
      },
    };

    _showLoading(context);

    /// 获取配置
    ResponseData responseData = await DaoManager.interfaceConfigFetch({});
    if (responseData != null && responseData.model != null) {
      if (responseData.model.code == 200) {
        AppLoginManager.instance.configModel = responseData.model.result;
      } else {
        AppLoginManager.instance.configModel = Result.fromJson(map);
      }
    } else {
      AppLoginManager.instance.configModel = Result.fromJson(map);

    }

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");

    if (token != null) {
      Map<String,dynamic> header = {"x-token":token};

    } else {
      _hideLoading(context);
      Navigator.pushNamedAndRemoveUntil(context, "/select_identity", (Route<dynamic> route) => false);
    }
  }


  login(BuildContext context, Map parameter) async {
    ResponseData responseData = await DaoManager.loginFetch(parameter);
    if (responseData != null && responseData.model != null) {

    }
  }




}