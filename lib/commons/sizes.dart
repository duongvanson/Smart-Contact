import 'package:flutter/material.dart';

class SizeApp {
  static double getSizeByWidth({BuildContext context, double percent}) {
    return percent / 100.0 * MediaQuery.of(context).size.width;
  }

  static double getSizeByHeight({BuildContext context, double percent}) {
    return percent / 100.0 * MediaQuery.of(context).size.height;
  }
}
