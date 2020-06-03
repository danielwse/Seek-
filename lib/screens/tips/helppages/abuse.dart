import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seek/screens/tips/tips_homepage.dart';

class Abuse extends StatefulWidget {
  Abuse({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AbuseState createState() => _AbuseState();
}

class _AbuseState extends State<Abuse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[300],
          title: Text(
            'Tips',
            style: GoogleFonts.indieFlower(fontSize: 42, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: <Widget>[
          articleProvider(
              'https://www.verywellmind.com/identify-and-cope-with-emotional-abuse-4156673',
              'https://www.verywellmind.com/thmb/TBpPbUwMZz6XMSHAqGbJanaJCuw=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/identify-and-cope-with-emotional-abuse-4156673.png_V2-a315b1a6c140405ba9f65c85d5473647.png',
              'How to Identify and Cope With Emotional Abuse',
              'verywellmind'),
          articleProvider(
              'https://www.helpguide.org/articles/abuse/domestic-violence-and-abuse.htm',
              'https://www.helpguide.org/wp-content/uploads/domestic-abuse-768.jpg',
              'Domestic Violence and Abuse',
              'HelpGuide'),
          articleProvider(
              'https://www.aware.org.sg/information/dealing-with-family-violence/',
              'https://d2t1lspzrjtif2.cloudfront.net/wp-content/uploads/ogimage.png',
              'Dealing With Family Violence',
              'AWARE Singapore'),
          articleProvider(
              'https://www.msf.gov.sg/policies/Strong-and-Stable-Families/Supporting-Families/Family-Violence/Pages/default.aspx',
              'https://upload.wikimedia.org/wikipedia/en/1/1e/MSF%28SG%29_logo.jpg',
              'Family Violence',
              'MSF Singapore'),
          articleProvider(
              'https://www.psychologytoday.com/sg/blog/toxic-relationships/201706/the-truth-about-abusers-abuse-and-what-do',
              'https://seekvectorlogo.net/wp-content/uploads/2019/07/psychology-today-vector-logo.png',
              'The Truth About Abusers, Abuse, and What to Do',
              'Psychology Today'),
         
          
        ]))));
  }
}
