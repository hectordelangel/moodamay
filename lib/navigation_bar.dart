import 'package:flutter/material.dart';
import 'dart:math';
import "package:cupertino_icons/cupertino_icons.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:moodamay/diary.dart';
import 'package:moodamay/home.dart';
import 'package:moodamay/journal_entry.dart';
import 'package:moodamay/moodamay_entry.dart';
import '../constant.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    currentPage = 0;
  }

  var isDialOpen = ValueNotifier<bool>(false);

  var screens = [Home(), Diary()];

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
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Mood()));
                },
                onLongPress: () => debugPrint('FIRST CHILD LONG PRESS'),
              ),
              SpeedDialChild(
                child: const Icon(CupertinoIcons.book),
                backgroundColor: pink,
                foregroundColor: babyblue,
                label: 'Diary entry',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Journal()));
                },
                onLongPress: () => debugPrint('FIRST CHILD LONG PRESS'),
              ),
            ],
          ),
          bottomNavigationBar: BubbleBottomBar(
            opacity: .2,

            currentIndex: currentPage,
            onTap: (index) => setState(
                () => {currentPage = index!, debugPrint(index.toString())}),

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
                  title: Text("Journal")),
            ],
          ),
          body: screens[currentPage]),
    );
  }
}
