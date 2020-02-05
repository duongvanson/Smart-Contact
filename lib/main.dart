import 'dart:convert';

import 'package:fa_smart_contact/commons/colors.dart';
import 'package:fa_smart_contact/commons/strings.dart';
import 'package:fa_smart_contact/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final jsonString = "{\"name\":15}";
//    Map<String, dynamic> books = json.decode(jsonString);
//    print(books);
    return MaterialApp(
      title: StringApp.app_title,
      color: ColorApp.main_color,
      home: HomePage(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: ColorApp.main_color,
        )
      ),
    );
  }
}
