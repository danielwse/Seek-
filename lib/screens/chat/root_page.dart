import 'package:flutter/material.dart';
import 'package:seek/screens/chat/auth.dart';
import 'holdingPage.dart';
import 'counsellor_sign_in.dart';

class RootPage extends StatelessWidget {
  final BaseAuth auth;
  
  RootPage({
    @required this.auth,
  });
 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return CounsellorSignIn(
              auth: auth,
            );
          }
          return HoldingPage(
            auth: auth,
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}