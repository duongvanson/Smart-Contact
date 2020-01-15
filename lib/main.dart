import 'package:fa_smart_contact/commons/Strings.dart';
import 'package:fa_smart_contact/pages/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringApp.app_title,
      home: HomePage(),
    );
  }
}
