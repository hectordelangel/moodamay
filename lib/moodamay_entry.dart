import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodamay/Models/mood_selector.dart';
import 'package:moodamay/Models/user_mood.dart';
import 'package:moodamay/services/datebase_handler.dart';
import '../constant.dart';
import 'home.dart';
import 'navigation_bar.dart';

class Mood extends StatefulWidget {
  const Mood({Key? key}) : super(key: key);

  @override
  _MoodState createState() => _MoodState();
}

class _MoodState extends State<Mood> {
  double _currentSliderValue = 3;
  final _NoteInputController = TextEditingController();
  late DatabaseHandler handler;
  @override
  void initState() {
    this.handler = DatabaseHandler();
    super.initState();
  }

  Future<int> addMood() async {
    String date = DateFormat('dd-MM-yyyy kk:mm a').format(DateTime.now());
    UserMood mood = UserMood(
        mood_name: moods[_currentSliderValue.toInt()].mood,
        mood_image: moods[_currentSliderValue.toInt()].img,
        date: date,
        note: _NoteInputController.text);
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
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    TextFormField(
                      autocorrect: false,
                      cursorColor: babyblue,
                      controller: _NoteInputController,
                      maxLines: 5,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: babyblue),
                        prefixIcon: Icon(
                          Icons.book,
                          color: babyblue,
                        ),
                        labelText: "Note",
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                            borderSide: BorderSide(
                              color: babyblue,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            addMood();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NavigationBar()));
          },
          label: const Text('Save'),
          icon: const Icon(Icons.arrow_forward_ios),
          backgroundColor: pink,
        ),
      ),
    );
  }
}
