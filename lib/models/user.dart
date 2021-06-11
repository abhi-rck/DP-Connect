import 'package:donorpatient/models/person.dart';
import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  Person person;

  void loggedPerson(Person newPerson) {
    person = newPerson;
    notifyListeners();
  }
}
