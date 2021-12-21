import 'dart:math';
import "package:cupertino_icons/cupertino_icons.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moodamay/Models/user_mood.dart';
import 'package:moodamay/mood_dialog.dart';
import 'package:moodamay/services/datebase_handler.dart';
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
  late DatabaseHandler handler;

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
    this.handler = DatabaseHandler();
    _date = date.format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          body: AnimatedOpacity(
            opacity: 1,
            duration: Duration(milliseconds: 500),
            child: Container(
              color: white,
              child: Column(children: [
                Container(
                  height: MediaQuery.of(context).size.height * .25,
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
                        top: MediaQuery.of(context).size.height * .14,
                        bottom: MediaQuery.of(context).size.height * .001,
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
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: this.handler.getMoods(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<UserMood>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Dismissible(
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20)),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.only(
                                      bottom: 15, left: 15, right: 15),
                                  child: Icon(Icons.delete_forever),
                                ),
                                key: ValueKey<int>(snapshot.data![index].id!),
                                onDismissed:
                                    (DismissDirection direction) async {
                                  await this
                                      .handler
                                      .deleteMood(snapshot.data![index].id!);
                                  setState(() {
                                    snapshot.data!
                                        .remove(snapshot.data![index]);
                                  });
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CustomMoodDialogBox(
                                              title: snapshot
                                                  .data![index].mood_name,
                                              descriptions: snapshot
                                                  .data![index].note
                                                  .toString(),
                                              text: snapshot.data![index].date,
                                              img: Image.asset(snapshot
                                                  .data![index].mood_image),
                                            );
                                          });
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.03),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 0,
                                            blurRadius: 2,
                                            offset: Offset(0, 1),
                                          ),
                                        ]),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Row(children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.asset(
                                                          snapshot.data![index]
                                                              .mood_image),
                                                    )),
                                                SizedBox(width: 10),
                                                Flexible(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            snapshot
                                                                .data![index]
                                                                .mood_name,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                            snapshot
                                                                .data![index]
                                                                .date,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey[
                                                                        500])),
                                                      ]),
                                                )
                                              ]),
                                            ),
                                          ],
                                        ),
                                        // SizedBox(
                                        //   height: 20,
                                        // ),
                                        // Container(
                                        //   child: Row(
                                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //     children: [
                                        //       Row(
                                        //         children: [
                                        //           Container(
                                        //             padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                        //             decoration: BoxDecoration(
                                        //               borderRadius: BorderRadius.circular(12),
                                        //               color: Colors.grey.shade200
                                        //             ),
                                        //             child: Text(job.type, style: TextStyle(color: Colors.black),),
                                        //           ),
                                        //           SizedBox(width: 10,),
                                        //           Container(
                                        //             padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                        //             decoration: BoxDecoration(
                                        //               borderRadius: BorderRadius.circular(12),
                                        //               color: Color(int.parse("0xff${job.experienceLevelColor}")).withAlpha(20)
                                        //             ),
                                        //             child: Text(job.experienceLevel, style: TextStyle(color: Color(int.parse("0xff${job.experienceLevelColor}"))),),
                                        //           )
                                        //         ],
                                        //       ),
                                        //       Text(job.timeAgo, style: TextStyle(color: Colors.grey.shade800, fontSize: 12),)
                                        //     ],
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
