import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seek/screens/tips/tips_homepage.dart';

class Anxious extends StatefulWidget {
  Anxious({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AnxiousState createState() => _AnxiousState();
}

class _AnxiousState extends State<Anxious> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green[200],
          title: Text(
            'Tips',
            style: GoogleFonts.montserrat(
            fontSize: 32,
            color: Colors.white
          ),
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: <Widget>[
          articleProvider(
              'https://www.healthhub.sg/live-healthy/1713/thrive-not-just-survive-at-the-workplace',
              'https://www.healthhub.sg/sites/assets/Assets/Categories/Mind%20N%20Balance/the-tailor-who-talks-about-denim.jpg',
              'Thriving at Work',
              'Health Hub'),
          articleProvider(
              'https://www.healthhub.sg/live-healthy/1453/top-up-your-happiness',
              'https://www.healthhub.sg/sites/assets/Assets/Categories/Mind%20N%20Balance/two-young-asian-female-friends-walking-on-the-beach.jpg',
              'The Keys to Happiness: Mindfulness and Positive Experiences',
              'Health Hub'),
          articleProvider(
              'https://www.verywellmind.com/manage-your-anxiety-2584184',
              'https://www.verywellmind.com/thmb/KXN91Xp2HtPi14EViHh3T7lJSyg=/220x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/Illo_PanicDisorder-cf02b68e93144646aab8456c8c8f75c8.png',
              'Simple Steps to Help You Cope With Anxiety',
              'verywellmind'),
          articleProvider(
              'https://www.psycom.net/living-with-anxiety/',
              'https://static.psycom.net/wp-content/uploads/2018/10/design-desk-display-313690-1-1280x429.jpg',
              'Living with Anxiety: How to Cope',
              'PSYCOM'),
          articleProvider(
              'https://adaa.org/tips',
              'https://miro.medium.com/max/7016/1*H2pMY15Sxdwj8pzIQWeUSg.jpeg',
              'Tips to Manage Anxiety and Stress',
              'Anxiety and Depression Association of America'),
          articleProvider(
              'https://www.psycom.net/facing-your-fear',
              'https://static.psycom.net/wp-content/uploads/2018/08/casey-horner-460825-unsplash-1280x429.jpg',
              'Facing Your Fears: Tips to Overcoming Anxiety and Phobias',
              'PSYCOM'),
          articleProvider(
              'https://www.verywellmind.com/breaking-the-anxiety-cycle-1392987',
              'https://www.verywellmind.com/thmb/ysCcLhsVXsQm4ueN06jX9LcN-AE=/700x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/woman-thinking-deeply-by-the-window-998440120-5b4c828dc9e77c00376ec5c7.jpg',
              'How to Break the Anxiety Cycle and Overcome Worry',
              'verywellmind'),
          articleProvider(
              'https://thoughtcatalog.com/kirsten-corley/2017/01/when-your-anxiety-is-getting-the-best-of-you-read-this/',
              'https://thoughtcatalog.files.wordpress.com/2018/07/27925309194_2d569a6a47_k.jpg?w=1920&h=1278&crop=1&resize=1920,1278&quality=95&strip=all',
              'When Your Anxiety Is Getting The Best Of You, Read This',
              'Thought Catalog'),
        ]))));
  }
}
