import 'package:dir_khir/model/ChatUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DiscussionPage extends StatefulWidget {
  static String id = 'discussion';
  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  //discussionModel disc = discussionModel.listMessages.elementAt(0);
  String userOn = "1";//logeduser
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
          backgroundColor: Colors.purple,
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
                              backgroundColor: Colors.purple.shade300,
                              child: Icon(Icons.account_circle),
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
                              ? Colors.orange
                              : Colors.purple,
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
                    onChanged: (value){
                      messageText = value;
                    },
                  ),
                ),
                FlatButton(onPressed: (){
                  
                },
                    child: Icon(Icons.send, color: Colors.indigoAccent,) )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
