import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(           
        alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(50),
              child: Column(
                children: <Widget>[
                  _nameTextField(),
                  _phoneTextField(),
                  SizedBox(height: 8.0,),
                  Text(
                    "Note: Phone number is required for verification purposes and for emergency situations."
                  ),
                  Text(
                    "Your data will only be retained for the duration of the chat. Thank you."
                  ),
                  Offstage(
                    offstage: false,//!(_phoneValid && _nameValid),
                    child: Column(
                      children: <Widget> [
                        SizedBox(height: 15,),
                        SurveyCheckBox(qns: "Do you have suicidal or violent thoughts?"),
                        SizedBox(height: 15,),
                        SurveyCheckBox(qns: "Are you having thoughts of harming yourself or is there someone trying to harm you?"),
                        SizedBox(height: 15,),
                        SurveyCheckBox(qns: "Are you experiencing overwhelming distress, sadness, grief, anxiety or fear?"),
                      ],
                    ),
                  ),
                  RaisedButton(
                    child: Text("BACK"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }

  void _updateState() {
    setState(() {});
  }
  
  TextField _nameTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Display name",
        hintText: "Name to be addresed by",
        errorText: _showNameError ? "Name cannot be empty" : null,
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
      decoration: InputDecoration(
        labelText: "Phone number",
        hintText: "Local phone number",
        errorText: _showPhoneError ? "Number cannot be empty" : null,
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
    final newFocus = _name.isNotEmpty
        ? _phoneFocusNode
        : _nameFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }
  
  void _phoneEditingComplete() {
    setState(() {
      _nameValid = _name.isNotEmpty;
      _phoneValid = _phone.isNotEmpty;
      _showNameError = _name.isEmpty;
      _showPhoneError = _phone.isEmpty;
    });
    final newFocus = _phone.isNotEmpty
        ? _phoneFocusNode
        : _nameFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  String get _name => _nameController.text;

  String get _phone => _phoneController.text;
}

class SurveyCheckBox extends StatefulWidget {
  final String qns;

  SurveyCheckBox({
    @required this.qns
  });

  @override
  _SurveyCheckBoxState createState() => _SurveyCheckBoxState();
}

class _SurveyCheckBoxState extends State<SurveyCheckBox> {
  bool _yes = false;
  bool _no = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Row(
        children: <Widget>[
          Container(
            child: Text(widget.qns),
            width: 210,
          ),
          Container(
            child: Column(
              children: <Widget> [
                Text("yes"),
                Checkbox( 
                  value: _yes,
                  onChanged: (bool value) => {
                    setState(() {
                      _yes = value;
                      _no = !value;
                    }),
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget> [
                Text("no"),
                Checkbox( 
                  value: _no,
                  onChanged: (bool value) => {
                    setState(() {
                      _no = value;
                      _yes = !value;
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
}