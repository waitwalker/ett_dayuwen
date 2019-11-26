import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dayuwen/common/const/const.dart';
import 'package:flutter_dayuwen/common/network/network_manager.dart';
import 'package:flutter_dayuwen/common/singleton/singleton_manager.dart';
import 'package:flutter_dayuwen/pages/login/login_model.dart';

///
/// @name DaoManager
/// @description Dao 管理类
/// @author lca
/// @date 2019-10-09
///
class DaoManager {

  ///
  /// @Method: loginFetch
  /// @Parameter:
  /// @ReturnType:
  /// @Description: 获取登录接口数据
  /// @author: lca
  /// @Date: 2019-09-02
  ///
  static Future <ResponseData> loginFetch(Map<String,dynamic> parameters) async {
//    var response = await NetworkManager.post(Const.loginInterface, parameters);
//    if (response.result) {
//      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
//      print("response.data:${response.data}");
//
//      String jsonString = response.data;
//
//      var resultMap = json.decode(jsonString);
//      var loginModel = LoginModel.fromJson(resultMap);
//      response.model = loginModel;
//      SingletonManager.sharedInstance.loginModel = loginModel;
//      return response;
//    } else {
//      throw Exception("登录接口请求失败");
//    }
  }

  ///
  /// @Method: teacherRecentTaskFetch
  /// @Parameter:
  /// @ReturnType:
  /// @Description: 教师获取最近任务
  /// @author: lca
  /// @Date: 2019-09-02
  ///
  static Future <ResponseData> teacherRecentTaskFetch(Map<String,dynamic> parameters) async {
    var response = await NetworkManager.post(Const.teacherRecentTask, parameters);
    if (response.result) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      print("response.data:${response.data}");

      String jsonString = response.data;

      var resultMap = json.decode(jsonString);
      var model = TeacherTaskModel.fromJson(resultMap);
      response.model = model;
      return response;
    } else {
      throw Exception("登录接口请求失败");
    }
  }
  



}

