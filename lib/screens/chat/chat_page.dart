import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          child:
              // FlatButton.icon(
              //   icon: Icon(
              //     Icons.exit_to_app,
              //     color: Colors.white,
              //   ),
              //   label: Text(
              //     "Logout",
              //     textAlign: TextAlign.center,
              //     style: GoogleFonts.indieFlower(fontSize: 15, color: Colors.white),
              //     //color: Colors.white, fontWeight: FontWeight.bold)
              //   ),
              //   onPressed: () => () {}
              // ),
              IconButton(
            icon: Text("End",
                style: GoogleFonts.roboto(color: Colors.white, fontSize: 15)),
            onPressed: () => _endChat(context),
          ),
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
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () => null,
          )
        ],
      ),
      body: ChatScreen(
        id: id,
        chatId: chatId,
      ),
    );
  }

  void _endChat(BuildContext context) {
    try {
      print("DEL");
      Firestore.instance.collection('chat').document(chatId).delete();
      Navigator.of(context).pop();
      //Navigator.popUntil(context, ModalRoute.withName('/Home'));
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

  String peerId;
  String chatId;
  String id;

  var listMessage;
  String groupChatId;
  // SharedPreferences prefs;

  // File imageFile;
  // bool isLoading;

  // bool isShowSticker;
  // String imageUrl;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);

    groupChatId = '';

    // isLoading = false;
    // isShowSticker = false;
    // imageUrl = '';

    // readLocal();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        // isShowSticker = false;
      });
    }
  }

  // readLocal() async {
  //   prefs = await SharedPreferences.getInstance();
  //   id = prefs.getString('id') ?? '';
  //   if (id.hashCode <= peerId.hashCode) {
  //     groupChatId = '$id-$peerId';
  //   } else {
  //     groupChatId = '$peerId-$id';
  //   }

  //   Firestore.instance.collection('users').document(id).updateData({'chattingWith': peerId});

  //   setState(() {});
  // }

  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();

      var documentReference = Firestore.instance
          .collection('chat')
          .document(chatId)
          .collection('messages')
//          .document(DateTime.now().millisecondsSinceEpoch.toString());
          .document(DateTime.now().toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'from': id,
            // 'idTo': peerId,
            // 'time': DateTime.now().millisecondsSinceEpoch.toString(),
            // 'time': FieldValue.serverTimestamp(),
            'time': DateTime.now().toUtc().millisecondsSinceEpoch,
            'message': content,
            // 'type': type
          },
        );
      });
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      // Fluttertoast.showToast(msg: 'Nothing to send');
      print('Nothing to send');
    }
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    if (document['from'] == id) {
      print(document['time'].toDate());
      // Right (my message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    document['message'],
                    style: GoogleFonts.roboto(fontSize: 18, color: Colors.black)
                    ),
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
                    ]
                  ),
                  //margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0)
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),

            isLastMessageRight(index)
                ? Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm').format(/*document['time'].toDate()*/
                        DateTime.fromMillisecondsSinceEpoch(document['time'], isUtc: true)
                          /*DateTime.parse(document['time'].toDate().toString()).add(new Duration(hours: 8))*/),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic),
                    ),
                    margin: EdgeInsets.only(right: 5.0, top: 5.0, bottom: 5.0),
                  )
                : Container()
          ],
           crossAxisAlignment: CrossAxisAlignment.end
        ),
        margin: EdgeInsets.only(bottom: 10.0)
      );

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
                          DateTime.parse(document['time'].toDate().toString()).add(new Duration(hours: 8))),
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

  // Can modify to become exit button.
  // Future<bool> onBackPress() {
  //   // if (isShowSticker) {
  //   //   setState(() {
  //   //     isShowSticker = false;
  //   //   });
  //   // } else {
  //     Firestore.instance.collection('chat').document('chatid').updateData({'chattingWith': null});
  //     Navigator.pop(context);

  //   return Future.value(false);
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              buildListMessage(),

              // Sticker
              // (isShowSticker ? buildSticker() : Container()),

              // Input content
              buildInput(),
            ],
          ),

          // Loading
          // buildLoading()
        ],
      ),
      onWillPop: null, //onBackPress,
    );
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
                focusNode: focusNode,
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
      child: groupChatId != ''
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder(
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
