import 'package:fa_smart_contact/commons/strings.dart';
import 'package:fa_smart_contact/commons/styles.dart';
import 'package:fa_smart_contact/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShareContactPage extends StatelessWidget {
  Contact contact;

  ShareContactPage({this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringApp.title_share),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: QrImage(
                data: contact.toMap().toString(),
                version: QrVersions.auto,
                size: 250.0,
              ),
            ),
            Text(
              contact.name,
              style: StyleApp.style_avatar,
            ),
            Text(StringApp.content_qr_code),
          ],
        ),
      ),
    );
  }
}
