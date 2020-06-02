import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seek/screens/tips/helppages/stressed.dart';
import 'package:seek/screens/tips/helppages/isolation.dart';
import 'package:seek/screens/tips/helppages/fearful.dart';
import 'package:seek/screens/tips/helppages/anxious.dart';
import 'package:seek/screens/tips/helppages/negative.dart';

class TipsPage extends StatefulWidget {
  TipsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'I\'m Feeling...',
          style: GoogleFonts.indieFlower(fontSize: 42, color: Colors.black),
        ),
      ),
      body: Center(
          child: Column(
              //infinite height
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
            SizedBox(height: 10),
            SimpleRoundButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Stressed()),
                );
              },
              backgroundColor: Colors.blue[200],
              buttonText: Text(
                "Stressed",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              textColor: Colors.black,
            ),
            SimpleRoundButton(
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Isolation()),
                );
              },
              backgroundColor: Colors.pink[200],
              buttonText: Text(
                "Isolated",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              textColor: Colors.black,
            ),
            SimpleRoundButton(
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Fearful()),
                );
              },
              backgroundColor: Colors.purple[300],
              buttonText: Text(
                "Fearful",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              textColor: Colors.black,
            ),
            SimpleRoundButton(
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Anxious()),
                );
              },
              backgroundColor: Colors.green[200],
              buttonText: Text(
                "Anxious",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              textColor: Colors.black,
            ),
            SimpleRoundButton(
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Negative()),
                );
              },
              backgroundColor: Colors.cyan[300],
              buttonText: Text(
                "Negative",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              textColor: Colors.black,
            ),
            SizedBox(height: 30),
          ])),
    );
  }
}

class SimpleRoundButton extends StatelessWidget {
  final Color backgroundColor;
  final Text buttonText;
  final Color textColor;
  final Function onPressed;

  SimpleRoundButton(
      {this.backgroundColor, this.buttonText, this.textColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              splashColor: this.backgroundColor,
              color: this.backgroundColor,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: buttonText,
                  ),
                ],
              ),
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
