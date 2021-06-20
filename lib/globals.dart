import 'package:flutter/material.dart';
//this file contains all the global variables

class Drawerclass {
  static bool showMenu = false;
}

class Authcheck {
  static String process = 'login';
}

final grey = const Color(0xFFe0e3e3).withOpacity(0.5);

double height;
double width;
void media(BuildContext context) {
  height = MediaQuery.of(context).size.height;
  width = MediaQuery.of(context).size.width;
}
