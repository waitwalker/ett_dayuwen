import 'package:flutter/material.dart';
import 'package:flutter_dayuwen/common/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

///
/// @name UserAgreementPage
/// @description 用户协议
/// @author lca
/// @date 2019-11-22
///
class UserAgreementPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserAgreementState();
  }
}

class _UserAgreementState extends State<UserAgreementPage> {
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
        body: Container(),
      );
    });
  }
}