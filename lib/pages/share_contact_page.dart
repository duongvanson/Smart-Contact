import 'package:encrypt/encrypt.dart';
import 'package:fa_smart_contact/commons/strings.dart';
import 'package:fa_smart_contact/commons/styles.dart';
import 'package:fa_smart_contact/encrypt/key.dart';
import 'package:fa_smart_contact/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:encrypt/encrypt.dart' as EN;
class ShareContactPage extends StatelessWidget {
  Contact contact;
  ShareContactPage({this.contact});
  @override
  Widget build(BuildContext context){
    print(KeyApp.enCode(contact));
    //print(KeyApp.deCode(KeyApp.enCode(contact)));
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
