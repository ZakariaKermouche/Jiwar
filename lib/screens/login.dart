import 'package:dir_khir/screens/navigation.dart';
import 'package:dir_khir/screens/registeration.dart';
import 'package:dir_khir/utils/component.dart';
import 'package:dir_khir/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  String mail;
  String password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff7D2AE6),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage('images/logo2.png'),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      'Welcome to Jiwar',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    Text(
                      'Start your volunteering journey now!',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            mail = value;
                          },
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'E-mail',
                            hintText: 'Enter your E-mail',

                            hintStyle: TextStyle(
                              color: Colors.white70,
                            ),
                            labelStyle:TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextField(
                          textAlign: TextAlign.center,
                          obscureText: true,
                          onChanged: (value) {
                            password = value;
                          },
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Password',
                            hintText: 'Enter your Password',
                            hintStyle: TextStyle(
                              color: Colors.white70,
                            ),
                            labelStyle:TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        MyButton(
                          text: 'SING IN',
                          color: Color(0xffFE8A51),
                          textColor: Colors.white,
                          width: 200,
                          tap: () async {
                            try {
                              final login =
                                  await _auth.signInWithEmailAndPassword(
                                      email: mail, password: password);
                              if (login != null) {
                                Navigator.pushNamed(context, NavigationPage.id);
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'I\'m a new user.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegistrationPage.id);
                      },
                      child: Text(
                        ' Register',
                        style: TextStyle(
                            color: Color(0xffFE8A51),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
