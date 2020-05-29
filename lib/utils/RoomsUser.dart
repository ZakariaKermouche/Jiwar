import 'package:dir_khir/screens/discussion.dart';
import 'package:flutter/material.dart';

class RoomsUserList extends StatefulWidget {
  String name;
  String lastmessage;
  String time;
  //String photo;
  RoomsUserList(@required this.name, @required this.lastmessage,
      @required this.time); //, @required this.photo);
  @override
  _RoomsUserListState createState() => _RoomsUserListState();
}

class _RoomsUserListState extends State<RoomsUserList> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        //backgroundImage: AssetImage(widget.photo),
        maxRadius: 30,
      ),
      title: Text(widget.name),
      subtitle: Text(widget.lastmessage),
      trailing: Text(widget.time),
      //dense: true,
      onTap: () => {Navigator.pushNamed(context, DiscussionPage.id)},
    );
  }
}
