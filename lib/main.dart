import 'package:donorpatient/authenticate/authenticate.dart';
import 'package:donorpatient/authenticate/login.dart';
import 'package:donorpatient/home/about.dart';
import 'package:donorpatient/home/contact.dart';
import 'package:donorpatient/home/home.dart';
import 'package:donorpatient/home/mypatients.dart';
import 'package:donorpatient/home/patients.dart';
import 'package:donorpatient/home/profile.dart';
import 'package:donorpatient/models/user.dart';
import 'package:donorpatient/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => User(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool logedin = false;

  // void getuserstate() async {
  //   logedin = await PersonService.getUserState();
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: FutureBuilder(
      //   future: PersonService.getUserData(),
      //   builder: (context, snapshot) {
      //     // if (snapshot.hasData) {
      // if (snapshot!= null) {
      //   Provider.of<User>(context, listen: false).person = snapshot.data;
      //   return Home();
      // } else {
      //   return Authenticate();
      // }
      //     // }
      //     // return Scaffold(
      //     //   body: Center(
      //     //     child: CircularProgressIndicator(),
      //     //   ),

      //   },
      // ),
      home: Authenticate(),
      routes: {
        MyRoutes.homeRoute: (context) => Home(),
        MyRoutes.aboutusroute: (context) => About(),
        MyRoutes.contactusroute: (context) => Contact(),
        MyRoutes.loginRoute: (context) => Login(),
        MyRoutes.mypatientroute: (context) => MyPatients(),
        MyRoutes.patientroute: (context) => Patients(),
        MyRoutes.profileroute: (context) => Profile(),
        MyRoutes.wrapperroute: (context) => Authenticate()
      },
    );
  }
}
