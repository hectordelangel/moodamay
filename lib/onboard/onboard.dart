import 'dart:math';

import 'package:moodamay/home.dart';
import 'package:moodamay/onboard/onboard_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moodamay/custom_dialog.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constant.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  final username = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: 'assets/images/img-1.png',
      text: "Welcome to Moodamay!",
      desc: "My name is hectorin and I'll be your guide",
      bg: kblue,
      input: false,
      button: const Color(0xFF4756DF),
    ),
    OnboardModel(
      img: 'assets/images/img-2.png',
      text:
          "I would like us to get to know each other better, can you tell me your name?",
      desc: "",
      input: true,
      bg: kblue,
      button: Colors.white,
    ),
    OnboardModel(
      img: 'assets/images/img-3.png',
      text: "Let's get started!",
      desc: "",
      input: false,
      bg: kblue,
      button: const Color(0xFF4756DF),
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    username.dispose();
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    // ignore: avoid_print
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    // ignore: avoid_print
    print(prefs.getInt('onBoard'));
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (_) => _showDialog(),
    );
  }

  Widget _showDialog() {
    return AlertDialog(
      title: const Text('Tell me your name please :('),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        child: PageView.builder(
            itemCount: screens.length,
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return Material(
                child: Stack(
                  children: [
                    Container(
                      color: pink,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .92,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          )),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              screens[index].img,
                              height: 250,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * .02),
                              child: Text(screens[index].text,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    color: Color.fromRGBO(41, 50, 65, 1.0),
                                  )),
                            ),
                            .8.heightBox,
                            screens[index].input != true
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                .02),
                                    child: Text(
                                      screens[index].desc,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: 'Montserrat',
                                        color: Color.fromRGBO(41, 50, 65, 1.0),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                .02),
                                    child: Container(
                                      width: 200.0,
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            TextFormField(
                                              controller: username,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                hintText: "Write your name!",
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.7),
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.7),
                                                ),
                                                fillColor: Colors.white,
                                                filled: true,

                                                //fillColor: Colors.green
                                              ),
                                              validator: (String? value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please tell me :(';
                                                }
                                                return null;
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          ]),
                    ),
                    Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 45,
                              child: ListView.builder(
                                itemCount: screens.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 3.0),
                                          width: currentIndex == index ? 40 : 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: currentIndex == index
                                                ? jasmine
                                                : yellowcrayola,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ]);
                                },
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                // ignore: avoid_print
                                print(index);

                                if (index == screens.length - 1) {
                                  await _storeOnboardInfo();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Home()));
                                } else {
                                  if (screens[index].input) {
                                    if (username.text != "") {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString('name', username.text);
                                      _pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.bounceIn);
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CustomDialogBox(
                                              title:
                                                  "Tell me your name please :(",
                                              descriptions: "",
                                              text: "Okay!",
                                              img: Image.asset(
                                                  "assets/images/img-3.png"),
                                            );
                                          });
                                    }
                                  } else {
                                    _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.bounceIn);
                                  }
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 10),
                                decoration: BoxDecoration(
                                    color: babyblue,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Next",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: white)),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_sharp,
                                        color: white,
                                      )
                                    ]),
                              ),
                            )
                          ],
                        ).wFull(context),
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * .832,
                            bottom: MediaQuery.of(context).viewInsets.bottom)),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
