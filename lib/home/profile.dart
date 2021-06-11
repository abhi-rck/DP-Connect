import 'package:donorpatient/models/person.dart';
import 'package:donorpatient/models/user.dart';
import 'package:donorpatient/widgets/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String address = "";
  String contact = "";
  bool edit = false;
  @override
  Widget build(BuildContext context) {
    Person person = Provider.of<User>(context, listen: false).person;
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        title: Text("Profile"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (edit == true) {
            Person per =
                await Person.updateUserInfo(person.uid, address, contact);
            // Provider.of<User>(context).loggedPerson(per);
          }
          setState(() {
            edit = !edit;
          });
        },
        child: edit ? Icon(Icons.send) : Icon(Icons.build_circle),
      ),
      drawer: MyDrawer(),
      body: Consumer<User>(builder: (context, user, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        person.name[0].toUpperCase(),
                        textScaleFactor: 4.0,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      person.name,
                      textScaleFactor: 1.4,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      person.email,
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Address",
                            textScaleFactor: 1.4,
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            person.address,
                            textScaleFactor: 1.1,
                            style: TextStyle(color: Colors.black45),
                          ),
                          edit
                              ? Row(
                                  children: [
                                    Flexible(
                                      child: TextFormField(
                                        onChanged: (value) => address = value,
                                        decoration: InputDecoration(
                                            hintText: "Type new address"),
                                      ),
                                    ),
                                  ],
                                )
                              : Text("")
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Phone",
                            textScaleFactor: 1.4,
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            person.phone,
                            textScaleFactor: 1.1,
                            style: TextStyle(color: Colors.black45),
                          ),
                          edit
                              ? Row(
                                  children: [
                                    Flexible(
                                      child: TextFormField(
                                        onChanged: (value) => contact = value,
                                        decoration: InputDecoration(
                                            hintText: "Type new contact"),
                                      ),
                                    ),
                                  ],
                                )
                              : Text("")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
