import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constant.dart';

class Journal extends StatefulWidget {
  const Journal({Key? key}) : super(key: key);

  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: kblue,
            foregroundColor: babyblue,
            title: Text(
              'Tell me your day!',
              style: TextStyle(fontSize: 25),
            ),
          ),
          body: Container(
            color: white,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                alignment: Alignment.topCenter,
                child: Text("Diario"),
              )
            ]),
          )),
    );
  }
}
