import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Stressed extends StatefulWidget {
  Stressed({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _StressedState createState() => _StressedState();
}

class _StressedState extends State<Stressed> {
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
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w200, color: Colors.grey[800]),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
 
  thumbnail(imageUrl) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: Image.network(
        imageUrl,
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
 
  Widget articleProvider(
      String articleUrl, String imgUrl, String articleName, String source) {
    return Card(
      child:ListTile(
          title: title(articleName),
          subtitle: subtitle(source),
          leading: thumbnail(imgUrl),
          trailing: rightIcon(),
          contentPadding: EdgeInsets.all(5.0),
          onTap: () => _launchURL(articleUrl)
        ));
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
          backgroundColor: Colors.blue[200],
          title: Text(
            'Tips',
            style: GoogleFonts.indieFlower(fontSize: 42, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: <Widget>[
          articleProvider(
              'https://www.healthhub.sg/live-healthy/1087/8-quick-things-you-can-do-to-de-stress-right-now',
              'https://www.healthhub.sg/sites/assets/Assets/Categories/Mind%20N%20Balance/stretching-office-worker.jpg',
              '8 Quick Things You Can Do To De-Stress',
              'healthhub.sg'),
          articleProvider(
              'https://www.healthhub.sg/live-healthy/1713/thrive-not-just-survive-at-the-workplace',
              'https://www.healthhub.sg/sites/assets/Assets/Categories/Mind%20N%20Balance/the-tailor-who-talks-about-denim.jpg',
              'Thriving at Work',
              'healthhub.sg'),
          articleProvider(
              'https://www.healthhub.sg/live-healthy/1492/mental-toughness-is-like-a-fruit-bowl',
              'https://www.healthhub.sg/sites/assets/Assets/Categories/Mind%20N%20Balance/adult-woman-hold-in-hands-ripe-fruit-orange-papaya.jpg',
              'Resilience Is Like A Fruit Bowl',
              'healthhub.sg'),
          articleProvider(
              'https://www.verywellmind.com/stress-management-4157211',
              'https://www.verywellmind.com/thmb/HwvPtBACMxUUf45ovRKudPnCKS0=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/that-s-it--i-m-done--936117884-30b9067edcac4976a48d006a4f0f88b7.jpg',
              'An Overview of Stress Management',
              'verywellmind.com'),
          articleProvider(
              'https://www.health.harvard.edu/mind-and-mood/best-ways-to-manage-stress',
              'https://d2ebzu6go672f3.cloudfront.net/media/content/images/L0215c-1.jpg',
              'Best ways to manage stress',
              'health.harvard.edu'),
        ]))));
  }
}
