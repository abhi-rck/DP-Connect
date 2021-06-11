import 'package:donorpatient/models/person.dart';
import 'package:donorpatient/models/user.dart';
import 'package:donorpatient/routes/route.dart';
import 'package:donorpatient/service/userservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final List<MyRoute> list2 = [
    MyRoute("Patients", Icons.person_add_rounded, MyRoutes.patientroute),
    MyRoute("My Profile", Icons.person, MyRoutes.profileroute),
    MyRoute("My Patients", Icons.accessibility_sharp, MyRoutes.mypatientroute),
    MyRoute("About Us", Icons.clear_all, MyRoutes.aboutusroute),
    MyRoute("Contact Us", Icons.contactless_sharp, MyRoutes.contactusroute),
  ];

  final List<MyRoute> list1 = [
    MyRoute("Donors", Icons.person_add_rounded, MyRoutes.patientroute),
    MyRoute("My Profile", Icons.person, MyRoutes.profileroute),
    MyRoute("My Donors", Icons.accessibility_sharp, MyRoutes.mypatientroute),
    MyRoute("About Us", Icons.clear_all, MyRoutes.aboutusroute),
    MyRoute("Contact Us", Icons.contactless_sharp, MyRoutes.contactusroute),
  ];
  List<MyRoute> list = [];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: [
            Image.asset(
              "assets/images/medical.png",
            ),
            Consumer<User>(builder: (context, user, child) {
              String persontype = user.person.usertype;
              if (persontype == "donor") {
                list = list2;
              } else {
                list = list1;
              }
              return Container(
                height: 300.0,
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (snapshot, index) {
                      return ListTile(
                        title: Text(list[index].name),
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, list[index].route);
                        },
                        leading: Icon(list[index].icon),
                      );
                    }),
              );
            }),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              onPressed: () async {
                // await PersonService.saveUserState(false);
                // await PersonService.saveUserId(-1);
                Provider.of<User>(context, listen: false).person = null;
                Navigator.pushReplacementNamed(context, MyRoutes.wrapperroute);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.logout), Text("Log Out")],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
