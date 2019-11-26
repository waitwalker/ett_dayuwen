import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StudentHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentHomeState();
  }
}

class _StudentHomeState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white,
      child: OutlineButton(child: Text("退出"),onPressed: (){
        Navigator.pushNamedAndRemoveUntil(context, "/select_identity", (Route<dynamic> route) => false);
      },),
    );
  }
}