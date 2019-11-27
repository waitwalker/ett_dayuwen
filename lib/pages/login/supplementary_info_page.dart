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
          children: <Widget>[

            Text("完善信息",style: TextStyle(fontSize: 30),),




          ],
        ),
      );
    });
  }
}