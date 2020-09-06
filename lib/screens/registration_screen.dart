import 'package:chat_me/components/rounded_button.dart';
import 'package:chat_me/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_me/constrains.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

bool showspinner = false;

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                  title: 'Register',
                  colour: Colors.blueAccent,
                  onpressed: () async {
                    setState(() {
                      showspinner = true;
                    });
                    try {
                      final newuser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);

                      if (newuser != null)
                        Navigator.pushNamed(context, ChatScreen.id);

                      setState(() {
                        showspinner = false;
                      });
                    } catch (e) {
                      setState(() {
                        showspinner = false;
                      });
                      showAlertDialog(context);
                    }
                  }),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                    child: Text(
                  'TIP -- Password must have atleast 7 digits!',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget continueButton = FlatButton(
    child: Text("Retry"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Credentials Must Be Formated",
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    ),
    content: Text(
      "Credential must be in correct format",
      style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
    ),
    actions: [
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
