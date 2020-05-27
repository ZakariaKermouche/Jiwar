import 'package:dir_khir/utils/constants.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color color;
  final Function tap;

  MyButton({ this.text, this.textColor, this.color, this.tap}); 
  
  @override
  Widget build(BuildContext context) {
    return Container(
      
      
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: tap,
        child: Ink(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Container(
            height: 50,
            width: double.infinity,
            child: Text(text,style: TextStyle(color: textColor,fontWeight:FontWeight.bold),),
            alignment: Alignment.center,
          ),
        ),
        
      ),
      
    );
  }
}




class FormInput extends StatelessWidget {
  
  final String label;
  final bool password;
  final Color enabledColor;
  final Color focusColor;

  const FormInput({this.label,this.password, this.enabledColor, this.focusColor});


  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: password == null ? false : password,
      decoration: InputDecoration(
        
        labelText: label,
        labelStyle: TextStyle(fontSize: 20,color: Colors.grey.shade300, fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          
          borderSide: BorderSide(color: enabledColor == null ? Colors.grey.shade400: enabledColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: focusColor == null ? primaryColor: focusColor),
        ),
      ),
    );
  }
}






class PageContent extends StatelessWidget {

 /* final String title;
  final String subtitle;
  final String imagePath;

  const PageContent({this.title, this.subtitle, this.imagePath});*/

  


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Image(
              image: AssetImage('images/test.png'),
            ),
          ),
          SizedBox(height: 15.0,),
          Expanded(
            flex: 5,
            child: Column(
              children: <Widget>[
                Text(
                  'Test Test Test',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sollicitudin nibh magna, ac luctus ex aliquet ac. Donec est enim.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10,left: 20),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Event Title',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    Text('Event Category', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                                  child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: Image.asset(
                    "images/event.jpg",
                    height: 220,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Expanded(
                                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Icon(Icons.calendar_today),
                      Text("July 20th"),
                      Icon(Icons.pin_drop),
                      Text("Alger"),
                    ])
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}