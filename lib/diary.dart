import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constant.dart';

class Diary extends StatefulWidget {
  const Diary({Key? key}) : super(key: key);

  @override
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          body: Container(
        color: white,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            alignment: Alignment.topCenter,
            child: Text("Diario"),
          )
        ]),
      )),
    );
  }
}
