import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Isolation extends StatefulWidget {
  Isolation({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _IsolationState createState() => _IsolationState();
}

class _IsolationState extends State<Isolation> {
  Widget articleProvider(
      String articleUrl, String imgUrl, String articleName) {
    return SizedBox(
        width: double.infinity,
        height: 100,
        child: FlatButton(
          shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.pink[200],
            onPressed: () {
              _launchURL(articleUrl);
            },
            child: Row(children: <Widget>[
              SizedBox(
                  width: 150,
                  child: ClipRRect(
                      child: Image.network(imgUrl),
                      borderRadius: BorderRadius.circular(200))),
                      SizedBox(
            width: 20,
          ),
          Expanded(
              child: Text(
                articleName,
            style: TextStyle(fontSize: 20),
          ))
            ])));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Tips',
            style: GoogleFonts.indieFlower(fontSize: 42, color: Colors.black),
          ),
        ),
        body: Center(
            child: Column(children: <Widget>[
          articleProvider(
              'https://www.healthhub.sg/live-healthy/584/mental_health_social_intelligence',
              'https://www.healthhub.sg/sites/assets/Assets/Article%20Images/support_groups_hands.jpg',
              '6 Ways to Improve Social Skills and Increase Social Intelligence'),
          
        ])));
  }
}
