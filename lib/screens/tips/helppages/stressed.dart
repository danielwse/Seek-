import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seek/screens/tips/tips_homepage.dart';

class Stressed extends StatefulWidget {
  Stressed({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _StressedState createState() => _StressedState();
}

class _StressedState extends State<Stressed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue[200],
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
              'https://www.healthhub.sg/live-healthy/1087/8-quick-things-you-can-do-to-de-stress-right-now',
              'https://www.healthhub.sg/sites/assets/Assets/Categories/Mind%20N%20Balance/stretching-office-worker.jpg',
              '8 Quick Things You Can Do To De-Stress',
              'Health Hub'),
          articleProvider(
              'https://www.healthhub.sg/live-healthy/1713/thrive-not-just-survive-at-the-workplace',
              'https://www.healthhub.sg/sites/assets/Assets/Categories/Mind%20N%20Balance/the-tailor-who-talks-about-denim.jpg',
              'Thriving at Work',
              'Health Hub'),
          articleProvider(
              'https://www.healthhub.sg/live-healthy/1492/mental-toughness-is-like-a-fruit-bowl',
              'https://www.healthhub.sg/sites/assets/Assets/Categories/Mind%20N%20Balance/adult-woman-hold-in-hands-ripe-fruit-orange-papaya.jpg',
              'Resilience Is Like A Fruit Bowl',
              'Health Hub'),
          articleProvider(
              'https://www.verywellmind.com/stress-management-4157211',
              'https://www.verywellmind.com/thmb/HwvPtBACMxUUf45ovRKudPnCKS0=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/that-s-it--i-m-done--936117884-30b9067edcac4976a48d006a4f0f88b7.jpg',
              'An Overview of Stress Management',
              'verywellmind'),
          articleProvider(
              'https://www.health.harvard.edu/mind-and-mood/best-ways-to-manage-stress',
              'https://d2ebzu6go672f3.cloudfront.net/media/content/images/L0215c-1.jpg',
              'Best ways to manage stress',
              'Harvard Health'),
          articleProvider(
              'https://www.healthhub.sg/live-healthy/1782/stress-o-s-how-do-you-cope-with-stress',
              'https://www.healthhub.sg/sites/assets/Assets/Categories/Body%20Care/1089_images_bannerimage.jpg',
              'Stress-O-S! How to Cope With Stress?',
              'Health Hub'),
          articleProvider(
              'https://www.healthhub.sg/live-healthy/1453/top-up-your-happiness',
              'https://www.healthhub.sg/sites/assets/Assets/Categories/Mind%20N%20Balance/two-young-asian-female-friends-walking-on-the-beach.jpg',
              'The Keys to Happiness: Mindfulness and Positive Experiences',
              'Health Hub'),
          articleProvider(
              'https://www.samhealth.org.sg/understanding-mental-health/what-is-mental-wellness/coping-with-stress/',
              'https://www.samhealth.org.sg/client/samhealth/wp-content/uploads/2018/03/stress-illus1c.png',
              'Coping With Stress',
              'Singapore Association for Mental Health')
        ]))));
  }
}
