import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dir_khir/utils/RoomsUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'discussion.dart';



final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class RoomsPage extends StatefulWidget {
  static String id = 'rooms';
  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: <Widget>[
              RoomsStreams(),
            ],
          )
      ),
    );
  }
}

//class RoomCards extends StatelessWidget {
//  RoomCards();
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      children: <Widget>[
//        Expanded(
//          child: SingleChildScrollView(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: <Widget>[
//                Padding(
//                  padding: EdgeInsets.all(20),
//                  child: TextField(
//                    decoration: InputDecoration(
//                      hintText: "Search...",
//                      hintStyle: TextStyle(color: Colors.grey.shade500),
//                      prefixIcon: Icon(Icons.search,
//                          color: Colors.grey.shade500, size: 20),
//                      filled: true,
//                      fillColor: Colors.grey.shade100,
//                      enabledBorder: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(50),
//                        borderSide: BorderSide(color: Colors.grey.shade200),
//                      ),
//                    ),
//                  ),
//                ),
//                RoomsUserList(
//                    name: "Team Bniwen",
//                    lastmessage: "bnina 7it",
//                    time: "12h30"), //+photo discusiion apres
//                RoomsUserList(
//                    name: "Team Bniwen",
//                    lastmessage: "bnina 7it",
//                    time: "12h30"), //+photo discusiion apres
//                RoomsUserList(
//                    name: "Team Bniwen",
//                    lastmessage: "bnina 7it",
//                    time: "12h30"), //+photo discusiion apres
//                RoomsUserList(
//                    name: "Team Bniwen",
//                    lastmessage: "bnina 7it",
//                    time: "12h30"), //+photo discusiion apres
//                RoomsUserList(
//                    name: "Team Bniwen",
//                    lastmessage: "bnina 7it",
//                    time: "12h30"), //+photo discusiion apres
//                RoomsUserList(
//                    name: "Team Bniwen",
//                    lastmessage: "bnina 7it",
//                    time: "12h30"), //+photo discusiion apres
//                RoomsUserList(
//                    name: "Team Bniwen",
//                    lastmessage: "bnina 7it",
//                    time: "12h30"), //+photo discusiion apres
//                RoomsUserList(
//                    name: "Team Bniwen",
//                    lastmessage: "bnina 7it",
//                    time: "12h30"), //+photo discusiion apres
//                RoomsUserList(
//                    name: "Team Bniwen",
//                    lastmessage: "bnina 7it",
//                    time: "12h30"), //+photo discusiion apres
//                RoomsUserList(
//                    name: "Team Bniwen",
//                    lastmessage: "bnina 7it",
//                    time: "12h30"), //+photo discusiion apres
//                RoomsUserList(
//                    name: "Team Bniwen",
//                    lastmessage: "bnina 7it",
//                    time: "12h30"), //+photo discusiion apres
//              ],
//            ),
//          ),
//        ),
//      ],
//    );
//  }
//}

class RoomsStreams extends StatefulWidget {
  @override
  _RoomsStreamsState createState() => _RoomsStreamsState();
}

class _RoomsStreamsState extends State<RoomsStreams> {

  var _lastMessage;
  var _lastMessageTime;

  void getLastMessage(roomName)async{
    var room = _firestore.collection('Rooms').document(roomName);
    await for(var snapshot in room.collection('chat').orderBy('time').snapshots()){
      for(var message in snapshot.documents){
        setState(() {
          _lastMessage = message.data['message'];
          _lastMessageTime = DateTime.fromMillisecondsSinceEpoch(message.data['time'].seconds*1000);
        });
        print(DateTime.fromMillisecondsSinceEpoch(message.data['time'].seconds*1000));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getLastMessage('Sada9a');

  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Rooms').orderBy(
            'event_date', descending: false).snapshots(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.indigoAccent,
              ),
            );
          }
          final rooms = snapshot.data.documents;
          List<RoomBubble> roomsCard = [];
          for (var room in rooms) {
            final roomName = room.documentID;//room.data['event_name'];
            //final lastMessage = _lastMessage;
            final roomTime = _lastMessageTime.toString();
            //print(lastMessage);
            //getLastMessage(roomName);
            //final currentUser = loggedInUser.email;

            final roomBubble = RoomBubble(
              name: roomName ,//roomName,
              //lastmessage: lastMessage,///roomTime,
              //time: roomTime,//'fi ko wa9t',

            );

            roomsCard.add(roomBubble);
          }
          return Expanded(
            child: ListView(
              reverse: false,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: Icon(Icons.search,
                          color: Colors.grey.shade500, size: 20),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: roomsCard,
                )
              ], //roomsCard,
            ),

            /* Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                        padding: EdgeInsets.all(20),
                      child: TextField(
                        decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        prefixIcon: Icon(Icons.search,
                        color: Colors.grey.shade500, size: 20),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        ),
                      ),
                      ),
      },*/
          );
        }
    );
  }
}



class RoomBubble extends StatefulWidget {
  RoomBubble({this.name, this.lastmessage, this.time});

  final String name;
  final String lastmessage;
  final String time;

  @override
  _RoomBubbleState createState() => _RoomBubbleState();
}

class _RoomBubbleState extends State<RoomBubble> {
  var _lastMessage;
  var _lastMessageTime;

  void getLastMessage(roomName)async{
    //print(roomName);
    var room = _firestore.collection('Rooms').document(roomName);
    await for(var snapshot in room.collection('chat').orderBy('time').snapshots()){
      for(var message in snapshot.documents){
        setState(() {
          _lastMessage = message.data['message'];
          _lastMessageTime = DateTime.fromMillisecondsSinceEpoch(message.data['time'].seconds*1000);
        });
        //print(DateTime.fromMillisecondsSinceEpoch(message.data['time'].seconds*1000));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getLastMessage(Text(widget.name).data);
    // }
  }

  @override
  Widget build(BuildContext context) {
    getLastMessage(Text(widget.name).data);
    return ListTile(
      leading: CircleAvatar(
        //backgroundImage: AssetImage(widget.photo),
        backgroundColor: Color(0xff7D2AE6),
        child: Icon(Icons.group, color: Colors.white),
        maxRadius: 30,
      ),
      title: Text(widget.name),
      subtitle: Text((_lastMessage == null) ? 'Start the discussion' : _lastMessage),
      trailing: Text(
          (_lastMessageTime == null) ? '' : _lastMessageTime.toString(),
      ),
      //dense: true,
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=>DiscussionPage(
                  title: Text(widget.name).data
                )),
        )
      },
    );
  }
}

