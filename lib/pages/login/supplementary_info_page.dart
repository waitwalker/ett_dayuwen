import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dayuwen/common/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      return Scaffold(
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
                  height: 100
              ),
            ),


          ],
        ),
      );
    });
  }
}