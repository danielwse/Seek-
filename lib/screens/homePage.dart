import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chat/user_sign_in_form.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    final homeIcon = SizedBox(
      height: 200.0,
      child: Image.asset(
        "assets/images/counselling.png",
        fit: BoxFit.contain,
      ),
    );

    final chatButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.brown,
      child: MaterialButton(
        minWidth: 170,
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        onPressed: moveToUserSignInPage,
        child: Text("Talk to Somebody",
            textAlign: TextAlign.center,
            style: GoogleFonts.indieFlower(
              fontSize: 25,
              color: Colors.white),
                //color: Colors.white, fontWeight: FontWeight.bold)
                ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seek',
          style: GoogleFonts.indieFlower(
              fontSize: 42,
              color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Center( 
          child: Column(
                //infinite height
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                SizedBox(height: 150),
                homeIcon,
                Text('Seek,' ,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSansCondensed(
                fontSize: 30,
                color: Colors.black),),
                Text('the safe space you need',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSansCondensed(
                fontSize: 30,
                color: Colors.black),),
                SizedBox(height: 20.0),
                chatButton,
                ]
          )
        ),
      ),
    );
  }

  moveToUserSignInPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserSignIn()));
  }
}