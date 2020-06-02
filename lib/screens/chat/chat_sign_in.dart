import 'package:flutter/material.dart';
import 'user_sign_in_form.dart';
import 'counsellor_sign_in.dart';

class ChatSignIn extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyContent(context),
      backgroundColor: Colors.cyanAccent[100],
    );
  }
  
  Widget _bodyContent(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Spacer(),
            Container(
              margin: EdgeInsets.only(
                left: 60,
                right: 60,
              ),
              child: RaisedButton(
                child: Text(
                  'Talk to somebody',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () => _userSignIn(context),
                color: Color(0xFF04C9F1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(24.0),
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              child: FlatButton( 
                child: Text(
                  'Click here to login if you are a counsellor or volunteer',
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
      builder: (context) => CounsellorSignIn(),
    ));
  }
}