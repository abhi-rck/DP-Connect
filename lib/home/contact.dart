import 'package:donorpatient/widgets/mydrawer.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  Contact({Key key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contact Us"),
        ),
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(20.0),
                  child: Image.asset(
                    "assets/images/medical.png",
                    fit: BoxFit.contain,
                  )),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      "Contact",
                      textScaleFactor: 1.5,
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text("67828227XXXX")
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
