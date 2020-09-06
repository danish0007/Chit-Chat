import 'package:chat_me/components/rounded_button.dart';
import 'package:chat_me/constrains.dart';
import 'package:chat_me/screens/chat_screen.dart';
import 'package:chat_me/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

bool showspinner = false;

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 220.0,
                    child: Image.asset('images/chatlogos.jpg'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    KInputDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration:
                    KInputDecoration.copyWith(hintText: 'Enter your Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              rounded_button(
                  title: 'Login',
                  colour: Colors.lightBlueAccent,
                  onpressed: () async {
                    setState(() {
                      showspinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        showspinner = false;
                      });
                    } catch (e) {
                      setState(() {
                        showspinner = false;
                      });
                      showAlertDialog(context);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget cancelButton = FlatButton(
    child: Text("Register Here"),
    onPressed: () {
      Navigator.pushNamed(context, RegistrationScreen.id);
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Retry"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Credentials Do Not Match",
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    ),
    content: Text(
      "Credential do not match, If not registered then first registered yourself",
      style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
