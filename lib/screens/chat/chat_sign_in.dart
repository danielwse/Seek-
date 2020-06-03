import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seek/screens/chat/auth.dart';
import 'package:seek/screens/chat/root_page.dart';
import 'user_sign_in_form.dart';

class ChatSignIn extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Have a Chat',
          style: TextStyle(fontSize: 30.0, wordSpacing: 5.0),
        ),
      ),
      body: _bodyContent(context),
    );
  }
  
  Widget _bodyContent(BuildContext context) {

    final chatImage = SizedBox(
      height: 200.0,
      child: Image.asset(
        "assets/images/chatSignInIcon.png",
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
        onPressed: () => _userSignIn(context),
        child: Text("Talk to Somebody",
            textAlign: TextAlign.center,
            style: GoogleFonts.indieFlower(
              fontSize: 25,
              color: Colors.white),
                //color: Colors.white, fontWeight: FontWeight.bold)
                ),
      ),
    );

    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 170.0),
            chatImage,
            SizedBox(height: 50.0),
            Container(
              margin: EdgeInsets.only(
                left: 60,
                right: 60,
              ),
              child: chatButton,
            ),
            Spacer(),
            Container(
              child: FlatButton( 
                child: Text(
                  'Click here to login if you are a counsellor or trained personnel',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onPressed: () => _counsellorSignIn(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _userSignIn(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => UserSignIn(),
    ));
  }

  void _counsellorSignIn(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => RootPage(
        auth: Auth(),
      ),
    ));
  }
}