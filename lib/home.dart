import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:moodamay/custom_dialog.dart';
import '../constant.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _name = "";

  String _date = "";

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

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: white,
      child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height * .20,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .135,
                color: pink,
                width: double.infinity,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .03),
                alignment: Alignment.topCenter,
                child: Text(_date,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: white,
                    )),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * .05,
                top: MediaQuery.of(context).size.height * .09,
                bottom: MediaQuery.of(context).size.height * .03,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: jasmine,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      width: MediaQuery.of(context).size.width * .5,
                      alignment: Alignment.center,
                      child: Text("Hi $_name!",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color.fromRGBO(41, 50, 65, 1.0),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    ));
  }
}
