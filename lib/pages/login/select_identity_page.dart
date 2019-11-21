import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dayuwen/common/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

///
/// @name SelectIdentityPage
/// @description 选择身份页面
/// @author lca
/// @date 2019-11-21
///
class SelectIdentityPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SelectIdentityState();
  }
}

class _SelectIdentityState extends State<SelectIdentityPage> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      return Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 100,left: 30),
              child: Text("欢迎加入龙之门大语文",style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.w500),),
            ),

            Expanded(child: ListView.builder(itemBuilder: _itemBuilder,itemCount: 2,),),
          ],
        ),
      );
    });
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber
      ),
      width: MediaQuery.of(context).size.width - 60,
      height: 120,
    );
  }
}