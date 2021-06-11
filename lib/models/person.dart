import 'dart:convert';
import 'package:donorpatient/service/userservice.dart';
import 'package:http/http.dart' as http;

class Person {
  final String name;
  final String uid;
  final int id;
  final String address;
  final String phone;
  final String description;
  final String usertype;
  final String email;
  List<int> pendingRequests = [];
  List<int> requestedRequests = [];
  List<int> connectedRequests = [];

  Person(
    this.name,
    this.uid,
    this.id,
    this.address,
    this.phone,
    this.description,
    this.usertype,
    this.email,
  );

  factory Person.fromJson(Map<String, dynamic> json) {
    Person person = Person(
        json['name'],
        json['uid'],
        json['id'],
        json['address'],
        json['phone'],
        json['desc'],
        json['type'],
        json['email']);
    Map<String, dynamic> m = json['pendingRequests'];
    m.forEach((key, value) {
      person.pendingRequests.add(int.parse(key));
    });
    Map<String, dynamic> p = json['connectedRequests'];
    p.forEach((key, value) {
      person.connectedRequests.add(int.parse(key));
    });
    Map<String, dynamic> t = json['requestedRequests'];
    t.forEach((key, value) {
      person.requestedRequests.add(int.parse(key));
    });
    return person;
  }

  factory Person.fromMap(Map<dynamic, dynamic> model) {
    Person person = Person(model['name'], "", model['id'], model['address'],
        model['phone'], model['desc'], model['type'], model['email']);
    return person;
  }

  static Future<Person> createUser(String name, String email, String address,
      String desc, String phone, String usertype) async {
    final response = await http.post(
      Uri.http('10.0.2.2:9000', '/createuser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'address': address,
        'phone': phone,
        'type': usertype,
        'desc': desc
      }),
    );
    print(response.body);
    // PersonService.saveUserState(true);
    Person per = Person.fromJson(jsonDecode(response.body));
    print(per);
    return per;
  }

  static Future<Person> loginUser(String uid, int id) async {
    final response = await http.post(
      Uri.http('10.0.2.2:9000', '/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'id': id, 'uid': uid}),
    );
    try {
      print(response.body);
      Person person = Person.fromJson(jsonDecode(response.body));
      // PersonService.saveUserState(true);
      // PersonService.saveUserId(person.id);

      return person;
    } catch (e) {
      return null;
    }
  }

  static Future<Person> getUserData(int id) async {
    final response = await http.post(
      Uri.http('10.0.2.2:9000', '/getuser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'id': id}),
    );
    try {
      print(response.body);
      Person person = Person.fromJson(jsonDecode(response.body));
      // PersonService.saveUserState(true);
      // PersonService.saveUserId(person.id);
      return person;
    } catch (e) {
      return null;
    }
  }

  static Future<Person> updateUserInfo(
      String uid, String address, String contact) async {
    final response = await http.post(
      Uri.http('10.0.2.2:9000', '/upadteuserdata'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'uid': uid, 'phone': contact, 'address': address}),
    );
    try {
      print(response.body);
      Person person = Person.fromJson(jsonDecode(response.body));
      // PersonService.saveUserState(true);
      // PersonService.saveUserId(person.id);
      return person;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Person>> getAllDonors(String uid) async {
    final response = await http.post(
      Uri.http('10.0.2.2:9000', '/getalldonors'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'uid': uid}),
    );
    try {
      print(response.body);
      List<dynamic> l = jsonDecode(response.body);

      List<Person> persons =
          List<Person>.from(l.map((model) => Person.fromMap(model)));
      return persons;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Person>> getAllPatients(String uid) async {
    final response = await http.post(
      Uri.http('10.0.2.2:9000', '/getallpatients'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'uid': uid}),
    );
    try {
      print(response.body);
      List<dynamic> l = jsonDecode(response.body);

      List<Person> persons =
          List<Person>.from(l.map((model) => Person.fromMap(model)));
      // PersonService.saveUserState(true);
      // PersonService.saveUserId(person.id);

      return persons;
    } catch (e) {
      return null;
    }
  }
// {"id":1,"uid":"1621683949112256200","name":"sdfgh","email":"dxfcgh","address":"dxfcghj","phone":"dxfxgh","type":"donor","desc":"","pendingRequests":{},"requestedRequests":{},"connectedRequests":{}}
// {"id":2,"uid":"1621683997653667300","name":"sdfghj","email":"dfghj","address":"cvbnm","phone":"dfghj","type":"patient","desc":"sdfghj","pendingRequests":{},"requestedRequests":{},"connectedRequests":{}}
  static Future<void> sendRequest(String uid, int id) async {
    print(uid);
    print(id);
    final response = await http.post(
      Uri.http('10.0.2.2:9000', '/sendrequest'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'uid': uid, 'requestedId': id}),
    );
    try {
      print(response.body);
      // List<dynamic> l = jsonDecode(response.body);
      // PersonService.saveUserState(true);
      // PersonService.saveUserId(person.id);
      return;
    } catch (e) {
      return;
    }
  }
}
