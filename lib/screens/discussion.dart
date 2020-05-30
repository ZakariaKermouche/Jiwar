import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class DiscussionPage extends StatefulWidget {
  static const String id = 'discussion';

  DiscussionPage({this.title});
  final String title;
  static String nameDisc;
  
  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;



  String messageText;
  Timestamp messageTime;


  @override
  void initState() {
    super.initState();

    getCurrentUser();

  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void roomName() async {
    await for(var snapshot in _firestore.collection('Rooms').snapshots()){
      for (var roomId in snapshot.documents) {
        print(roomId.documentID);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {Navigator.pop(context)},
        ),
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => {
              //Information of the discussion
            },
          ),
        ],
        backgroundColor: Color(0xff7D2AE6),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(title: widget.title),
            Container(
              child:   Row(
                children: <Widget>[
                  SizedBox(height: 20),
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      decoration: InputDecoration(
                        hintText: "Tap your message here ...",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        /*prefixIcon: Icon(Icons.text_format,
                          color: Colors.grey.shade500, size: 20),*/
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                      ),
                      onChanged: (value) {
                        messageText = value;
                        messageTime = Timestamp.fromDate(DateTime.now());
                        roomName();
                      },
                    ),
                  ),
                  CircleAvatar(
                    maxRadius: 28,
                    backgroundColor: Color(0xff7D2AE6),
                    child: IconButton(
                      icon: Icon(Icons.send, color: Colors.white),
                      onPressed: () => {
                        messageTextController.clear(),
                        _firestore.collection('Rooms').document(widget.title).collection('chat').add({
                          'message': messageText,
                          'sender': loggedInUser.email,
                          'time': messageTime,
                        })
                      },
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class MessagesStream extends StatefulWidget {
  MessagesStream({this.title});

  final title;

  @override
  _MessagesStreamState createState() => _MessagesStreamState();
}

class _MessagesStreamState extends State<MessagesStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Rooms').document(widget.title).collection('chat').orderBy('time',descending: false).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data['message'];
          final messageSender = message.data['sender'];
          final messageTime = message.data['time'];

          final currentUser = loggedInUser.email;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: isMe ?  Color(0xffFE8A51)
                : Color(0xff7D2AE6),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}