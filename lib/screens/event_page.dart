import 'package:dir_khir/screens/createEvent.dart';
import 'package:dir_khir/utils/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

List<Widget> _cards = [
  EventCard(),
  EventCard(),
  EventCard(),
];

class _EventPageState extends State<EventPage> {
  final PageController _cardController =
      PageController(initialPage: 0, viewportFraction: 0.9);
  int _currentCard = 0;

  List<Widget> _cardIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _cards.length; i++) {
      list.add(i == _currentCard ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(vertical: 10),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    "Test",
                  )),
                  Expanded(child: Text("Test")),
                ],
              ),
            ],
          ),
        ),
        Expanded(
            flex: 5,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 20,
                  child: PageView(
                    children: _cards,
                    controller: _cardController,
                    scrollDirection: Axis.vertical,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentCard = page;
                      });
                    },
                    physics: ClampingScrollPhysics(),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _cardIndicator(),
                  ),
                ),
              ],
            )),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: MyButton(
                  text: 'create event',
                  textColor: Colors.white,
                  color: Color(0xffFE8A51),
                  width: 150,
                  tap: () {
                    Navigator.pushNamed(context, AddEvent.id);
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
