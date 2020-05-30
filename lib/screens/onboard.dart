import 'package:dir_khir/screens/login.dart';
import 'package:dir_khir/utils/component.dart';
import 'package:flutter/material.dart';

class Onboard extends StatefulWidget {
  static String id = 'onboard';
  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<Widget> _pages = [
    PageContent(
      title: 'Volunteer Nearby',
      subtitle: 'Search for volunteering opportunities nearby and join them!',
      imagePath: 'images/onboard1.PNG',
    ),
    PageContent(
      title: 'Create Opportunities',
      subtitle:
          'Create volunteering events and invite the community to join you',
      imagePath: 'images/onboard2.PNG',
    ),
    PageContent(
      title: 'Reviewing events',
      subtitle:
          'Making volunteering accessible to everyone and Sharing experiences',
      imagePath: 'images/onboard3.PNG',
    ),
  ];

  List<Widget> _pageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _pages.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 150,
      ),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24 : 16.0,
      decoration: BoxDecoration(
          color: isActive ? Color(0xff7D2AE6) : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
    );

    //circular dots
    /* return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ); */
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Spacer(),
              Expanded(
                flex: 3,
                child: PageView(
                  children: _pages,
                  controller: _pageController,
                  physics: ClampingScrollPhysics(),
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _pageIndicator(),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginPage.id);
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
