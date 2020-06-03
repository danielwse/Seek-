import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seek/screens/chat/chat_page.dart';
import 'auth.dart';


class HoldingPage extends StatefulWidget {
  final BaseAuth auth;


  HoldingPage({
    @required this.auth,
  });

  @override
  _HoldingPageState createState() {
    return _HoldingPageState();
  }
}

class _HoldingPageState extends State<HoldingPage> {
  Future<void> _signOut(BuildContext context) async {
    try {
      User user = await widget.auth.currentUser();
      await widget.auth.signOut();
      try {
        Firestore.instance
            .collection('counsellors')
            .document(user.uid)
            .delete();
      } catch (e) {
        print(e.toString());
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final chatButton = Material(
    //   elevation: 5.0,
    //   borderRadius: BorderRadius.circular(30.0),
    //   color: Colors.brown,
    //   child: MaterialButton(
    //     minWidth: 170,
    //     padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
    //     onPressed: () {} /*moveToChatPage*/,
    //     child: Text(
    //       "Chat with Seeker",
    //       textAlign: TextAlign.center,
    //       style: GoogleFonts.indieFlower(fontSize: 25, color: Colors.white),
    //       //color: Colors.white, fontWeight: FontWeight.bold)
    //     ),
    //   ),
    // );

    // final logoutButton = Material(
    //   elevation: 5.0,
    //   //borderRadius: BorderRadius.circular(30.0),
    //   color: Colors.red[700],
    //   child: MaterialButton(
    //     height: 5,
    //     minWidth: 100,
    //     padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
    //     onPressed: () => _signOut(context),
    //     child: Text(
    //       "Logout",
    //       textAlign: TextAlign.center,
    //       style: GoogleFonts.indieFlower(fontSize: 15, color: Colors.white),
    //       //color: Colors.white, fontWeight: FontWeight.bold)
    //     ),
    //   ),
    // );

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Seek',
            style: GoogleFonts.montserrat(
              fontSize: 32,
              color: Colors.white
            ),
          ),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              label: Text(
                "Logout",
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.indieFlower(fontSize: 15, color: Colors.white),
                //color: Colors.white, fontWeight: FontWeight.bold)
              ),
              onPressed: () => _signOut(context),
            )
          ],
        ),
        body: _buildBody(context)
        //SingleChildScrollView(
        //child: Center(
        //child: ,
        /*
          Column(
            //infinite height
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 230.0),
              Text(
                'Please hold on',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSansCondensed(
                    fontSize: 30, color: Colors.black),
              ),
              Text(
                'Matching you with a Seeker...',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSansCondensed(
                    fontSize: 30, color: Colors.black),
              ),
              SizedBox(height: 20.0),
              chatButton,
              SizedBox(height: 270),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[logoutButton, SizedBox(width: 20)],
              ),
            ],
          ),*/
        //),
        //),
        );
  }

  /*void moveToChatPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChatPage()));
  }*/

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('newChat')
          //.orderBy("priority", descending: false)
          .orderBy("time", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          print("NA");
          return Container(
            alignment: Alignment.center,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Please hold on',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSansCondensed(
                        fontSize: 30, color: Colors.black),
                  ),
                  Text(
                    'Matching you with a Seeker...',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSansCondensed(
                        fontSize: 30, color: Colors.black),
                  ),
                  SizedBox(height: 20.0),
                  CircularProgressIndicator(),
                ]),
          );
        } else {
          print("DA");
          print(snapshot);
          List<DocumentSnapshot> data = snapshot.data.documents;
          data.sort((x,y) {
            return x['priority'].compareTo(y['priority']);});
          return _buildList(context, data);
          //return _buildList(context, snapshot.data.documents);
        }
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20.0),
      itemBuilder: (context, index) => _buildListItem(context, snapshot[index]),
      itemCount: snapshot.length,
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final chatRoom = ChatRoom.fromSnapshot(data);

    return Padding(
      key: ValueKey(chatRoom.chatId),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        alignment: Alignment.topLeft,
        height: 60.0,
        decoration: BoxDecoration(
          color: (chatRoom.priority == 1
              ? Colors.red
              : (chatRoom.priority == 2
                  ? Colors.red[300]
                  : (chatRoom.priority == 3
                      ? Colors.red[200]
                      : Colors.blue[200]))),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          title: Text(
            (chatRoom.priority == 1
                    ? _sos
                    : (chatRoom.priority == 2
                        ? _abuse
                        : (chatRoom.priority == 3 ? _distress : _standard))) +
                chatRoom.chatId.hashCode.toString(),
            style: TextStyle(fontSize: 15),
          ),
          subtitle: Text(
              (chatRoom.priority == 1
                  ? _sosSub
                  : (chatRoom.priority == 2
                      ? _abuseSub
                      : (chatRoom.priority == 3 ? _distressSub : "\n \n"))),
              style: TextStyle(fontSize: 12)),
          onTap: () => _goToChat(chatRoom.chatId),
        ),
      ),
    );
  }

  final String _sos = "[Priority-SOS] Chat No: ";
  final String _sosSub =
      "Seeker indicated thoughts on hurting self or others, or commiting suicide";
  final String _abuse = "[Priority-Abuse] Chat No: ";
  final String _abuseSub = "Seeker indicated experiencing forms of abuse\n";
  final String _distress = "[Priority-Distress] Chat No: ";
  final String _distressSub =
      "Seeker indicated experiencing overwhelming levels of distress, sadness, grief, anxiety or fear";
  final String _standard = "Chat No: ";

  void _goToChat(String id) {
    Firestore.instance.collection('newChat').document(id).delete();
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => Chat(id: "COUNSELLOR", chatId: id),
    ));
  }
}

class ChatRoom {
  final String chatId;
  final int priority;
  final DocumentReference reference;

  ChatRoom.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['chatId'] != null),
        assert(map['priority'] != null),
        chatId = map['chatId'],
        priority = map['priority'];

  ChatRoom.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
