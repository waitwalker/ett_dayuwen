import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dayuwen/common/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      return Scaffold(
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
        body: Padding(
          padding: EdgeInsets.only(left: 40,right: 40,top: 30),
          child: Column(
            children: <Widget>[
              Text(widget.index == 0 ? "学生登录" : "老师登录",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
            ],
          ),
        ),
      );
    });
  }
}