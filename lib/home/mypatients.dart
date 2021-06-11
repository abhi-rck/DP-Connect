import 'package:donorpatient/models/person.dart';
import 'package:donorpatient/models/user.dart';
import 'package:donorpatient/widgets/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPatients extends StatefulWidget {
  MyPatients({Key key}) : super(key: key);

  @override
  _MyPatientsState createState() => _MyPatientsState();
}



class _MyPatientsState extends State<MyPatients> {
  List<int> requests;
  int index = 0;

  String invert(String type){
    if(type=="donor"){
      return "Patients";
    }else
    return "Donors";
  }

  @override
  @override
  Widget build(BuildContext context) {
    Person person = Provider.of<User>(context).person;
    if (requests == null) requests = person.requestedRequests;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("My" +invert(person.usertype)),
      ),
      body: RequestList(requests: requests),
      // body: IndexedStack(
      //   index: index,
      //   children: [
      //     RequestList(requests:person.requestedRequests),
      //     RequestList(requests:person.connectedRequests),
      //     RequestList(requests:person.pendingRequests),
      //   ],),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2.0,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
            if (index == 1) {
              requests = person.connectedRequests;
            } else if (index == 2) {
              requests = person.pendingRequests;
            } else if (index == 0) {
              requests = person.requestedRequests;
            }
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_add_alt_1), label: "Requested"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Connected"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_add), label: "Pending"),
        ],
      ),
    );
  }
}

class RequestList extends StatefulWidget {
  final List<int> requests;
  RequestList({Key key, this.requests}) : super(key: key);

  @override
  _RequestListState createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: widget.requests.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                        leading: Icon(Icons.person_add),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.redAccent,
                          ),
                        ),
                        enableFeedback: true,
                        title: Text(
                            "Patient " + widget.requests[index].toString())),
                  ),
                );
              }),
        ),
      ),
    ]);
  }
}
