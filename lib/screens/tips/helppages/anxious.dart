import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Anxious extends StatefulWidget {
  Anxious({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AnxiousState createState() => _AnxiousState();
}

class _AnxiousState extends State<Anxious> {
  Widget articleProvider(
      String articleUrl, String imgUrl, String articleName) {
    return SizedBox(
        width: double.infinity,
        height: 100,
        child: FlatButton(
          shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.green[200],
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
              'https://www.healthhub.sg/live-healthy/1713/thrive-not-just-survive-at-the-workplace',
              'https://www.healthhub.sg/sites/assets/Assets/Categories/Mind%20N%20Balance/the-tailor-who-talks-about-denim.jpg',
              'Thriving at Work'),
          
        ])));
  }
}
