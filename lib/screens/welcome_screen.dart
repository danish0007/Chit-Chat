import 'package:chat_me/screens/login_screen.dart';
import 'package:chat_me/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_me/components/rounded_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  AnimationController animation;
  Animation controller;

  @override
  void initState() {
    super.initState();

    animation = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    controller = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(animation);

    animation.forward();

    animation.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/chatlogos.jpg'),
                      height: 80,
                    ),
                  ),
                ),
                SizedBox(width: 7),
                TypewriterAnimatedTextKit(
                  text: ['Chit Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            rounded_button(
              title: 'Log In',
              colour: Colors.lightBlueAccent,
              onpressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            rounded_button(
              title: 'Register',
              colour: Colors.blueAccent,
              onpressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
