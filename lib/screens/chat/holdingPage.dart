import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth.dart';
import 'auth_provider.dart';

class HoldingPage extends StatelessWidget {
  const HoldingPage({this.onSignedOut});
  final VoidCallback onSignedOut;

  Future<void> _signOut(BuildContext context) async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

/*  @override
  _HoldingPageState createState() => _HoldingPageState();
}*/

//class _HoldingPageState extends State<HoldingPage> {


  @override
  Widget build(BuildContext context) {

    final chatButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.brown,
      child: MaterialButton(
        minWidth: 170,
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        onPressed: (){} /*moveToChatPage*/,
        child: Text("Chat with Seeker",
            textAlign: TextAlign.center,
            style: GoogleFonts.indieFlower(
              fontSize: 25,
              color: Colors.white),
                //color: Colors.white, fontWeight: FontWeight.bold)
                ),
      ),
    );

    final logoutButton = Material(
      elevation: 5.0,
      //borderRadius: BorderRadius.circular(30.0),
      color: Colors.red[700],
      child: MaterialButton(
        height: 5,
        minWidth: 100,
        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
        onPressed: () => _signOut(context),
        child: Text("Logout",
            textAlign: TextAlign.center,
            style: GoogleFonts.indieFlower(
              fontSize: 15,
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
                SizedBox(height: 230.0),
                Text('Please hold on' ,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSansCondensed(
                fontSize: 30,
                color: Colors.black),),
                Text('Matching you with a Seeker...',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSansCondensed(
                fontSize: 30,
                color: Colors.black),),
                SizedBox(height: 20.0),
                chatButton,
                SizedBox(height:270),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    logoutButton,
                    SizedBox(width:20)
                  ],),
                ]
          )
        ),
      ),
    );
  }

  /*void moveToChatPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChatPage()));
  }*/
}