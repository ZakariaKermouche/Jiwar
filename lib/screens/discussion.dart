import 'package:dir_khir/model/ChatUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DiscussionPage extends StatefulWidget {
  static String id = 'discussion';
  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}
/*
        Color(0xff7D2AE6),
        Color(0xffFE8A51),
*/

class _DiscussionPageState extends State<DiscussionPage> {
  //discussionModel disc = discussionModel.listMessages.elementAt(0);
  String userOn = "1"; //logeduser
  List<ChatUser> messages = ChatUser.listMessages.reversed.toList();

  ///Backend
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String messageText;

  ///End Backend
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => {Navigator.pop(context)},
          ),
          title: Text("Name discussion"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () => {
                //Information of the discussion
              },
            )
          ],
          backgroundColor: Color(0xff7D2AE6),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                reverse: true,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: messages[index].senderID == userOn
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 5)),
                      messages[index].senderID == userOn
                          ? Container()
                          : CircleAvatar(
                              backgroundColor: Color(0xff7D2AE6),
                              child: Icon(Icons.account_circle,
                                  color: Colors.white),
                            ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width,
                        ),
                        padding: EdgeInsets.all(15),
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: messages[index].senderID == userOn
                              ? Color(0xffFE8A51)
                              : Color(0xff7D2AE6),
                        ),
                        child: Text("${messages[index].message}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(height: 20),
                Expanded(
                  child: TextField(
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
                    },
                  ),
                ),
                CircleAvatar(
                  maxRadius: 28,
                  backgroundColor: Color(0xff7D2AE6),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: () => {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
