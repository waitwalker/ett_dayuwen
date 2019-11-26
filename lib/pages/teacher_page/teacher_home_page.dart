import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TeacherHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TeacherHomeState();
  }
}

class _TeacherHomeState extends State<TeacherHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white,
      child: OutlineButton(child: Text("退出"),onPressed: (){
        Navigator.pushNamedAndRemoveUntil(context, "/select_identity", (Route<dynamic> route) => false);
      },),
    );
  }
}