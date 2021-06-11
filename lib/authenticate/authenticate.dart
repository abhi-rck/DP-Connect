import 'package:donorpatient/authenticate/login.dart';
import 'package:donorpatient/authenticate/register.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  Authenticate({Key key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool login = true;
  void toggleView() {
    setState(() {
      login = !login;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (login) {
      return Login(toggleview: toggleView);
    } else {
      return Register(toggleview: toggleView);
    }
  }
}
