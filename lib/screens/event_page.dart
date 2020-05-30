import 'package:dir_khir/screens/createEvent.dart';
import 'package:dir_khir/utils/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
        Color(0xff7D2AE6),
        Color(0xffFE8A51),
*/
class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

List<Widget> _cards = [
  EventCard(),
  EventCard(),
  EventCard(),
];

List<bool> isSelected = [true, false];

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
        //SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.all(30),
          child: Center(
            child: ToggleButtons(
              borderRadius: BorderRadius.circular(20),
              borderWidth: 2,
              color: Color(0xff7D2AE6),
              borderColor: Color(0xff7D2AE6),
              fillColor: Color(0xffFE8A51),
              selectedColor: Colors.white,
              selectedBorderColor: Color(0xff7D2AE6),
              children: <Widget>[
                Text(
                  "   My Events   ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "   UpComming   ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
              isSelected: isSelected,
              onPressed: (int index) {
                setState(() {
                  isSelected[0] = !isSelected[0];
                  isSelected[1] = !isSelected[1];
                });
              },
            ),
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
