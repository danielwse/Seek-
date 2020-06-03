import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seek/screens/chat/auth.dart';
import 'holdingPage.dart';

class CounsellorSignIn extends StatefulWidget {
  final BaseAuth auth;

  CounsellorSignIn({
    @required this.auth,
  });

  @override
  _CounsellorSignInState createState() => _CounsellorSignInState();
}

enum FormType {
  login,
}

class _CounsellorSignInState extends State<CounsellorSignIn> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _email, _password;
  TextStyle style = GoogleFonts.chelseaMarket(
    fontSize: 20,);
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      print(_password);
      try {

        if (_formType == FormType.login) {
          final User userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: $userId.uid');
          print(userId.uid);
          Firestore.instance.collection('counsellors').document(userId.uid).setData({
            "email": _email,
            "timestamp": FieldValue.serverTimestamp()
          });

          Navigator.push(
            context, MaterialPageRoute(builder: (context) => HoldingPage(auth: widget.auth,)));
        }
      } catch (e) {
        print("E");
        print('Error: $e');
      }
    }
  }

  /*void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }*/

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

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
        onPressed: validateAndSubmit,
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
        centerTitle: true,
        title: Text(
          'Counsellor Login',
          style: GoogleFonts.montserrat(
            fontSize: 32,
            color: Colors.white
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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

  /*Future<void> logIn() async {
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
  }*/
}