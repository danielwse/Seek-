import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Chat extends StatelessWidget {
  final String id;
  final String chatId;

  Chat({Key key, @required this.id, @required this.chatId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {},
          child: id == "COUNSELLOR"
              ? IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => _phoneDialog(context),
                    barrierDismissible: true,
                  ),
                )
              : Container(),
        ),
        //   IconButton(
        // icon: Text("End",
        //     style: GoogleFonts.roboto(color: Colors.white, fontSize: 15)),
        // onPressed: () => _endChat(context),
        //),
        // child: Material(
        //   child: MaterialButton(
        //     onPressed: () {},
        //     child: Text("End Chat"),
        //     minWidth: 1000,
        //     padding: EdgeInsets.fromLTRB(10, 10, 10, 10)
        //   ),
        //   color: Colors.blue[300],
        //   // shape: CircleBorder(side: BorderSide(color: Colors.transparent))
        // ),
        //),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            label: Text(
              "Exit chat",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (_) => _exitDialog(context),
              barrierDismissible: true,
            ),
          ),
        ],
      ),
      body: ChatScreen(
        id: id,
        chatId: chatId,
      ),
    );
  }

  Widget _phoneDialog(BuildContext context) {
    return AlertDialog(
      title: Text("Note!"),
      content: Text("Only proceed to call Seeker for emergency purposes!"),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Proceed to call"),
          onPressed: () => {launch("tel:$chatId")},
        ),
      ],
    );
  }

  Widget _exitDialog(BuildContext context) {
    return AlertDialog(
      title: Text("Note!"),
      content: Text(
          "Once you leave this chat, the contents will be destroyed and you will not be able to enter this same chat space again."),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Leave chat"),
          onPressed: () => _endChat(context),
        ),
      ],
    );
  }

  void _endChat(BuildContext context) {
    try {
      Navigator.of(context).pop();
      print("DEL");
      Firestore.instance
          .collection('chat')
          .document(chatId)
          .collection('messages')
          .document('end')
          .setData({
        "from": null,
        "message": "This chat has ended, please exit the chat. Thank you.",
        "time": FieldValue.serverTimestamp(),
      });
      Firestore.instance.collection('chat').document(chatId).delete();
      Firestore.instance.collection('newChat').document(chatId).delete();
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }
}

class ChatScreen extends StatefulWidget {
  final String id;
  final String chatId;

  ChatScreen({Key key, @required this.id, @required this.chatId})
      : super(key: key);

  @override
  State createState() => ChatScreenState(id: id, chatId: chatId);
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState({Key key, @required this.id, @required this.chatId});

  String chatId;
  String id;

  var listMessage;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void onSendMessage(String content, int type) {
    if (content.trim() != '') {
      textEditingController.clear();

      var documentReference = Firestore.instance
          .collection('chat')
          .document(chatId)
          .collection('messages')
          .document(DateTime.now().toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'from': id,
            'time': FieldValue.serverTimestamp(),
            'message': content,
          },
        );
      });
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      print('Nothing to send');
    }
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    if (document['from'] == id) {
      print(DateTime.parse(document['time'].toDate().toString()));
      // Right (my message)
      return Container(
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Text(document['message'],
                      style: GoogleFonts.roboto(
                          fontSize: 18, color: Colors.black)),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ]),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
            isLastMessageRight(index)
                ? Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm').format(
                          DateTime.parse(document['time'].toDate().toString())),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic),
                    ),
                    margin: EdgeInsets.only(right: 5.0, top: 5.0, bottom: 5.0),
                  )
                : Container()
          ], crossAxisAlignment: CrossAxisAlignment.end),
          margin: EdgeInsets.only(bottom: 10.0));
    } else if (document['from'] == null) {
      // Middle (System message)
      return Container(
          child: Column(children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container(
              child: Text(document['message'],
                  style: GoogleFonts.roboto(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center),
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              width: 350.0,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: Offset(0, 3),
                    )
                  ]),
              margin: EdgeInsets.only(
                  bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0)
              //margin: EdgeInsets.only(left: 50.0),
              ),
        ])
      ]));
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    document['message'],
                    style:
                        GoogleFonts.roboto(fontSize: 18, color: Colors.black),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset: Offset(0, 3),
                        )
                      ]),
                  margin: EdgeInsets.only(left: 10.0),
                )
              ],
            ),

            // Time
            isLastMessageLeft(index)
                ? Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm').format(
                          DateTime.parse(document['time'].toDate().toString())
                              .add(new Duration(hours: 8))),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic),
                    ),
                    margin: EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
                  )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['from'] == id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['from'] != id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageMid(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['from'] == null) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              buildListMessage(),
              buildInput(),
            ],
          ),
        ],
      ),
      onWillPop: () => _onBackPress(), //onBackPress,
    );
  }

  Future<bool> _onBackPress() async {
    showDialog(
      context: context,
      builder: (_) => _exitDialog(context),
      barrierDismissible: true,
    );
    return true;
  }
  Widget _exitDialog(BuildContext context) {
    return AlertDialog(
      title: Text("Note!"),
      content: Text(
          "Once you leave this chat, the contents will be destroyed and you will not be able to enter this same chat space again."),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Leave chat"),
          onPressed: () => _endChat(context),
        ),
      ],
    );
  }

  void _endChat(BuildContext context) {
    try {
      Navigator.of(context).pop();
      print("DEL");
      Firestore.instance
          .collection('chat')
          .document(chatId)
          .collection('messages')
          .document('end')
          .setData({
        "from": null,
        "message": "This chat has ended, please exit the chat. Thank you.",
        "time": FieldValue.serverTimestamp(),
      });
      Firestore.instance.collection('chat').document(chatId).delete();
      Firestore.instance.collection('newChat').document(chatId).delete();
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(color: Colors.black, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, 0),
                color: Colors.grey,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('chat')
            .document(chatId)
            .collection('messages')
            .orderBy('time', descending: true)
            .limit(20)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            listMessage = snapshot.data.documents;
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) =>
                  buildItem(index, snapshot.data.documents[index]),
              itemCount: snapshot.data.documents.length,
              reverse: true,
              controller: listScrollController,
            );
          }
        },
      ),
    );
  }
}
