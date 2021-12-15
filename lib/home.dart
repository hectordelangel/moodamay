import 'dart:math';
import "package:cupertino_icons/cupertino_icons.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../constant.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _name = "";
  int? index = 0;
  String _date = "";
  var isDialOpen = ValueNotifier<bool>(false);

  void _nameRetriever() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? '';
    });
  }

  @override
  void initState() {
    _nameRetriever();
    final date = DateFormat.yMMMMd('en_US');
    _date = date.format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          body: Container(
        color: white,
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * .35,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .2,
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/screen4.png'),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .05,
                      left: MediaQuery.of(context).size.height * .03),
                  child: Text(_date,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: white,
                      )),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * .2,
                  right: MediaQuery.of(context).size.width * .2,
                  top: MediaQuery.of(context).size.height * .13,
                  bottom: MediaQuery.of(context).size.height * .09,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: white,
                            borderRadius: BorderRadius.circular(padding),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 0),
                                  blurRadius: 1),
                            ]),
                        width: MediaQuery.of(context).size.width * .6,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Welcome back, ",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Color.fromRGBO(41, 50, 65, 1.0),
                                )),
                            Text(_name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Color.fromRGBO(41, 50, 65, 1.0),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      )),
    );
  }
}
