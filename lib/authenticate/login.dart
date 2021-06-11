import 'package:donorpatient/home/home.dart';
import 'package:donorpatient/home/profile.dart';
import 'package:donorpatient/models/person.dart';
import 'package:donorpatient/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final Function toggleview;
  const Login({Key key, this.toggleview}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int id = 0;
  String uid = "";

  bool wrong = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        actions: [
          FlatButton.icon(
            onPressed: () {
              widget.toggleview();
            },
            icon: Icon(Icons.person),
            label: Text('Register'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: Image.asset("assets/images/medical.png"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) => id = int.parse(value),
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(40.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        hintText: "Id",
                        fillColor: Colors.white70),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    onChanged: (value) => uid = value,
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(40.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        hintText: "Secret Code",
                        fillColor: Colors.white70),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Person person = await Person.loginUser(uid, id);
                      if (person != null) {
                        wrong = false;
                        Provider.of<User>(context, listen: false)
                            .loggedPerson(person);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      } else {
                        wrong = true;
                        setState(() {});
                      }
                    },
                    child: Text("Login"),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            wrong
                ? Text(
                    "Please provide valid credentials!",
                    style: TextStyle(color: Colors.red),
                  )
                : Text(""),
          ],
        ),
      ),
    );
  }
}
