import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dayuwen/common/network/network_manager.dart';
import 'package:flutter_dayuwen/common/redux/app_state.dart';
import 'package:flutter_dayuwen/common/toast/toast.dart';
import 'package:flutter_dayuwen/dao/dao_manager.dart';
import 'package:flutter_dayuwen/pages/login/app_login_manager.dart';
import 'package:flutter_dayuwen/pages/login/user_agreement_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// @name AppLoginPage
/// @description 登录页面
/// @author lca
/// @date 2019-11-21
///
class AppLoginPage extends StatefulWidget {
  final int index;
  AppLoginPage({this.index});
  @override
  State<StatefulWidget> createState() {
    return _AppLoginState();
  }
}

class _AppLoginState extends State<AppLoginPage> {
  FocusNode _numberFocusNode = FocusNode();
  FocusNode _codeFocusNode = FocusNode();
  TextEditingController _numberController;
  TextEditingController _codeController;

  bool _codeButtonEnable = false;
  bool _loginEnable = false;

  String _codeButtonTitle = "获取验证码";
  Timer countDownTimer;

  ///
  /// @name _startCountDownFunction
  /// @description 倒计时
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-11-25
  ///
  _startCountDownFunction() {
    _codeFetch();
    countDownTimer?.cancel();//如果已存在先取消置空
    countDownTimer = null;
    countDownTimer = Timer.periodic(new Duration(seconds: 1), (t){
      setState(() {
        if(60-t.tick>0){
          _codeButtonEnable = false;
          _codeButtonTitle = "重新获取(${60-t.tick})";
        } else {
          _cancelCountDownTimer();
        }
      });
    });
  }

  ///
  /// @name _cancelCountDownTimer
  /// @description 取消倒计时
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-11-26
  ///
  _cancelCountDownTimer() {
    _codeButtonEnable = true;
    _codeButtonTitle = '获取验证码';
    countDownTimer.cancel();
    countDownTimer = null;
  }

  _codeFetch() async {
    ResponseData responseData = await DaoManager.codeFetch({"phone":_numberController.text});
    if (responseData != null && responseData.model != null) {
      if (responseData.model.code == 403) {

      } else if (responseData.model.code == 500) {

      } else if (responseData.model.code == 200) {

      }

    }
  }


  @override
  void initState() {
    _numberController = TextEditingController();
    _codeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countDownTimer?.cancel();
    countDownTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      return GestureDetector(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: GestureDetector(
              child: Icon(Icons.arrow_back_ios),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 40)),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.index == 0 ? "学生登录" : "老师登录",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40,left: 20,right: 20),
                child: TextField(
                  controller: _numberController,
                  focusNode: _numberFocusNode,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone_iphone,color: Colors.grey,),
                    hintText: "请输入手机号",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onEditingComplete: (){

                  },

                  onChanged:(text){
                    print("手机号输入:$text");
                    if (text.length > 11) {
                      _numberController.text = text.substring(0,11);
                    }
                    if (text.length == 0) {
                      _cancelCountDownTimer();
                    }
                    _codeButtonState();
                    _loginButtonState();
                  },

                  keyboardType: TextInputType.phone,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Divider(height: 3.0,color: Colors.grey,),
              ),

              Padding(padding: EdgeInsets.only(top: 20)),
              Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 200,
                      child: TextField(
                        controller: _codeController,
                        focusNode: _codeFocusNode,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline,color: Colors.grey,),
                          hintText: "请输入验证码",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged:(text){
                          print("验证码输入:$text");
                          if (text.length > 6) {
                            _codeController.text = text.substring(0,6);
                          }
                          _loginButtonState();
                        },
                      ),
                    ),

                    FlatButton(
                      child: Text(_codeButtonTitle,style: TextStyle(fontSize: 14),),
                      onPressed: _codeButtonEnable ? _startCountDownFunction : null,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Divider(height: 3.0,color: Colors.grey,),
              ),

              Padding(padding: EdgeInsets.only(top: 40)),

              Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    child: Text("登录"),
                    color: Colors.amber,
                    disabledColor: Colors.grey,
                    onPressed: _loginEnable ? () async{
                      _packUpKeyboard();
                      ResponseData responseData = await DaoManager.loginFetch({"phone":_numberController.text,"code":_codeController.text,"role":widget.index},);

                      if (responseData != null && responseData.model != null) {
                        String message = responseData.model.message;

                        AppLoginManager.instance.loginModel.userType = AppLoginManager.instance.loginModel.userInfo.role;
                        if (responseData.model.code == 200) {
                          SharedPreferences preference = await SharedPreferences.getInstance();
                          preference.setString("token", AppLoginManager.instance.loginModel.token);
                          if (responseData.model.userInfo.name == null || responseData.model.userInfo.name.length == 0) {
                            Navigator.pushNamedAndRemoveUntil(context, "/complete_info", (Route<dynamic> route) => false);
                          } else {
                            widget.index == 0 ?
                            Navigator.pushNamedAndRemoveUntil(context, "/student_home", (Route<dynamic> route) => false) :
                            Navigator.pushNamedAndRemoveUntil(context, "/teacher_home", (Route<dynamic> route) => false);
                          }
                        } else if (responseData.model.code == 402) {
                          /// 验证码已失效
                          if (message != null || message.length != 0) {
                            ETTToast.show(message + ":${responseData.code}");
                          } else {
                            ETTToast.show("此验证码已失效:${responseData.code}");
                          }
                        } else if (responseData.model.code == 403) {
                          /// 验证码校验失败
                          if (message != null || message.length != 0) {
                            ETTToast.show(message + ":${responseData.code}");
                          } else {
                            ETTToast.show("验证码校验失败:${responseData.code}");
                          }
                        } else if (responseData.model.code == 500) {
                          if (message != null || message.length != 0) {
                            ETTToast.show(message + ":${responseData.code}");
                          } else {
                            ETTToast.show("有些问题,请稍后重试!${responseData.code}");
                          }
                        }
                      }

                    } : null,
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("登录即代表您已同意",style: TextStyle(fontSize: 13),),
                  GestureDetector(
                    child: Text("《龙之门大语文用户协议》",style: TextStyle(fontSize: 13,color: Colors.deepOrangeAccent),),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return UserAgreementPage();
                      }));
                    },
                  )
                ],
              ),
            ],
          ),
        ),
        onTap: (){
          _packUpKeyboard();
        },
      );
    });
  }



  ///
  /// @name _loginButtonState
  /// @description 登录按钮状态
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-11-25
  ///
  _loginButtonState() {
    if (_numberController.text.length == 11 && _codeController.text.length >= 4) {
      _loginEnable = true;
    } else {
      _loginEnable = false;
    }
    setState(() {

    });
  }

  _codeButtonState() {
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    bool matched = exp.hasMatch(_numberController.text);
    _codeButtonEnable = matched;
  }

  ///
  /// @name _packUpKeyboard
  /// @description 收起键盘
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-11-25
  ///
  _packUpKeyboard() {
    _numberFocusNode.unfocus();
    _codeFocusNode.unfocus();
  }
}