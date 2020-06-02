import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class UserSignIn extends StatefulWidget {
  @override
  _UserSignInState createState() => _UserSignInState();
}

class _UserSignInState extends State<UserSignIn> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  bool _phoneValid = false;
  bool _nameValid = false;
  bool _showNameError = false;
  bool _showPhoneError = false;
  bool _showSOS = false;
  bool _showAbuse = false;
  bool _showDistress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(35),
            child: Column(
              children: <Widget>[
                _nameTextField(),
                SizedBox(height: 20.0),
                _phoneTextField(),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  child: Text(
                      "Please note: Phone number is only required for verification purposes and for emergency situations.Your data will only be retained for the duration of the chat. Thank you."
                  ),
                  padding: EdgeInsets.all(5.0),
                ),
                Offstage(
                  offstage: !(_phoneValid && _nameValid),
                  child: Container( 
                    child: Column(
                      children: <Widget> [
                        SizedBox(height: 15.0),
                        suicidalQns(),
                        Offstage(
                          offstage: !_showSOS,
                          child: Container( 
                            color: Colors.grey[100],
                            child: Text(
                              sosText,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        abuseQns(),
                        Offstage(
                          offstage: !_showAbuse,
                          child: Container( 
                            color: Colors.grey[100],
                            child: Text(
                              abuseText,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        distressQns(),
                      ],
                    ),
                    padding: EdgeInsets.all(2.0),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Spacer(),
                    RaisedButton(
                      color: Colors.amber,
                      child: Text("Back"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Spacer(),
                    RaisedButton(
                      color: Colors.green,
                      child: Text((_showSOS || _showAbuse) ? "Please direct me \nto SOS hotline" : "Prefer to talk \nthrough phone",
                      textAlign: TextAlign.center,
                      ),
                      onPressed: () => _call(),
                    ),
                    Spacer(),
                    Offstage(
                      offstage: !(_suicideAns && _abuseAns && _distressAns),
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text("Enter\nsafe chat",
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _call() {
    int nationalCareHotline = 18002026868;
    int sosHotline = 18002214444;
    int hotline = (_showSOS || _showAbuse) ? sosHotline : nationalCareHotline;
    launch("tel:$hotline");
  }

  void _updateState() {
    setState(() {});
  }

  TextField _nameTextField() {
    return TextField(
      style: GoogleFonts.roboto(
        fontSize: 17,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: "Display name",
        hintText: "Name to be addresed by",
        errorText: _showNameError ? "Name cannot be empty" : null,
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      controller: _nameController,
      textInputAction: TextInputAction.next,
      focusNode: _nameFocusNode,
      onChanged: (name) => _updateState(),
      onEditingComplete: () => _nameEditingComplete(),
    );
  }

  TextField _phoneTextField() {
    return TextField(
      style: GoogleFonts.roboto(
        fontSize: 17,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: "Phone number",
        hintText: "Local phone number",
        errorText: _showPhoneError ? "Please key in a valid phone number" : null,
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      controller: _phoneController,
      keyboardType: TextInputType.number,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      textInputAction: TextInputAction.next,
      focusNode: _phoneFocusNode,
      onChanged: (name) => _updateState(),
      onEditingComplete: () => _phoneEditingComplete(),
    );
  }

  void _nameEditingComplete() {
    final newFocus = _name.isNotEmpty ? _phoneFocusNode : _nameFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _phoneEditingComplete() {
    setState(() {
      _nameValid = _name.isNotEmpty;
      _phoneValid = _phone.isNotEmpty && _phone.length == 8;
      _showNameError = _name.isEmpty;
      _showPhoneError = _phone.isEmpty || _phone.length != 8;
    });
    _phoneValid
        ? FocusScope.of(context).unfocus()
        : FocusScope.of(context).requestFocus(_phoneFocusNode);
  }

  String get _name => _nameController.text;

  String get _phone => _phoneController.text;

  bool _suicideQnsYes = false;
  bool _suicideQnsNo = false;
  bool _suicideAns = false;

  Widget suicidalQns() {
    return Card(
      margin: EdgeInsets.all(0),
      child: Row(
        children: <Widget>[
          Container(
            child: Text(suicidalQuestion),
            width: 210,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text("yes"),
                Checkbox(
                  value: _suicideQnsYes,
                  onChanged: (bool value) => {
                    setState(() {
                      _suicideAns = value;
                      _suicideQnsYes = value;
                      _suicideQnsNo = !value;
                      _showSOS = value;
                    }),
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text("no"),
                Checkbox(
                  value: _suicideQnsNo,
                  onChanged: (bool value) => {
                    setState(() {
                      _suicideAns = value;
                      _suicideQnsYes = !value;
                      _suicideQnsNo = value;
                      _showSOS = !value;
                    }),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _abuseQnsYes = false;
  bool _abuseQnsNo = false;
  bool _abuseAns = false;

  Widget abuseQns() {
    return Card(
      margin: EdgeInsets.all(0),
      child: Row(
        children: <Widget>[
          Container(
            child: Text(abuseQuestion),
            width: 210,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text("yes"),
                Checkbox(
                  value: _abuseQnsYes,
                  onChanged: (bool value) => {
                    setState(() {
                      _abuseAns = value;
                      _abuseQnsYes = value;
                      _abuseQnsNo = !value;
                      _showAbuse = value;
                    }),
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text("no"),
                Checkbox(
                  value: _abuseQnsNo,
                  onChanged: (bool value) => {
                    setState(() {
                      _abuseAns = value;
                      _abuseQnsYes = !value;
                      _abuseQnsNo = value;
                      _showAbuse = !value;
                    }),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  bool _distressQnsYes = false;
  bool _distressQnsNo = false;
  bool _distressAns = false;

  Widget distressQns() {
    return Card(
      margin: EdgeInsets.all(0),
      child: Row(
        children: <Widget>[
          Container(
            child: Text(distressQuestion),
            width: 210,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text("yes"),
                Checkbox(
                  value: _distressQnsYes,
                  onChanged: (bool value) => {
                    setState(() {
                      _distressAns = value;
                      _distressQnsYes = value;
                      _distressQnsNo = !value;
                      _showDistress = value;
                    }),
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text("no"),
                Checkbox(
                  value: _distressQnsNo,
                  onChanged: (bool value) => {
                    setState(() {
                      _distressAns = value;
                      _distressQnsYes = !value;
                      _distressQnsNo = value;
                      _showDistress = !value;
                    }),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final String suicidalQuestion = "Do you have any thoughts on hurting youself or others, or commiting suicide?";
  final String abuseQuestion = "Are you experiencing any forms of abuse?";
  final String distressQuestion = "Are you experiencing overwhelming levels of distress, sadness, grief, anxiety or fear?";
  final String sosText = "If you feel you may be at immediate risk of harming yourself, call 995 or approach the A&E department of your nearest hospital. Alternatively, call the 24-hour SOS hotline at 1800-221 4444.";
  final String abuseText = "If you feel you may be at immediate risk of being harmed, call 999 or approach the nearest police station. Alternatively, call the 24-hour SOS hotline at 1800-221 4444.";
}