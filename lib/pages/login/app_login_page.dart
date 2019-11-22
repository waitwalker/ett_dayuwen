import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dayuwen/common/redux/app_state.dart';
import 'package:flutter_dayuwen/pages/login/user_agreement_page.dart';
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
  FocusNode _contentFocusNode = FocusNode();
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
          body: Padding(
            padding: EdgeInsets.only(left: 40,right: 40,top: 30),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.index == 0 ? "学生登录" : "老师登录",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),),
                Padding(padding: EdgeInsets.only(top: 40)),
                TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone_iphone,color: Colors.grey,),
                      hintText: "请输入手机号",
                      hintStyle: TextStyle(color: Colors.grey)
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                ),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline,color: Colors.grey,),
                    hintText: "请输入验证码",
                    hintStyle: TextStyle(color: Colors.grey),
                    suffix: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: GestureDetector(child: Text("获取验证码",style: TextStyle(fontSize: 15),),),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                ),

                Padding(padding: EdgeInsets.only(top: 40)),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(child: Text("登录"), onPressed: (){},color: Colors.amber,disabledColor: Colors.grey,),
                ),

                Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  children: <Widget>[
                    Text("登录即代表您已同意"),
                    GestureDetector(
                      child: Text("《龙之门大语文用户协议》",style: TextStyle(fontSize: 14,color: Colors.deepOrangeAccent),),
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
        ),
        onTap: (){
          _contentFocusNode.unfocus();
        },
      );
    });
  }
}