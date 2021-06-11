import 'package:donorpatient/widgets/mydrawer.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(20.0),
                  child: Image.asset(
                    "assets/images/doctor.png",
                    fit: BoxFit.contain,
                  )),
              Text(
                "DonorPatientApp",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15.0,),
              Text("An NGO initiative to make the process of donation easy."),
            ],
          ),
        ));
  }
}
