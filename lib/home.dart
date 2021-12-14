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
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
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
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: SpeedDial(
            // animatedIcon: AnimatedIcons.menu_close,
            // animatedIconTheme: IconThemeData(size: 22.0),
            // / This is ignored if animatedIcon is non null
            // child: Text("open"),
            // activeChild: Text("close"),
            icon: Icons.add,
            backgroundColor: white,
            foregroundColor: babyblue,
            activeIcon: Icons.close,
            spacing: 3,
            openCloseDial: isDialOpen,
            childPadding: const EdgeInsets.all(5),
            spaceBetweenChildren: 4,

            /// Transition Builder between label and activeLabel, defaults to FadeTransition.
            // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
            /// The below button size defaults to 56 itself, its the SpeedDial childrens size

            overlayOpacity: 0,

            tooltip: 'Open Speed Dial',
            heroTag: 'speed-dial-hero-tag',
            // foregroundColor: Colors.black,
            // backgroundColor: Colors.white,
            // activeForegroundColor: Colors.red,
            // activeBackgroundColor: Colors.blue,
            elevation: 8.0,
            isOpenOnStart: false,
            animationSpeed: 200,
            direction: SpeedDialDirection.up,
            children: [
              SpeedDialChild(
                child: const Icon(Icons.mood),
                backgroundColor: pink,
                foregroundColor: babyblue,
                labelBackgroundColor: white,
                label: 'Moodamay entry',
                onTap: () => setState(() => this.index = index),
                onLongPress: () => debugPrint('FIRST CHILD LONG PRESS'),
              ),
              SpeedDialChild(
                child: const Icon(CupertinoIcons.book),
                backgroundColor: pink,
                foregroundColor: babyblue,
                label: 'Diary entry',
                onTap: () => setState(() => this.index = index),
                onLongPress: () => debugPrint('FIRST CHILD LONG PRESS'),
              ),
            ],
          ),
          bottomNavigationBar: BubbleBottomBar(
            opacity: .2,

            currentIndex: index,
            onTap: (index) {
              setState(() => this.index = index);
            },
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            elevation: 8,
            fabLocation: BubbleBottomBarFabLocation.end, //new
            hasNotch: true, //new
            hasInk: true, //new, gives a cute ink effect
            inkColor:
                Colors.black12, //optional, uses theme color if not specified
            items: const <BubbleBottomBarItem>[
              BubbleBottomBarItem(
                  backgroundColor: Colors.red,
                  icon: Icon(
                    CupertinoIcons.house,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    CupertinoIcons.house,
                    color: Colors.red,
                  ),
                  title: Text("Home")),
              BubbleBottomBarItem(
                  backgroundColor: Colors.deepPurple,
                  icon: Icon(
                    Icons.book,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    CupertinoIcons.book,
                    color: Colors.deepPurple,
                  ),
                  title: Text("Diary")),
            ],
          ),
          // bottomNavigationBar: CurvedNavigationBar(
          //   backgroundColor: Colors.transparent,
          //   color: Colors.white,
          //   key: _bottomNavigationKey,
          //   index: index,
          //   items: <Widget>[
          //     Icon(
          //       Icons.add,
          //       size: 30,
          //       color: babyblue,
          //     ),
          //     Icon(Icons.list, size: 30, color: babyblue),
          //     Icon(Icons.compare_arrows, size: 30, color: babyblue),
          //   ],
          //   onTap: (index) {
          //     setState(() => this.index = index);
          //   },
          // ),
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
                                Text("$_name"!,
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
