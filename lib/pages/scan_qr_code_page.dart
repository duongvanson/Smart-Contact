import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as Scanner;
class ScanQRCodePage extends StatefulWidget {
  String jsonContact;
  ScanQRCodePage({this.jsonContact});
  @override
  _ScanQRCodePageState createState() => _ScanQRCodePageState();
}

class _ScanQRCodePageState extends State<ScanQRCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
  Future<String> _scan() async {
    return await Scanner.scan();
  }
}
