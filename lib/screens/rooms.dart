import 'package:flutter/material.dart';
import 'package:dir_khir/utils/RoomsUser.dart';

class RoomsPage extends StatefulWidget {
  static String id = 'rooms';
  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Text(
              "Rooms",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Expanded(
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
                    RoomsUserList(name:"Team Bniwen", lastmessage: "bnina 7it", time: "12h30"), //+photo discusiion apres
                    RoomsUserList(name:"Team Bniwen", lastmessage: "bnina 7it", time: "12h30"), //+photo discusiion apres
                    RoomsUserList(name:"Team Bniwen", lastmessage: "bnina 7it", time: "12h30"), //+photo discusiion apres
                    RoomsUserList(name:"Team Bniwen", lastmessage: "bnina 7it", time: "12h30"), //+photo discusiion apres
                    RoomsUserList(name:"Team Bniwen", lastmessage: "bnina 7it", time: "12h30"), //+photo discusiion apres
                    RoomsUserList(name:"Team Bniwen", lastmessage: "bnina 7it", time: "12h30"), //+photo discusiion apres
                    RoomsUserList(name:"Team Bniwen", lastmessage: "bnina 7it", time: "12h30"), //+photo discusiion apres
                    RoomsUserList(name:"Team Bniwen", lastmessage: "bnina 7it", time: "12h30"), //+photo discusiion apres
                    RoomsUserList(name:"Team Bniwen", lastmessage: "bnina 7it", time: "12h30"), //+photo discusiion apres
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
