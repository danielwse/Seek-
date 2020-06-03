import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seek/screens/tips/tips_homepage.dart';

class Negative extends StatefulWidget {
  Negative({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NegativeState createState() => _NegativeState();
}

class _NegativeState extends State<Negative> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.cyan[300],
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
              'https://www.healthhub.sg/live-healthy/1453/top-up-your-happiness',
              'https://www.healthhub.sg/sites/assets/Assets/Categories/Mind%20N%20Balance/two-young-asian-female-friends-walking-on-the-beach.jpg',
              'The Keys to Happiness: Mindfulness and Positive Experiences',
              'Health Hub'),
          articleProvider(
              'https://www.healthhub.sg/live-healthy/265/managing_negative_emotions',
              'https://www.healthhub.sg/sites/assets/Assets/Categories/Mind%20N%20Balance/young-female-caregiver-helping-senior-woman.jpg?Width=970&Height=405',
              'Managing Negative Emotions',
              'Health Hub'),
          articleProvider(
              'https://positivepsychology.com/negative-emotions/',
              'https://positivepsychology.com/wp-content/uploads/1_negative-emotions-300x150.jpg',
              'What are Negative Emotions and How to Control Them?',
              'Positive Psychology'),
          articleProvider(
              'https://www.psychologytoday.com/us/blog/in-practice/201802/5-overarching-principles-coping-negative-emotions',
              'https://seekvectorlogo.net/wp-content/uploads/2019/07/psychology-today-vector-logo.png',
              '5 Overarching Principles for Coping With Negative Emotions',
              'Psychology Today'),
              articleProvider(
              'https://www.positivityblog.com/overcome-negative-thoughts/',
              'https://miro.medium.com/max/7016/1*H2pMY15Sxdwj8pzIQWeUSg.jpeg',
              '12 Powerful Tips to Overcome Negative Thoughts (and Embrace Positive Thinking)',
              'Positivity Blog'),
              articleProvider(
              'https://medium.com/im-arti/how-i-overcame-negative-thoughts-f89161596653',
              'https://miro.medium.com/proxy/0*upSJ1JcuH5p5x7_I.',
              'How I Overcame Negative Thoughts',
              'Medium'),
              articleProvider(
              'https://www.wellbeing.com.au/mind-spirit/mind/gratitude-experiment-overcame-negativity-one-simple-step.html',
              'https://da28rauy2a860.cloudfront.net/wellbeing/wp-content/uploads/2017/06/02165102/photo-1429277005502-eed8e872fe522.jpg',
              'How I overcame negativity with one simple step',
              'Wellbeing'),
        ]))));
  }
}
