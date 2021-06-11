import 'package:donorpatient/home/home.dart';
import 'package:donorpatient/models/person.dart';
import 'package:donorpatient/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final Function toggleview;
  const Register({Key key, this.toggleview}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool donor = true;

  String name = "";
  String email = "";
  String phone = "";
  String address = "";
  String desc = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        actions: [
          FlatButton.icon(
            onPressed: () {
              widget.toggleview();
            },
            icon: Icon(Icons.person),
            label: Text('Login'),
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
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty)
                          return "Name cannot be empty.";
                        else
                          return null;
                      },
                      onChanged: (value) => name = value,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(40.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: "Name",
                          fillColor: Colors.white70),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty)
                          return "Email cannot be empty.";
                        else
                          return null;
                      },
                      onChanged: (value) => email = value,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(40.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: "Email",
                          fillColor: Colors.white70),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty)
                          return "PhoneNumber cannot be empty.";
                        else
                          return null;
                      },
                      onChanged: (value) => phone = value,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(40.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: "PhoneNumber",
                          fillColor: Colors.white70),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty)
                          return "Address cannot be empty.";
                        else
                          return null;
                      },
                      onChanged: (value) => address = value,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(40.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: "Address",
                          fillColor: Colors.white70),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "UserType:",
                            textScaleFactor: 1.2,
                            style: TextStyle(
                              color: Colors.blue[600],
                            ),
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: Colors.red,
                            value: this.donor,
                            onChanged: (bool value) {
                              setState(() {
                                this.donor = value;
                              });
                            },
                          ),
                          Text("Donor"),
                          Checkbox(
                            value: !this.donor,
                            onChanged: (bool value) {
                              setState(() {
                                this.donor = !value;
                              });
                            },
                          ),
                          Text("Patient"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    !this.donor
                        ? AnimatedContainer(
                            curve: Curves.easeIn,
                            duration: Duration(seconds: 2),
                            child: TextFormField(
                              onChanged: (value) => desc = value,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText: "Description",
                                  fillColor: Colors.white70),
                            ),
                          )
                        : Text(""),
                    SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          String usertype = this.donor ? "donor" : "patient";
                          Person response = await Person.createUser(
                              name, email, address, desc, phone, usertype);
                          print(response.uid);
                          if (response != null) {
                            Provider.of<User>(context,listen: false).loggedPerson(response);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          }
                        }
                      },
                      child: Text("Register"),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
