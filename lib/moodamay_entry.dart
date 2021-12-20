import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moodamay/Models/mood_selector.dart';
import 'package:moodamay/Models/user_mood.dart';
import 'package:moodamay/services/datebase_handler.dart';
import '../constant.dart';

class Mood extends StatefulWidget {
  const Mood({Key? key}) : super(key: key);

  @override
  _MoodState createState() => _MoodState();
}

class _MoodState extends State<Mood> {
  double _currentSliderValue = 3;
  late DatabaseHandler handler;
  @override
  void initState() {
    this.handler = DatabaseHandler();
    super.initState();
  }

  Future<int> addMood() async {
    UserMood mood = UserMood(
        mood_name: moods[_currentSliderValue.toInt()].mood,
        mood_image: moods[_currentSliderValue.toInt()].img,
        date: DateTime.now().toString(),
        note: "Probando");
    return await this.handler.insertMood(mood);
  }

  List<MoodSelectorModel> moods = <MoodSelectorModel>[
    MoodSelectorModel(img: 'assets/images/angry.gif', mood: 'Angry'),
    MoodSelectorModel(img: 'assets/images/sad.gif', mood: 'Sad'),
    MoodSelectorModel(img: 'assets/images/annoyed.gif', mood: 'Annoyed'),
    MoodSelectorModel(img: 'assets/images/happy.gif', mood: 'Happy'),
    MoodSelectorModel(img: 'assets/images/surprised.gif', mood: 'Surprised'),
    MoodSelectorModel(img: 'assets/images/silly.gif', mood: 'Silly'),
    MoodSelectorModel(img: 'assets/images/flirty.gif', mood: 'Flirty')
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kblue,
          foregroundColor: babyblue,
          title: Text(
            'Select your mood!',
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: Container(
          color: white,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Image.asset(
                      moods[_currentSliderValue.toInt()].img,
                      height: MediaQuery.of(context).size.height * .35,
                    ),
                    Text(moods[_currentSliderValue.toInt()].mood,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: babyblue,
                        )),
                    Slider(
                      value: _currentSliderValue,
                      thumbColor: kblue,
                      inactiveColor: Color.fromRGBO(205, 180, 219, .5),
                      activeColor: kblue,
                      max: moods.length.toDouble() - 1,
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                          debugPrint(_currentSliderValue.toString());
                        });
                      },
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            addMood();
            debugPrint("funciono");
          },
          label: const Text('Save'),
          icon: const Icon(Icons.thumb_up),
          backgroundColor: Colors.pink,
        ),
      ),
    );
  }
}
