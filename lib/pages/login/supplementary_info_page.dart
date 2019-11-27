import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dayuwen/common/network/network_manager.dart';
import 'package:flutter_dayuwen/common/redux/app_state.dart';
import 'package:flutter_dayuwen/dao/dao_manager.dart';
import 'package:flutter_dayuwen/pages/login/picker_data.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_redux/flutter_redux.dart';

///
/// @name SupplementaryInfoPage
/// @description 完善信息页面
/// @author lca
/// @date 2019-11-22
///
class SupplementaryInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SupplementaryInfoState();
  }
}

class _SupplementaryInfoState extends State<SupplementaryInfoPage> {
  TextEditingController _nameController;
  TextEditingController _gradeController;
  FocusNode _nameFocus = FocusNode();
  FocusNode _gradeFocus = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _nextEnable = false;

  @override
  void initState() {
    _nameController =TextEditingController();
    _gradeController =TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      return GestureDetector(
        onTap: (){
          _packUpKeyboard();
        },
        child: Scaffold(
          key: _scaffoldKey,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 100)),
              Container(
                alignment: Alignment.center,
                child: Text("完善信息",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
              ),
              Padding(padding: EdgeInsets.only(top: 40)),

              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 100,
                width: 100,
                child: FadeInImage.assetNetwork(
                  placeholder: 'lib/resources/images/student_avatar.png',
                  image: 'https://pic1.zhimg.com/v2-7fab628481a26f025188b095b5cfafbc.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 40)),

              Padding(
                padding: EdgeInsets.only(top: 40,left: 20,right: 20),
                child: TextField(
                  controller: _nameController,
                  focusNode: _nameFocus,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline,color: Colors.grey,size: 24,),
                    hintText: "填写学生姓名",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onEditingComplete: (){

                  },

                  onChanged:(text){
                    print("手机号输入:$text");
                    if (text.length > 11) {
                      _nameController.text = text.substring(0,11);
                    }
                  },

                  keyboardType: TextInputType.text,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Divider(height: 3.0,color: Colors.grey,),
              ),

              Padding(
                padding: EdgeInsets.only(top: 40,left: 20,right: 20),
                child: TextField(
                  controller: _gradeController,
                  focusNode: _gradeFocus,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline,color: Colors.grey,size: 24,),
                    suffixIcon: Icon(Icons.keyboard_arrow_down,color: Colors.grey,size: 30,),
                    hintText: "填写学生年级",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onTap: (){
                    print("点击这里");
                    _packUpKeyboard();
                    showPicker(context);
                  },
                  onEditingComplete: (){

                  },

                  onChanged:(text){
                    print("手机号输入:$text");
                    if (text.length > 11) {
                      _gradeController.text = text.substring(0,11);
                    }
                  },

                  keyboardType: TextInputType.text,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Divider(height: 3.0,color: Colors.grey,),
              ),

              Padding(
                padding: EdgeInsets.only(left: 20,right: 20,top: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    child: Text("下一步"),
                    color: Colors.amber,
                    disabledColor: Colors.grey,
                    onPressed: _nextEnable ? () async{
                      _packUpKeyboard();

                      ResponseData responseData = await DaoManager.loginFetch({"name":_nameController.text,"grade":_gradeController.text,"image":""},);

                      if (responseData != null && responseData.model != null) {
                        if (responseData.model.code == 200) {
                          if (responseData.model.userInfo.name == null || responseData.model.userInfo.name.length == 0) {

                          } else {
                          }
                        } else if (responseData.model.code == 402) {
                          /// 验证码已失效

                        } else if (responseData.model.code == 500) {
                          /// 验证码已过期请重新获取

                        }
                      }

                    } : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  ///
  /// @name showPicker
  /// @description 年级选择器添加完成
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-11-27
  ///
  showPicker(BuildContext context) {
    Picker picker = Picker(
        adapter: PickerDataAdapter<String>(pickerdata: JsonDecoder().convert(PickerData)),
        cancelText: "取消",
        confirmText: "确认",
        changeToFirst: true,
        textAlign: TextAlign.left,
        textStyle: const TextStyle(color: Colors.grey,fontSize: 20),
        selectedTextStyle: TextStyle(color: Colors.red,fontSize: 20),
        columnPadding: const EdgeInsets.all(8.0),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          setState(() {
            _gradeController.text = picker.getSelectedValues().first.toString();
          });
        }
    );
    picker.show(_scaffoldKey.currentState);
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
    _nameFocus.unfocus();
    _gradeFocus.unfocus();
  }
}