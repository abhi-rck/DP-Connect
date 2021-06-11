// import 'package:donorpatient/models/person.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PersonService {
//   static saveUserState(bool value) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setBool("logedin", value);
//   }

//   static Future<bool> getUserState() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     //Return bool
//     bool boolValue = prefs.getBool('logedin');
//     if (boolValue == null) return false;
//     return boolValue;
//   }

//   static saveUserId(int value) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setInt("id", value);
//   }

//   static Future<Person> getUserData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     //Return bool

//     int id = prefs.getInt('id');
//     Person per = await Person.getUserData(id);
//     if (per == null) return null;
//     return per;
//   }
// }
