import 'package:flutter/material.dart';
import 'package:seek/screens/chat/chat_sign_in.dart';
import 'package:seek/screens/wall/add_note.dart';
import 'screens/homePage.dart';
import 'screens/wall/note_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   int _selectedPage = 0;
  final _pageOptions = [
    HomePage(),
    NotePage(),
    AddNote(),
    ChatSignIn()
  ];
  @override 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent, 
        currentIndex: _selectedPage,
        onTap: (int index) { 
          setState(() {
            _selectedPage = index;
          });
        },
        items:[ 
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.create),
            title: Text('Connect'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('Chat'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tag_faces),
            title: Text('Tips'),
          ),
        ],
        selectedItemColor: Colors.amber[800],
    ),
            ));
}
}