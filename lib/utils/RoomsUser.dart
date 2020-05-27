import 'package:flutter/material.dart';

class RoomsUserList extends StatefulWidget {
  final String name;
  final String lastmessage;
  final String time;
  //String photo;
  RoomsUserList(this.name, this.lastmessage,
      this.time); //, @required this.photo);
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
      //onTap: ()=> ,
    );
  }
}
