import 'package:flutter/material.dart';
import 'package:seek/screens/chat/auth.dart';
import 'holdingPage.dart';
import 'counsellor_sign_in.dart';

class RootPage extends StatelessWidget {
  final BaseAuth auth;
  
  RootPage({
    @required this.auth,
  });
/*
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notDetermined;
*/  
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
  
/*
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.auth.currentUser().then((User userId) {
      setState(() {
        authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notDetermined:
        return _buildWaitingScreen();
      case AuthStatus.notSignedIn:
        return CounsellorSignIn(
          onSignedIn: _signedIn,
          auth: widget.auth,
        );
      case AuthStatus.signedIn:
        return HoldingPage(
          onSignedOut: _signedOut,
          auth: widget.auth,
        );
    }
    return null;
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
  */
}