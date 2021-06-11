import 'package:flutter/cupertino.dart';

class MyRoute {
  final String name;
  final IconData icon;
  final String route;

  MyRoute(this.name, this.icon, this.route);
}

class MyRoutes {
  static final homeRoute = "/home";
  static final loginRoute = "/login";
  static final profileroute = "/profile";
  static final patientroute = "/pateins";
  static final mypatientroute = "/mypatient";
  static final aboutusroute = "/about";
  static final contactusroute = "/contact";
  static final wrapperroute = "/wrapper";
}
