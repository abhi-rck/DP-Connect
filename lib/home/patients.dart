import 'package:donorpatient/models/person.dart';
import 'package:donorpatient/models/user.dart';
import 'package:donorpatient/widgets/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Patients extends StatefulWidget {
  Patients({Key key}) : super(key: key);

  @override
  _PatientsState createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  @override
  void initState() {
    super.initState();
  }

  String invert(String type) {
    if (type == "donor") {
      return "Patients";
    } else
      return "Donors";
  }

  @override
  Widget build(BuildContext context) {
    Person person = Provider.of<User>(context).person;
    String uid = person.uid;
    print(uid);
    return Scaffold(
        appBar: AppBar(title: Text(invert(person.usertype))),
        drawer: MyDrawer(),
        body: FutureBuilder<List<Person>>(
          future: person.usertype == "donor"
              ? Person.getAllPatients(uid)
              : Person.getAllDonors(uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Person> list = snapshot.data;
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        subtitle: Text(list[index].address),
                        trailing: IconButton(
                          onPressed: () async {
                            await Person.sendRequest(uid, list[index].id);
                            Person newperson =
                                await Person.getUserData(person.id);
                            Provider.of<User>(context, listen: false)
                                .loggedPerson(newperson);
                            setState(() {});
                          },
                          icon: Icon(Icons.person_add),
                        ),
                        title: Text(list[index].name),
                      ),
                    );
                  });
            }
            return CircularProgressIndicator();
          },
        ));
  }
}
