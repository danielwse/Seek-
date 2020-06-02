import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'holdingPage.dart';

class CounsellorSignIn extends StatefulWidget {
  CounsellorSignIn({Key key, this.title}) : super(key: key);
//hi
  final String title;

  @override
  _CounsellorSignInState createState() => _CounsellorSignInState();
}

class _CounsellorSignInState extends State<CounsellorSignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  TextStyle style = GoogleFonts.chelseaMarket(
    fontSize: 20,);

  @override
  Widget build(BuildContext context) {

    final counsellorIcon = SizedBox(
      height: 200.0,
      child: Image.asset(
        "assets/images/heart.png",
        fit: BoxFit.contain,
      ),
    );

    final emailField = TextFormField(
      obscureText: false,
      style: GoogleFonts.roboto(
        fontSize: 17,
        color: Colors.black,
      ),
      validator: (input) {
        if (input.isEmpty) {
          return 'Please key in your email';
        }
        return null;
      },
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
      onSaved: (input) => _email = input,
    );

    final passwordField = TextFormField(
      obscureText: true,
      style: GoogleFonts.roboto(
        fontSize: 17,
        color: Colors.black,
      ),
      validator: (input) {
        if (input.isEmpty) {
          return "Please key in your password";
        }
        if (input.length < 6) {
          return 'Longer password please';
        }
        return null;
      },
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
      onSaved: (input) => _password = input,
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.brown,
      child: MaterialButton(
        minWidth: 170,
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        onPressed: logIn,
        child: Text("Login",
            textAlign: TextAlign.center,
            style: GoogleFonts.indieFlower(
              fontSize: 20,
              color: Colors.white),
                //color: Colors.white, fontWeight: FontWeight.bold)
                ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Counsellor Login',
          style: TextStyle(fontSize: 30.0, wordSpacing: 5.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                //infinite height
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 70.0),
                  counsellorIcon,
                  SizedBox(height: 20.0),
                  emailField,
                  SizedBox(height: 20.0),
                  passwordField,
                  SizedBox(height: 20.0),
                  loginButton,
                  SizedBox(height: 20.0),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: _email, password: _password))
            .user;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HoldingPage()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}