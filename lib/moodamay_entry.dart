import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constant.dart';

class Mood extends StatefulWidget {
  const Mood({Key? key}) : super(key: key);

  @override
  _MoodState createState() => _MoodState();
}

class _MoodState extends State<Mood> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          appBar: AppBar(),
          body: Container(
            color: white,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                alignment: Alignment.topCenter,
                child: Text("Puto Mood"),
              )
            ]),
          )),
    );
  }
}
