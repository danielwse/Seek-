import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seek/screens/tips/tips_homepage.dart';

class Isolation extends StatefulWidget {
  Isolation({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _IsolationState createState() => _IsolationState();
}

class _IsolationState extends State<Isolation> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.pink[200],
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
              'https://www.bbc.com/news/world-52196816',
              'https://ichef.bbci.co.uk/news/976/cpsprodpb/B711/production/_111756864_luciaburicelli.jpg',
              'Coronavirus: How to cope with living alone in self-isolation',
              'BBC'),
              articleProvider(
              'https://www.healthhub.sg/live-healthy/1453/top-up-your-happiness',
              'https://www.healthhub.sg/sites/assets/Assets/Categories/Mind%20N%20Balance/two-young-asian-female-friends-walking-on-the-beach.jpg',
              'The Keys to Happiness: Mindfulness and Positive Experiences',
              'Health Hub'),
                articleProvider(
              'https://www.webmd.com/lung/handle-isolation-and-anxiety#1',
              'https://seekvectorlogo.net/wp-content/uploads/2019/07/psychology-today-vector-logo.png',
              'How to Handle Coronavirus Isolation and Anxiety',
              'webmd'),
              articleProvider(
              'https://www.verywellmind.com/how-to-cope-with-loneliness-during-coronavirus-4799661',
              'https://www.verywellmind.com/thmb/oKSDAAEjgbLI63dB0zhYzvdotPA=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/how-to-cope-with-loneliness-during-coronavirus-4799661-ADD-FINAL-1600x900-901ad574317a42afad714d46d13892a7.png',
              'How to Cope With Loneliness During the Coronavirus Pandemic',
              'verywellmind'),
               articleProvider(
              'https://www.psychologytoday.com/sg/blog/click-here-happiness/201902/feeling-lonely-discover-18-ways-overcome-loneliness',
              'https://seekvectorlogo.net/wp-content/uploads/2019/07/psychology-today-vector-logo.png',
              'Feeling Lonely? Discover 18 Ways to Overcome Loneliness',
              'Psychology Today'),
              articleProvider(
              'https://www.talkspace.com/blog/how-i-overcame-loneliness/',
              'https://www.talkspace.com/blog/wp-content/uploads/2017/10/overcoming-loneliness-man-feature_1320W_JR-1-1024x694.png',
              'How I Overcame Loneliness',
              'talkspace'),
                articleProvider(
              'https://lifelabs.psychologies.co.uk/users/57632-irina-sanchez-de-lozada/posts/42276-how-i-overcame-loneliness-and-why-we-should-talk-about-it-more',
              'https://miro.medium.com/max/7016/1*H2pMY15Sxdwj8pzIQWeUSg.jpeg',
              'How I Overcame Loneliness and Why We Should Talk About It More!',
              'lifelabs'),
              articleProvider(
              'https://thoughtcatalog.com/amira-abdel-fadil/2019/11/when-youre-feeling-lonely-remember-this/',
              'https://thoughtcatalog.files.wordpress.com/2017/12/photo-1519238425857-d6922ed3d613.jpg?resize=1080,715&quality=95&strip=all&crop=1',
              'When You’re Feeling Lonely, Remember This',
              'Thought Catalog'),

          
        ]))));
  }
}
