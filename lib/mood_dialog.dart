import 'dart:ui';
import 'package:moodamay/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomMoodDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;

  const CustomMoodDialogBox(
      {Key? key,
      required this.title,
      required this.descriptions,
      required this.text,
      required this.img})
      : super(key: key);

  @override
  _CustomMoodDialogBoxState createState() => _CustomMoodDialogBoxState();
}

class _CustomMoodDialogBoxState extends State<CustomMoodDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.45,
          padding: EdgeInsets.only(
              left: padding,
              top: avatarRadius + padding,
              right: padding,
              bottom: padding),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: white,
            borderRadius: BorderRadius.circular(padding),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[500]),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              Align(
                alignment: Alignment.bottomRight,
              ),
            ],
          ),
        ),
        Positioned(
          height: MediaQuery.of(context).size.height * 0.2,
          left: padding,
          right: padding,
          top: MediaQuery.of(context).size.height * -0.03,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: avatarRadius,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(avatarRadius)),
              child: widget.img,
            ),
          ),
        ),
      ],
    );
  }
}
