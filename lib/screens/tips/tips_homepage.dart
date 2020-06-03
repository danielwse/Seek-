import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:seek/screens/tips/helppages/stressed.dart';
import 'package:seek/screens/tips/helppages/isolation.dart';
import 'package:seek/screens/tips/helppages/fearful.dart';
import 'package:seek/screens/tips/helppages/anxious.dart';
import 'package:seek/screens/tips/helppages/negative.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:seek/screens/tips/helppages/abuse.dart';

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
          'I\'m Dealing With...',
          style: GoogleFonts.indieFlower(fontSize: 42, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
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
                "Stress",
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
                "Isolation & Loneliness",
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
                "Fear",
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
                "Anxiety",
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
                "Negativity",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              textColor: Colors.black,
            ),
            SimpleRoundButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Abuse()),
                );
              },
              backgroundColor: Colors.red[300],
              buttonText: Text(
                "Abuse",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              textColor: Colors.black,
            ),
          ])),
    ));
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

Widget articleProvider(
    String articleUrl, String imgUrl, String articleName, String source) {
  title(title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  subtitle(subTitle) {
    return Text(
      subTitle,
      style: TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.w200, color: Colors.grey[800]),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  thumbnail(imageUrl) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
        height: 50,
        width: 70,
        alignment: Alignment.center,
        fit: BoxFit.fill,
      ),
    );
  }

  rightIcon() {
    return Icon(
      Icons.keyboard_arrow_right,
      color: Colors.grey,
      size: 30.0,
    );
  }

  return Card(
      child: ListTile(
          title: title(articleName),
          subtitle: subtitle(source),
          leading: thumbnail(imgUrl),
          trailing: rightIcon(),
          contentPadding: EdgeInsets.all(5.0),
          onTap: () => _launchURL(articleUrl)));
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}
