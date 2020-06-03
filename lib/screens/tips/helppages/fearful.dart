import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seek/screens/tips/tips_homepage.dart';

class Fearful extends StatefulWidget {
  Fearful({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FearfulState createState() => _FearfulState();
}

class _FearfulState extends State<Fearful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[300],
          title: Text(
            'Tips',
            style: GoogleFonts.indieFlower(fontSize: 42, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: <Widget>[
          articleProvider(
              'https://medium.com/@seanclarke974/the-story-of-overcoming-my-fear-944985cd22b2',
              'https://miro.medium.com/max/1120/1*NxTATHSLR4OHNYV7P58Zhg.png',
              'The Story Of Overcoming My Fear',
              'Medium'),
          articleProvider(
              'https://www.healthhub.sg/live-healthy/1453/top-up-your-happiness',
              'https://www.healthhub.sg/sites/assets/Assets/Categories/Mind%20N%20Balance/two-young-asian-female-friends-walking-on-the-beach.jpg',
              'The Keys to Happiness: Mindfulness and Positive Experiences',
              'Health Hub'),
          articleProvider(
              'https://www.psycom.net/facing-your-fear',
              'https://static.psycom.net/wp-content/uploads/2018/08/casey-horner-460825-unsplash-1280x429.jpg',
              'Facing Your Fears: Tips to Overcoming Anxiety and Phobias',
              'PSYCOM'),
          articleProvider(
              'https://www.psychologytoday.com/us/blog/transcending-the-past/201708/coping-fear-face-it-understand-it-overcome-it',
              'https://cdn.psychologytoday.com/sites/default/files/styles/image-article_inline_full_caption/public/field_blog_entry_images/2017-08/buddha-mara.jpg?itok=xSEEHv2w',
              'Coping with Fear: Face It, Understand It, Overcome It',
              'Psychology Today'),
          articleProvider(
              'https://www.theguardian.com/lifeandstyle/2019/apr/08/how-i-overcame-my-fear-of-public-speaking-and-learned-to-love-it',
              'https://i.guim.co.uk/img/media/118868236dc79517e16e5b2058ceef0b4a30edb4/0_222_4983_2990/master/4983.jpg?width=605&quality=45&auto=format&fit=max&dpr=2&s=81512c595734b4c04b17904dbeccd78d',
              'How I overcame my fear of public speaking – and learned to love it',
              'The Guardian'),
          articleProvider(
              'https://littlegreenseedling.com/2018/11/07/overcoming-fear-self-doubt/',
              'https://i0.wp.com/littlegreenseedling.com/wp-content/uploads/2018/11/abyss-2036211_1920.jpg?resize=960%2C540&ssl=1',
              'How I Overcame Fear to Start Living My Best Life',
              'Little Green Seedling'),
          articleProvider(
              'https://www.jackcanfield.com/blog/overcoming-fear/',
              'https://miro.medium.com/max/7016/1*H2pMY15Sxdwj8pzIQWeUSg.jpeg',
              'How to Overcome the Fears That You Create',
              'JackCanfield'),
          articleProvider(
              'https://www.psychologytoday.com/us/blog/insight-therapy/201009/overcoming-fear-the-only-way-out-is-through',
              'https://seekvectorlogo.net/wp-content/uploads/2019/07/psychology-today-vector-logo.png',
              'Overcoming Fear: The Only Way Out is Through',
              'Psychology Today')
        ]))));
  }
}
